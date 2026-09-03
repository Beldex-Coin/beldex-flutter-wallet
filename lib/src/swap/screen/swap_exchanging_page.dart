import 'dart:async';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/database/swap_transaction_history_model.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../palette.dart';
import '../../../routes.dart';
import '../../util/clipboard_helper.dart';
import '../../util/network_provider.dart';
import '../../widgets/no_internet.dart';
import '../exchange/exchange_manager.dart';
import '../provider/get_currencies_full_provider.dart';
import '../util/circular_progress_bar.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import '../database/swap_txn_history.dart';
import 'number_stepper.dart';

class SwapExchangingPage extends BasePage {
  SwapExchangingPage({required this.transactionDetails});

  final TransactionDataWithWalletAddress transactionDetails;

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
    return SwapExchangingHome(transactionDetails: transactionDetails);
  }
}

class SwapExchangingHome extends StatefulWidget {
  SwapExchangingHome({required this.transactionDetails});

  final TransactionDataWithWalletAddress transactionDetails;

  @override
  State<SwapExchangingHome> createState() => _SwapExchangingHomeState();
}

class _SwapExchangingHomeState extends State<SwapExchangingHome> {
  int currentStep = 4;
  int stepLength = 4;
  bool complete = false;

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

  late SwapTransactionHistoryModel transactionDetails;
  String _walletAddress = "";
  late Timer timer;
  late StreamController<GetTransactionsModel> _getStatusStreamController;
  static const methodChannelPlatform = MethodChannel("io.beldex.wallet/beldex_wallet_channel");
  late GetCurrenciesFullProvider getCurrenciesFullProvider;
  late GetTransactionsProvider getTransactionsProvider;
  bool _isInitializedCurrencyFullProvider = false;
  bool _isInitializedTransactionsProvider = false;
  bool _errorShownCurrencyFull = false;
  bool _errorShownTransactions = false;
  late NetworkProvider networkProvider;

