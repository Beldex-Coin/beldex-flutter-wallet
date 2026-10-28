import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../routes.dart';
import '../../util/clipboard_helper.dart';
import '../../util/network_provider.dart';
import '../../widgets/no_internet.dart';
import '../dialog/input_output_hash_dialog.dart';
import '../model/get_transactions_model.dart';
import '../provider/get_transactions_provider.dart';
import '../util/circular_progress_bar.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapTransactionCompletedPage extends BasePage {
  SwapTransactionCompletedPage({required this.transactionStatus});

  final GetTransactionStatus transactionStatus;

  @override
  bool get isModalBackButton => false;

  @override
  String getTitle(AppLocalizations t) => t.swap;

  @override
  Color get textColor => Colors.white;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget? leading(BuildContext context) {
    return leadingIcon(context);
  }

  @override
  Widget body(BuildContext context) {
    return SwapTransactionCompletedHome(transactionStatus: transactionStatus);
  }
}

class SwapTransactionCompletedHome extends StatefulWidget {
  SwapTransactionCompletedHome({required this.transactionStatus});

  final GetTransactionStatus transactionStatus;

  @override
  State<SwapTransactionCompletedHome> createState() =>
      _SwapTransactionCompletedHomeState();
}

class _SwapTransactionCompletedHomeState
    extends State<SwapTransactionCompletedHome> {
  int currentStep = 4;
  int stepLength = 4;
  bool complete = true;

  void next() {
    if (currentStep <= stepLength) {
      goTo(currentStep + 1);
    }
  }

  void back() {
    if (currentStep > 1) {
      goTo(currentStep - 1);
    }
  }

  void goTo(int step) {
    setState(() => currentStep = step);
    if (currentStep > stepLength) {
      setState(() => complete = true);
    }
  }

  late GetTransactionStatus transactionStatus;
  late GetTransactionsProvider getTransactionsProvider;
  late NetworkProvider networkProvider;
  bool _isInitialized = false;

  @override
  void initState() {
    transactionStatus = widget.transactionStatus;
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Provider.of<GetTransactionsProvider>(context, listen: false)
            .getTransactionsData(
                context,
                {
                  "id": "${transactionStatus.transactionModel.txnId}",
                  "destinationAddress":
                      "${transactionStatus.transactionModel.payoutAddress}"
                },
                exchangeName: transactionStatus.exchangeName);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.sizeOf(context).width;
    final _screenHeight = MediaQuery.sizeOf(context).height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    return Consumer<NetworkProvider>(
        builder: (context, networkProvider, child) {
      return Consumer<GetTransactionsProvider>(
          builder: (context, getTransactionsProvider, child) {
        this.getTransactionsProvider = getTransactionsProvider;
        this.networkProvider = networkProvider;
        _isInitialized = true;
        if (getTransactionsProvider.loading) {
          return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0));
        }

        if (getTransactionsProvider.error != null ||
            !networkProvider.isConnected) {
          return noInternet(settingsStore, _screenWidth, tr(context));
        }

        if (getTransactionsProvider.loading == false &&
            getTransactionsProvider.data!.result!.isNotEmpty) {
          return body(_screenWidth, _screenHeight, settingsStore,
              _scrollController, getTransactionsProvider.data, networkProvider);
        }

        return SizedBox();
      });
    });
  }

  Widget body(
    double _screenWidth,
    double _screenHeight,
    SettingsStore settingsStore,
    ScrollController _scrollController,
    GetTransactionsModel? transactionModel,
    NetworkProvider networkProvider,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: NumberStepper(
            totalSteps: stepLength,
            width: MediaQuery.sizeOf(context).width,
            curStep: currentStep,
            stepCompleteColor: Colors.blue,
            currentStepColor: Color(0xff20D030),
            inactiveColor: Color(0xffbababa),
            lineWidth: 2,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Card(
                  margin: EdgeInsetsDirectional.only(
                      top: 15, start: 10, end: 10, bottom: 15),
                  elevation: 0,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff24242f)
                      : Color(0xfff3f3f3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(15.0),
                    width: _screenWidth,
                    height: double.infinity,
                    child: exchangeCompletedScreen(
                        settingsStore, transactionModel, networkProvider),
                  ),
                ),
              ),
            ));
          }),
        ),
      ],
    );
  }

  Widget exchangeCompletedScreen(SettingsStore settingsStore,
      GetTransactionsModel? transactionModel, NetworkProvider networkProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PairsWidget(
            settingsStore: settingsStore,
            from: transactionModel?.result![0].currencyFrom,
            to: transactionModel?.result![0].currencyTo),
        //Completed Details
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin:
              EdgeInsetsDirectional.only(start: 6, end: 6, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Completed Title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/swap/swap_completed.svg',
                    colorFilter:
                        ColorFilter.mode(Color(0xff159B24), BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    tr(context).swap_completed,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff159B24)),
                  ),
                ],
              ),
              //Transaction ID Details
              Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsetsDirectional.only(top: 10.0, bottom: 10.0),
                  padding: EdgeInsetsDirectional.all(10),
                  decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme
                        ? Colors.transparent
                        : Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff484856)
                          : Color(0xffDADADA),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          tr(context).transaction_details_transaction_id,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                transactionModel!.result![0].id!,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff222222)),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                await ClipboardHelper.copyWithAutoClear(
                                    transactionModel.result![0].id!);
                                await Fluttertoast.showToast(
                                  msg: tr(context).copied,
                                  toastLength: Toast.LENGTH_SHORT,
                                  // Toast duration (short or long)
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: settingsStore.isDarkTheme
                                      ? Colors.black
                                      : Colors.white,
                                  // Toast gravity (top, center, or bottom)// Text color
                                  backgroundColor: settingsStore.isDarkTheme
                                      ? Colors.grey.shade50
                                      : Colors.grey.shade900,
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                color: Color(0xff20D030),
                                size: 14,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),

              Table(
                children: [
                  //Amount from and Amount To Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context).swap_amount_from,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${toStringAsFixed(transactionModel.result![0].amountExpectedFrom)} ${transactionModel.result![0].currencyFrom!.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 10.0, start: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context).swap_amount_to,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${toStringAsFixed(transactionModel.result![0].amountExpectedTo)} ${transactionModel.result![0].currencyTo!.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                  //Received Time and Amount Sent Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context).swap_received_time,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            getDateAndTime(
                              transactionModel.result![0].moneyReceived!,
                              locale:
                                  Localizations.localeOf(context).languageCode,
                            ),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 10.0, start: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context).swap_amount_sent,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            getDateAndTime(
                              transactionModel.result![0].moneySent!,
                              locale:
                                  Localizations.localeOf(context).languageCode,
                            ),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                  //Exchange Rate and Network fee Details
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context).exchangeRate,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '1 ${transactionModel.result![0].currencyFrom?.toUpperCase()} ~ ${toStringAsFixed(transactionModel.result![0].rate)} ${transactionModel.result![0].currencyTo?.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 10.0, start: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr(context).swap_network_fee,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff737373)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${toStringAsFixed(transactionModel.result![0].networkFee)} ${transactionModel.result![0].currencyTo?.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                        ],
                      ),
                    )
                  ]),
                ],
              ),
              //Recipient Address Details
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: EdgeInsetsDirectional.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr(context).transaction_details_recipient_address,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      transactionModel.result![0].payinAddress!,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)),
                    ),
                  ],
                ),
              ),
              //Memo Details
              Visibility(
                visible: transactionModel.result![0].payinExtraId != null,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsetsDirectional.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionModel.result![0].payinExtraIdName ?? "---",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff737373)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        transactionModel.result![0].payinExtraId ?? "---",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        //Input Hash and Output Hash
        ElevatedButton(
          onPressed: () {
            showAlertDialog(
              context,
              transactionModel.result![0].payinHash!,
              transactionModel.result![0].payoutHash!,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: settingsStore.isDarkTheme
                ? const Color(0xff242433)
                : const Color(0xffDADADA),
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: settingsStore.isDarkTheme
                    ? const Color(0xff41415B)
                    : const Color(0xffF3F3F3),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/swap/swap_input_hash.svg',
                colorFilter: ColorFilter.mode(
                  settingsStore.isDarkTheme
                      ? const Color(0xffAFAFBE)
                      : const Color(0xff737373),
                  BlendMode.srcIn,
                ),
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  tr(context).swap_input_output_hash,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    color: settingsStore.isDarkTheme
                        ? const Color(0xffffffff)
                        : const Color(0xff222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        //Open History and New Transaction
        Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (networkProvider.isConnected) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.swapTransactionList, (route) => route.isFirst,
                      arguments: SwapTransactionHistory(
                          transactionStatus.walletAddress,
                          exchangeName: transactionStatus.exchangeName));
                } else {
                  Fluttertoast.showToast(
                    msg: tr(context).networkErrorCheckConnection,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                    backgroundColor: Color(0xff8B1C1C),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: settingsStore.isDarkTheme
                    ? Color(0xff32324A)
                    : Color(0xffFFFFFF),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 9,
                ),
                minimumSize: const Size(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(tr(context).swap_open_history,
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: settingsStore.isDarkTheme
                          ? Color(0xffffffff)
                          : Color(0xff222222),
                      fontSize: 13,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (networkProvider.isConnected) {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil(
                      Routes.swapExchange, (route) => route.isFirst,
                      arguments: transactionStatus.walletAddress);
                } else {
                  Fluttertoast.showToast(
                    msg: tr(context).networkErrorCheckConnection,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                    backgroundColor: Color(0xff8B1C1C),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0BA70F),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 9,
                ),
                minimumSize: const Size(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/swap/swap_restart.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      tr(context).swap_new_transaction,
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Future showAlertDialog(
      BuildContext context, String inputHash, String outputHash) async {
    await showInputOutputDialog(
      context,
      inputHash,
      outputHash,
      onDismiss: (context) => Navigator.of(context).pop(true),
    );
  }

  @override
  void dispose() {
    if (_isInitialized) {
      getTransactionsProvider.dispose();
    }
    super.dispose();
  }
}
