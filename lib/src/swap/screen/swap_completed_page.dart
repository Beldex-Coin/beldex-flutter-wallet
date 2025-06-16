import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:beldex_wallet/src/swap/util/circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../../routes.dart';
import '../../widgets/no_internet.dart';
import '../api_client/get_status_api_client.dart';
import '../dialog/input_output_hash_dialog.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapCompletedPage extends BasePage {
  SwapCompletedPage({required this.transactionStatus});

  final TransactionStatus transactionStatus;

  @override
  bool get isModalBackButton => false;

  @override
  String getTitle(AppLocalizations t) => 'Swap';

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
    return SwapCompletedHome(transactionStatus: transactionStatus);
  }
}

class SwapCompletedHome extends StatefulWidget {
  SwapCompletedHome({required this.transactionStatus});

  final TransactionStatus transactionStatus;

  @override
  State<SwapCompletedHome> createState() => _SwapCompletedHomeState();
}

class _SwapCompletedHomeState extends State<SwapCompletedHome> {
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

  late TransactionStatus transactionStatus;
  late Timer timer;
  late GetStatusApiClient getStatusApiClient;
  late StreamController<GetStatusModel> _getStatusStreamController;
  late FlutterSecureStorage secureStorage;
  late List<String> stored = [];
  late GetTransactionsProvider getTransactionsProvider;
  bool _isInitialized = false;

  @override
  void initState() {
    transactionStatus = widget.transactionStatus;
    secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    getTransactionsIds(secureStorage, transactionIds: (ids) {
      stored = ids;
    });
    Future.delayed(Duration(seconds: 2), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetTransactionsProvider>(context, listen: false)
            .getTransactionsData(
            context, {"id": "${transactionStatus.transactionModel.result?.id}"});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    ToastContext().init(context);
    return Consumer<GetTransactionsProvider>(
        builder: (context, getTransactionsProvider, child) {
          this.getTransactionsProvider = getTransactionsProvider;
          _isInitialized = true;
          if (getTransactionsProvider.loading) {
            return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0));
          }

          if(getTransactionsProvider.error != null || !isOnline(context)) {
            return noInternet(settingsStore, _screenWidth);
          }

          if (getTransactionsProvider.loading == false && getTransactionsProvider.data!.result!.isNotEmpty) {
            return body(
                _screenWidth,
                _screenHeight,
                settingsStore,
                _scrollController,getTransactionsProvider.data);
          }

          return SizedBox();
        });
  }

  Widget body(
      double _screenWidth,
      double _screenHeight,
      SettingsStore settingsStore,
      ScrollController _scrollController, GetTransactionsModel? transactionModel,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: NumberStepper(
            totalSteps: stepLength,
            width: MediaQuery.of(context).size.width,
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
                          margin:
                          EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
                          elevation: 0,
                          color: settingsStore.isDarkTheme
                              ? Color(0xff24242f)
                              : Color(0xfff3f3f3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: _screenWidth,
                            height: double.infinity,
                            child: exchangeCompletedScreen(settingsStore, transactionModel),
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ],
    );
  }

  Widget exchangeCompletedScreen(SettingsStore settingsStore, GetTransactionsModel? transactionModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Completed Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 6, right: 6, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Completed Title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/swap/swap_completed.svg',
                    colorFilter: ColorFilter.mode(Color(0xff159B24), BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff159B24)),
                  ),
                ],
              ),
              //Transaction ID Details
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding: EdgeInsets.all(10),
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
                          'Transaction ID',
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
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: transactionModel.result![0].id!));
                                Toast.show(
                                  tr(context).copied,
                                  duration: Toast
                                      .lengthShort, // Toast duration (short or long)
                                  gravity: Toast
                                      .bottom,
                                  textStyle: TextStyle(color: settingsStore.isDarkTheme ? Colors.black : Colors.white),// Toast gravity (top, center, or bottom)// Text color
                                  backgroundColor: settingsStore.isDarkTheme ? Colors.grey.shade50 :Colors.grey.shade900,
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
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount from',
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
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount to',
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
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Received Time',
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
                            getDateAndTime(transactionModel.result![0].moneyReceived!),
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
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount Sent',
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
                            getDateAndTime(transactionModel.result![0].moneySent!),
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
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Exchange Rate',
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
                            '1 ${transactionModel.result![0].currencyFrom?.toUpperCase()} ~ ${transactionModel.result![0].rate} ${transactionModel.result![0].currencyTo?.toUpperCase()}',
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
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Network fee',
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
                            '${transactionModel.result![0].networkFee} ${transactionModel.result![0].currencyTo?.toUpperCase()}',
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
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipient Address',
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
                      transactionModel.result![0].payoutAddress!,
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
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
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
              )
            ],
          ),
        ),
        Table(
          children: [
            //Input Hash and Output Hash
            TableRow(children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {
                    showAlertDialog(context, transactionModel.result![0].payinHash!, transactionModel.result![0].payoutHash!);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: settingsStore.isDarkTheme
                        ? Color(0xff242433)
                        : Color(0xffDADADA),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff41415B)
                                : Color(0xffF3F3F3))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_input_hash.svg',
                          colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373), BlendMode.srcIn),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text('Input/Output Hash',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffffffff)
                                    : Color(0xff222222),
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            //Open History and New Transaction
            TableRow(children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {
                    if(isOnline(context)) {
                      final FlutterSecureStorage secureStorage = FlutterSecureStorage();
                      Navigator.of(context).pop(true);
                      Navigator.of(context).pushNamed(Routes.swapTransactionList, arguments: SwapTransactionHistory(stored, secureStorage));
                    } else {
                      Toast.show(
                        'Network Error! Please check internet connection.',
                        duration: Toast.lengthShort,
                        gravity: Toast.bottom,
                        textStyle:TextStyle(color: Colors.white),
                        backgroundColor: Color(0xff8B1C1C),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: settingsStore.isDarkTheme
                        ? Color(0xff32324A)
                        : Color(0xffFFFFFF),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Open History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: settingsStore.isDarkTheme
                              ? Color(0xffffffff)
                              : Color(0xff222222),
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  onPressed: () {
                    if(isOnline(context)) {
                      Navigator.of(context).pop(true);
                      Navigator.of(context, rootNavigator: true).pushNamed(
                          Routes.swapExchange);
                    } else {
                      Toast.show(
                        'Network Error! Please check internet connection.',
                        duration: Toast.lengthShort,
                        gravity: Toast.bottom,
                        textStyle:TextStyle(color: Colors.white),
                        backgroundColor: Color(0xff8B1C1C),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0BA70F),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/images/swap/swap_restart.svg',
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          width: 12,
                          height: 12,
                        ),
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        flex: 3,
                        child: Text('New Transaction',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ],
        )
      ],
    );
  }

  Future showAlertDialog(BuildContext context, String inputHash, String outputHash) async {
    await showInputOutputDialog(context, inputHash,
      outputHash,
      onDismiss: (context) => Navigator.of(context).pop(true),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _getStatusStreamController.close();
    if(_isInitialized) {
      getTransactionsProvider.dispose();
    }
    super.dispose();
  }
}