  @override
  void initState() {
    transactionDetails = widget.transactionDetails.transactionModel;
    _walletAddress = widget.transactionDetails.walletAddress;
    // Create a stream controller and get status to the stream.
    _getStatusStreamController = StreamController<GetTransactionsModel>();
    getTransactionsProvider = Provider.of<GetTransactionsProvider>(context, listen: false);
    getTransactionsProvider.addListener(_onStatusUpdate);
    Future.delayed(Duration(seconds: 2), () {
      _pollStatus();
      if (!mounted) return;
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !networkProvider.isConnected) return;
        _pollStatus();
      }); // Start adding getStatus api result to the stream.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetCurrenciesFullProvider>(context, listen: false).getCurrenciesFullData(context);
      });
    });
    super.initState();
  }

  void _pollStatus() {
    final exchangeName = widget.transactionDetails.exchangeName ?? ExchangeManager.selectedType?.name ?? 'changelly';
    getTransactionsProvider.getTransactionsData(context, {"id": "${transactionDetails.txnId}", "destinationAddress": "${transactionDetails.payoutAddress}"}, exchangeName: exchangeName);
  }

  void _onStatusUpdate() {
    final value = getTransactionsProvider.data;
    if (value == null || value.result == null || value.result!.isEmpty) return;
    if (!_getStatusStreamController.isClosed) {
      _getStatusStreamController.sink.add(value);
    }
    final status = value.result!.first.status ?? '';
    switch (status) {
      case "finished" :
        {
          //Completed Screen
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
            Navigator.of(context).pushNamed(Routes.swapCompleted,
                arguments: TransactionStatus(
                    transactionDetails, status, _walletAddress, exchangeName: widget.transactionDetails.exchangeName ?? ExchangeManager.selectedType?.name ?? 'changelly'));
          });
          break;
        }
      case "refunded" :
        {
          break;
        }
      case "failed" :
      case "overdue" :
      case "expired" :
        {
          //Failed, Overdue and Expired Screen
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
            Navigator.of(context).pushNamed(Routes.swapUnPaid,
                arguments: TransactionStatus(
                    transactionDetails, status, _walletAddress, exchangeName: widget.transactionDetails.exchangeName ?? ExchangeManager.selectedType?.name ?? 'changelly'));
          });
          break;
        }
      default: {
        break;
      }
    }
  }

  String? _txStatus(GetTransactionsModel? model) {
    if (model == null || model.result == null || model.result!.isEmpty) {
      return null;
    }
    return model.result!.first.status;
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.sizeOf(context).width;
    final _screenHeight = MediaQuery.sizeOf(context).height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    return Consumer<NetworkProvider>(
        builder: (context, networkProvider, child) {
          this.networkProvider = networkProvider;
        return StreamBuilder<GetTransactionsModel>(
          stream: _getStatusStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0)); // Display a loading indicator when waiting for data.
            } else if (snapshot.hasError || !snapshot.hasData || !networkProvider.isConnected) {
              return noInternet(settingsStore, _screenWidth); // Display an error message if an error occurs. or Display a message when no data is available.
            } else {
              return body(
                  _screenWidth,
                  _screenHeight,
                  settingsStore,
                  _scrollController,
                  snapshot.data,
                  transactionDetails, networkProvider);
            }
          },
        );
      }
    );
  }

  Widget body(
    double _screenWidth,
    double _screenHeight,
    SettingsStore settingsStore,
    ScrollController _scrollController,
    GetTransactionsModel? responseData,
    SwapTransactionHistoryModel transactionDetails, NetworkProvider networkProvider,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    child: exchangingScreen(
                        settingsStore, responseData, transactionDetails, networkProvider),
                  ),
                ),
              ),
            ));
          }),
        ),
      ],
    );
  }


  Widget exchangingScreen(SettingsStore settingsStore,
      GetTransactionsModel? responseData, SwapTransactionHistoryModel transactionDetails, NetworkProvider networkProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PairsWidget(settingsStore: settingsStore, from: transactionDetails.currencyFrom, to: transactionDetails.currencyTo),
        //Exchanging Title
        Text(
          'Exchanging',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //Progress bar
        Container(
          height: 3,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: LinearProgressIndicator(
            backgroundColor: settingsStore.isDarkTheme
                ? Color(0xff32324A)
                : Color(0xffFFFFFF),
            valueColor: AlwaysStoppedAnimation<Color>(BeldexPalette.belgreen),
            value: responseData!.result!.isNotEmpty &&
                _txStatus(responseData) == "confirming" ? 0.3 : _txStatus(responseData) == "exchanging"
            ? 0.6 : _txStatus(responseData) == "sending" ? 0.9 : _txStatus(responseData) == "finished" ? 1.0 : 0.0,
          ),
        ),
        Container(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                //Confirming in progress Details
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: (_txStatus(responseData)?.isNotEmpty ?? false) &&
                        _txStatus(responseData) == "confirming"
                        ? SizedBox(
                        width: 15,
                        height: 15,
                        child: circularProgressBar(Color(0xff0BA70F), 2.0))
                        : SvgPicture.asset(
                      'assets/images/swap/swap_confirmed.svg',
                      colorFilter: ColorFilter.mode((_txStatus(responseData)?.isNotEmpty ?? false) &&
                          (_txStatus(responseData) == "exchanging" || _txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373), BlendMode.srcIn),
                      width: 15,
                      height: 15,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment : MainAxisAlignment.start,
                          children: [
                            Text(
                              (_txStatus(responseData) == "exchanging" || _txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? 'Confirmed' :'Confirming in progress',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff222222)),
                            ),
                            SizedBox(width: 5,),
                            (_txStatus(responseData) == "exchanging" || _txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? SvgPicture.asset(
                              'assets/images/swap/swap_done.svg',
                              colorFilter: ColorFilter.mode((_txStatus(responseData)?.isNotEmpty ?? false) &&
                                  (_txStatus(responseData) == "exchanging" || _txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373), BlendMode.srcIn),
                              width: 12,
                              height: 12,
                            ) : Container(),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Once ${transactionDetails.currencyFrom.toUpperCase()} is confirmed in the blockchain, we’ll start exchanging it to ${transactionDetails.currencyTo.toUpperCase()}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                        SizedBox(height: 5),
                        Consumer<GetCurrenciesFullProvider>(
                            builder: (context, getCurrenciesFullProvider, child) {
                              this.getCurrenciesFullProvider = getCurrenciesFullProvider;
                              _isInitializedCurrencyFullProvider = true;
                              if(getCurrenciesFullProvider.error != null && !_errorShownCurrencyFull) {
                                _errorShownCurrencyFull = true;
                                Fluttertoast.showToast(
                                  msg: tr(context).networkErrorCheckConnection,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.white,
                                  backgroundColor: Color(0xff8B1C1C),
                                );
                              }
                              if (getCurrenciesFullProvider.loading) {
                                return Center(child: circularProgressBar(Color(0xff0BA70F), 1.0));
                              } else {
                                if (getCurrenciesFullProvider.data.isNotEmpty &&
                                    getCurrenciesFullProvider.loading == false) {
                                  final currencyDetails = getCurrenciesFullProvider.data;
                                  return InkWell(
                                    onTap: (){
                                      currencyDetails.forEach((item){
                                        if(item.ticker == transactionDetails.currencyFrom) {
                                          final url = processUrl(item.transactionUrl, responseData.result?[0].payinHash);
                                          if(url.trim().isNotEmpty){
                                            openUrl(methodChannelPlatform: methodChannelPlatform, url: url);
                                          }
                                        }
                                      });
                                    },
                                    child: Text(
                                      'See input hash in explorer',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xffEBEBEB)
                                              : Color(0xff222222)),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                            })
                      ],
                    ),
                  )
                ]),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  height: 1,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff8787A8)
                      : Color(0xffDADADA),
                ),
                //Exchanging CurrencyFrom to CurrencyTo
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: (_txStatus(responseData)?.isNotEmpty ?? false) &&
                        _txStatus(responseData) == "exchanging"
                        ? SizedBox(
                        width: 15,
                        height: 15,
                        child: circularProgressBar(Color(0xff0BA70F), 2.0))
                        : Transform.rotate(
                          angle: 90 * pi / 180,
                          child: SvgPicture.asset(
                            'assets/images/swap/swap.svg',
                            colorFilter: ColorFilter.mode((_txStatus(responseData)?.isNotEmpty ?? false) &&
                                (_txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff737373), BlendMode.srcIn),
                            width: 15,
                            height: 15,
                          ),
                        ),
                  ),
                  SizedBox(width: 10),
                  (_txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ?
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Done Exchanging ${transactionDetails.currencyFrom.toUpperCase()} to ${transactionDetails.currencyTo.toUpperCase()}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222)),
                        ),
                        SizedBox(height: 5),
                        (_txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? SvgPicture.asset(
                          'assets/images/swap/swap_done.svg',
                          colorFilter: ColorFilter.mode((_txStatus(responseData)?.isNotEmpty ?? false) &&
                              (_txStatus(responseData) == "sending" || _txStatus(responseData) == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373), BlendMode.srcIn),
                          width: 12,
                          height: 12,
                        ) : Container(),
                      ],
                    ),
                  ) :
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exchanging ${transactionDetails.currencyFrom.toUpperCase()} to ${transactionDetails..currencyTo.toUpperCase()}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'The process will take a few minutes. please wait.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                      ],
                    ),
                  )
                ]),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  height: 1,
                  color: settingsStore.isDarkTheme
                      ? Color(0xff8787A8)
                      : Color(0xffDADADA),
                ),
                //Sending funds to your wallet
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: (_txStatus(responseData)?.isNotEmpty ?? false) &&
                        _txStatus(responseData) == "sending"
                        ? SizedBox(
                        width: 15,
                        height: 15,
                        child: circularProgressBar(Color(0xff0BA70F), 2.0))
                        : SvgPicture.asset(
                      'assets/images/swap/swap_wallet.svg',
                      colorFilter: ColorFilter.mode((_txStatus(responseData)?.isNotEmpty ?? false) &&
                          _txStatus(responseData) == "finished" ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373), BlendMode.srcIn),
                      width: 15,
                      height: 15,
                    ),
                  ),
                  SizedBox(width: 10),
                  (_txStatus(responseData) == "finished") ?
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Funds send to your wallet',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222)),
                        ),
                        SizedBox(height: 5),
                        (_txStatus(responseData) == "finished") ? SvgPicture.asset(
                          'assets/images/swap/swap_done.svg',
                          colorFilter: ColorFilter.mode( (_txStatus(responseData)?.isNotEmpty ?? false) &&
                              (_txStatus(responseData) == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373), BlendMode.srcIn),
                          width: 12,
                          height: 12,
                        ) : Container(),
                      ],
                    ),
                  ) :
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sending funds to your wallet',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'The process will take a few minutes. please wait.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                      ],
                    ),
                  )
                ]),
              ],
            )),
        //History Option Details
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin: EdgeInsets.only(top: 25, bottom: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Color(0xff32324A)
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You don’t have to wait here',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff222222))),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text:
                    'You can initiate a new transaction.You can always check the status of this transaction in transaction ',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
                    children: [
                      WidgetSpan(child: InkWell(
                        onTap: networkProvider.isConnected ? () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pushNamed(Routes.swapTransactionList, arguments: SwapTransactionHistory(widget.transactionDetails.walletAddress, exchangeName: widget.transactionDetails.exchangeName ?? ExchangeManager.selectedType?.name ?? 'changelly'));
                        } : null,
                        child: Text(
                            'history',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222))),
                      ),)
                    ]),
              ),
            ],
          ),
        ),
        //Transaction Preview
        Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 10.0, top: 5.0),
          child: Text(
            'Transaction Preview',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        Consumer<GetTransactionsProvider>(
            builder: (context, getTransactionsProvider, child) {
              this.getTransactionsProvider = getTransactionsProvider;
              _isInitializedTransactionsProvider = true;
              if(getTransactionsProvider.error != null && !_errorShownTransactions) {
                _errorShownTransactions = true;
                Fluttertoast.showToast(
                  msg: tr(context).networkErrorCheckConnection,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                  backgroundColor: Color(0xff8B1C1C),
                );
              }
              if (getTransactionsProvider.loading) {
                return Center(
                    child: circularProgressBar(Color(0xff0BA70F), 2.0));
              } else {
                if (getTransactionsProvider.loading == false &&
                    getTransactionsProvider.data!.result!.isNotEmpty) {
                  final transactionDetails = getTransactionsProvider.data?.result![0];
                  final orderInfo = getTransactionsProvider.data?.orderInfo;
                  if (transactionDetails != null && _walletAddress.isNotEmpty && orderInfo != null) {
                    final details = <String, dynamic>{
                      ...orderInfo.toJson(),
                      'blockchainFrom': null,
                      'blockchainTo': null,
                      'networkFrom': null,
                      'networkTo': null,
                    };
                    SwapTxnHistory.instance.updateTransactionDetails(
                      orderInfo.orderId,
                      _walletAddress,
                      exchangeType: widget.transactionDetails.exchangeName ?? ExchangeManager.selectedType?.name ?? 'changelly',
                      details: details,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        border: TableBorder(
                          top: BorderSide(
                              width: 1,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff484856)
                                  : Color(0xffDADADA),
                              style: BorderStyle.solid),
                          left: BorderSide(
                              width: 1,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff484856)
                                  : Color(0xffDADADA),
                              style: BorderStyle.solid),
                          right: BorderSide(
                              width: 1,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff484856)
                                  : Color(0xffDADADA),
                              style: BorderStyle.solid),
                          verticalInside: BorderSide(
                              width: 1,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff484856)
                                  : Color(0xffDADADA),
                              style: BorderStyle.solid),
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Transaction ID',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${transactionDetails?.id}',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffEBEBEB)
                                                : Color(0xff222222)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await ClipboardHelper.copyWithAutoClear(transactionDetails!.id.toString());
                                          await Fluttertoast.showToast(
                                            msg: tr(context).copied,
                                            toastLength: Toast
                                                .LENGTH_SHORT, // Toast duration (short or long)
                                            gravity: ToastGravity.BOTTOM,
                                            textColor: settingsStore.isDarkTheme ? Colors.black : Colors.white,// Toast gravity (top, center, or bottom)// Text color
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
                                  )
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You sent',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  Text(
                                    '${toStringAsFixed(transactionDetails?.amountExpectedFrom)} ${transactionDetails?.currencyFrom?.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff222222)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Exchange Rate',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  Text(
                                    '1 ${transactionDetails?.currencyFrom?.toUpperCase()} ~ ${toStringAsFixed(transactionDetails?.rate)} ${transactionDetails?.currencyTo?.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff222222)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Changelly address (${transactionDetails?.currencyFrom?.toUpperCase()})',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  Text(
                                    '${transactionDetails?.payinAddress}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff222222)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recipient address (${transactionDetails?.currencyTo?.toUpperCase()})',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  Text(
                                    '${transactionDetails?.payoutAddress}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff222222)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transactionDetails?.payinExtraIdName ?? '---',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  Text(
                                    transactionDetails?.payinExtraId ?? '---',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff222222)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                      Table(
                        border: TableBorder.symmetric(
                          outside: BorderSide(
                              width: 1,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff484856)
                                  : Color(0xffDADADA),
                              style: BorderStyle.solid),
                          inside: BorderSide(
                              width: 1,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff484856)
                                  : Color(0xffDADADA),
                              style: BorderStyle.solid),
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'You Get',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffAFAFBE)
                                            : Color(0xff737373)),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '~ ${toStringAsFixed(transactionDetails?.amountExpectedTo)} ${transactionDetails?.currencyTo?.toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffEBEBEB)
                                            : Color(0xff222222)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }
            }),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _getStatusStreamController.close();
    if(_isInitializedCurrencyFullProvider) {
      getCurrenciesFullProvider.dispose();
    }
    if(_isInitializedTransactionsProvider) {
      getTransactionsProvider.removeListener(_onStatusUpdate);
    }
    super.dispose();
  }
}
