import 'dart:async';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../palette.dart';
import '../../../routes.dart';
import '../../util/constants.dart';
import '../../util/network_provider.dart';
import '../../widgets/no_internet.dart';
import '../model/create_transaction_model.dart';
import '../api_client/get_status_api_client.dart';
import '../provider/get_currencies_full_provider.dart';
import '../util/circular_progress_bar.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
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

  late CreateTransactionModel transactionDetails;
  String _walletAddress = "";
  late Timer timer;
  late GetStatusApiClient getStatusApiClient;
  late StreamController<GetStatusModel> _getStatusStreamController;
  late List<String> stored = [];
  static const methodChannelPlatform = MethodChannel("io.beldex.wallet/beldex_wallet_channel");
  late GetCurrenciesFullProvider getCurrenciesFullProvider;
  late GetTransactionsProvider getTransactionsProvider;
  bool _isInitializedCurrencyFullProvider = false;
  bool _isInitializedTransactionsProvider = false;
  late NetworkProvider networkProvider;

  @override
  void initState() {
    transactionDetails = widget.transactionDetails.transactionModel;
    _walletAddress = widget.transactionDetails.walletAddress;
    getTransactionIds(swapTransactionHistoryFileName, _walletAddress).then((List<String> ids) {
      stored = ids;
    });
    getStatusApiClient = GetStatusApiClient();
    // Create a stream controller and get status to the stream.
    _getStatusStreamController = StreamController<GetStatusModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetStatusApi(transactionDetails.result, getStatusApiClient);
      if (!mounted) return;
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !networkProvider.isConnected) return;
        callGetStatusApi(transactionDetails.result, getStatusApiClient);
      }); // Start adding getStatus api result to the stream.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetTransactionsProvider>(context, listen: false).getTransactionsData(context, {"id": "${transactionDetails.result?.id}"});
        Provider.of<GetCurrenciesFullProvider>(context, listen: false).getCurrenciesFullData(context);
      });
    });
    super.initState();
  }

  void callGetStatusApi(Result? result, GetStatusApiClient getStatusApiClient) {
    getStatusApiClient.getStatusData(context, {"id": "${result?.id}"}).then((value) {
      if (value!.result!.isNotEmpty) {
        if (!_getStatusStreamController.isClosed) {
          _getStatusStreamController.sink.add(value);
        }
        switch (value.result) {
          case "finished" :
            {
              //Completed Screen
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pushNamed(Routes.swapCompleted,
                    arguments: TransactionStatus(
                        transactionDetails, value.result, _walletAddress));
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
                        transactionDetails, value.result, _walletAddress));
              });
              break;
            }
          default: {
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    ToastContext().init(context);
    return Consumer<NetworkProvider>(
        builder: (context, networkProvider, child) {
          this.networkProvider = networkProvider;
        return StreamBuilder<GetStatusModel>(
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
    GetStatusModel? responseData,
    CreateTransactionModel transactionDetails, NetworkProvider networkProvider,
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
      GetStatusModel? responseData, CreateTransactionModel transactionDetails, NetworkProvider networkProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                responseData.result == "confirming" ? 0.3 : responseData.result == "exchanging"
            ? 0.6 : responseData.result == "sending" ? 0.9 : responseData.result == "finished" ? 1.0 : 0.0,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                //Confirming in progress Details
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: responseData.result!.isNotEmpty &&
                        responseData.result == "confirming"
                        ? SizedBox(
                        width: 15,
                        height: 15,
                        child: circularProgressBar(Color(0xff0BA70F), 2.0))
                        : SvgPicture.asset(
                      'assets/images/swap/swap_confirmed.svg',
                      colorFilter: ColorFilter.mode(responseData.result!.isNotEmpty &&
                          (responseData.result == "exchanging" || responseData.result == "sending" || responseData.result == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
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
                              (responseData.result == "exchanging" || responseData.result == "sending" || responseData.result == "finished") ? 'Confirmed' :'Confirming in progress',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffEBEBEB)
                                      : Color(0xff222222)),
                            ),
                            SizedBox(width: 5,),
                            (responseData.result == "exchanging" || responseData.result == "sending" || responseData.result == "finished") ? SvgPicture.asset(
                              'assets/images/swap/swap_done.svg',
                              colorFilter: ColorFilter.mode(responseData.result!.isNotEmpty &&
                                  (responseData.result == "exchanging" || responseData.result == "sending" || responseData.result == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373), BlendMode.srcIn),
                              width: 12,
                              height: 12,
                            ) : Container(),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Once ${transactionDetails.result?.currencyFrom?.toUpperCase()} is confirmed in the blockchain, we’ll start exchanging it to ${transactionDetails.result?.currencyTo?.toUpperCase()}',
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
                              if(getCurrenciesFullProvider.error != null) {
                                Toast.show(
                                  'Network Error! Please check internet connection.',
                                  duration: Toast.lengthShort,
                                  gravity: Toast.bottom,
                                  textStyle:TextStyle(color: Colors.white),
                                  backgroundColor: Color(0xff8B1C1C),
                                );
                              }
                              if (getCurrenciesFullProvider.loading) {
                                return Center(child: circularProgressBar(Color(0xff0BA70F), 1.0));
                              } else {
                                if (getCurrenciesFullProvider.data!.result!.isNotEmpty &&
                                    getCurrenciesFullProvider.loading == false) {
                                  final currencyDetails = getCurrenciesFullProvider.data;
                                  return InkWell(
                                    onTap: (){
                                      currencyDetails!.result!.forEach((item){
                                        if(item.ticker == transactionDetails.result!.currencyFrom) {
                                          final url = processUrl(item.transactionUrl, transactionDetails.result?.payinHash);
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
                    child: responseData.result!.isNotEmpty &&
                        responseData.result == "exchanging"
                        ? SizedBox(
                        width: 15,
                        height: 15,
                        child: circularProgressBar(Color(0xff0BA70F), 2.0))
                        : Transform.rotate(
                          angle: 90 * pi / 180,
                          child: SvgPicture.asset(
                            'assets/images/swap/swap.svg',
                            colorFilter: ColorFilter.mode(responseData.result!.isNotEmpty &&
                                (responseData.result == "sending" || responseData.result == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff737373), BlendMode.srcIn),
                            width: 15,
                            height: 15,
                          ),
                        ),
                  ),
                  SizedBox(width: 10),
                  (responseData.result == "sending" || responseData.result == "finished") ?
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Done Exchanging ${transactionDetails.result!.currencyFrom?.toUpperCase()} to ${transactionDetails.result!.currencyTo?.toUpperCase()}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222)),
                        ),
                        SizedBox(height: 5),
                        (responseData.result == "sending" || responseData.result == "finished") ? SvgPicture.asset(
                          'assets/images/swap/swap_done.svg',
                          colorFilter: ColorFilter.mode(responseData.result!.isNotEmpty &&
                              (responseData.result == "sending" || responseData.result == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
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
                          'Exchanging ${transactionDetails.result!.currencyFrom?.toUpperCase()} to ${transactionDetails.result!.currencyTo?.toUpperCase()}',
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
                    child: responseData.result!.isNotEmpty &&
                        responseData.result == "sending"
                        ? SizedBox(
                        width: 15,
                        height: 15,
                        child: circularProgressBar(Color(0xff0BA70F), 2.0))
                        : SvgPicture.asset(
                      'assets/images/swap/swap_wallet.svg',
                      colorFilter: ColorFilter.mode(responseData.result!.isNotEmpty &&
                          responseData.result == "finished" ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373), BlendMode.srcIn),
                      width: 15,
                      height: 15,
                    ),
                  ),
                  SizedBox(width: 10),
                  (responseData.result == "finished") ?
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
                        (responseData.result == "finished") ? SvgPicture.asset(
                          'assets/images/swap/swap_done.svg',
                          colorFilter: ColorFilter.mode( responseData.result!.isNotEmpty &&
                              (responseData.result == "finished") ? Color(0xff0BA70F) : settingsStore.isDarkTheme
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
          width: MediaQuery.of(context).size.width,
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
                          Navigator.of(context).pushNamed(Routes.swapTransactionList, arguments: SwapTransactionHistory(stored));
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
              if(getTransactionsProvider.error != null) {
                Toast.show(
                  'Network Error! Please check internet connection.',
                  duration: Toast.lengthShort,
                  gravity: Toast.bottom,
                  textStyle:TextStyle(color: Colors.white),
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
                                        onTap: (){
                                          Clipboard.setData(ClipboardData(
                                              text: transactionDetails!.id.toString()));
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
      getTransactionsProvider.dispose();
    }
    super.dispose();
  }
}
