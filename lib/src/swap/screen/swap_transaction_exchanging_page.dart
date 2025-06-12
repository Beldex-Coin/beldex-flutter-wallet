import 'dart:async';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../palette.dart';
import '../../../routes.dart';
import '../../widgets/no_internet.dart';
import '../api_client/get_status_api_client.dart';
import '../provider/get_currencies_full_provider.dart';
import '../util/circular_progress_bar.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapTransactionExchangingPage extends BasePage {
  SwapTransactionExchangingPage({required this.transactionDetails});

  final GetTransactionResult transactionDetails;

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
  Widget body(BuildContext context) {
    return SwapTransactionExchangingHome(transactionDetails: transactionDetails);
  }
}

class SwapTransactionExchangingHome extends StatefulWidget {
  SwapTransactionExchangingHome({required this.transactionDetails});

  final GetTransactionResult transactionDetails;

  @override
  State<SwapTransactionExchangingHome> createState() => _SwapTransactionExchangingHomeState();
}

class _SwapTransactionExchangingHomeState extends State<SwapTransactionExchangingHome> {
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

  late GetTransactionResult transactionDetails;
  late Timer timer;
  late GetStatusApiClient getStatusApiClient;
  late StreamController<GetStatusModel> _getStatusStreamController;
  late FlutterSecureStorage secureStorage;
  late List<String> stored = [];
  static const methodChannelPlatform = MethodChannel("io.beldex.wallet/beldex_wallet_channel");
  late GetCurrenciesFullProvider getCurrenciesFullProvider;
  bool _isInitialized = false;

  @override
  void initState() {
    transactionDetails = widget.transactionDetails;
    secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    getTransactionsIds(secureStorage, transactionIds: (ids) {
      stored = ids;
    });
    getStatusApiClient = GetStatusApiClient();
    // Create a stream controller and get status to the stream.
    _getStatusStreamController = StreamController<GetStatusModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetStatusApi(transactionDetails, getStatusApiClient);
      if (!mounted) return;
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !isOnline(context)) return;
        callGetStatusApi(transactionDetails, getStatusApiClient);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetCurrenciesFullProvider>(context, listen: false).getCurrenciesFullData(context);
      });// Start adding getStatus api result to the stream.
    });
    super.initState();
  }

  void callGetStatusApi(GetTransactionResult? result, GetStatusApiClient getStatusApiClient) {
    getStatusApiClient.getStatusData(context, {"id": "${result?.id}"}).then((value) {
      if (value!.result!.isNotEmpty) {
        _getStatusStreamController.sink.add(value);
        switch (value.result) {
          case "finished" :
            {
              //Completed Screen
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop(true);
                Navigator.of(context).pushNamed(Routes.swapTransactionCompleted,
                    arguments: GetTransactionStatus(
                        transactionDetails, value.result));
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
                Navigator.of(context).pushNamed(Routes.swapTransactionUnPaid,
                    arguments: GetTransactionStatus(
                        transactionDetails, value.result));
              });
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
    return StreamBuilder<GetStatusModel>(
      stream: _getStatusStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: circularProgressBar(Color(0xff0BA70F), 4.0)); // Display a loading indicator when waiting for data.
        } else if (snapshot.hasError || !snapshot.hasData || !isOnline(context)) {
          return noInternet(settingsStore, _screenWidth); // Display an error message if an error occurs. or Display a message when no data is available.
        } else {
          return body(
              _screenWidth,
              _screenHeight,
              settingsStore,
              _scrollController,
              snapshot.data,
              transactionDetails);
        }
      },
    );
  }

  Widget body(
      double _screenWidth,
      double _screenHeight,
      SettingsStore settingsStore,
      ScrollController _scrollController,
      GetStatusModel? responseData,
      GetTransactionResult transactionDetails,
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
                                settingsStore, responseData, transactionDetails),
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
      GetStatusModel? responseData, GetTransactionResult transactionDetails) {
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
                          'Once ${transactionDetails.currencyFrom?.toUpperCase()} is confirmed in the blockchain, we’ll start exchanging it to ${transactionDetails.currencyTo?.toUpperCase()}',
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
                              _isInitialized = true;
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
                                        if(item.ticker == transactionDetails.currencyFrom) {
                                          final url = processUrl(item.transactionUrl, transactionDetails.payinAddress);
                                          if(url.trim().isNotEmpty){
                                            openUrl(url, methodChannelPlatform);
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
                          'Done Exchanging ${transactionDetails.currencyFrom?.toUpperCase()} to ${transactionDetails.currencyTo?.toUpperCase()}',
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
                          'Exchanging ${transactionDetails.currencyFrom?.toUpperCase()} to ${transactionDetails.currencyTo?.toUpperCase()}',
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
                          colorFilter: ColorFilter.mode(responseData.result!.isNotEmpty &&
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
                        onTap: isOnline(context) ? () {
                          final FlutterSecureStorage secureStorage = FlutterSecureStorage();
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pushNamed(Routes.swapTransactionList, arguments: SwapTransactionHistory(stored, secureStorage));
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
        Column(
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
                        Text(
                          '${transactionDetails.id}',
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
                          'You sent',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                        Text(
                          '${transactionDetails.amountExpectedFrom} ${transactionDetails.currencyFrom?.toUpperCase()}',
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
                          '1 ${transactionDetails.currencyFrom?.toUpperCase()} ~ ${transactionDetails.rate} ${transactionDetails.currencyTo?.toUpperCase()}',
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
                          'Changelly address (${transactionDetails.currencyFrom?.toUpperCase()})',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                        Text(
                          '${transactionDetails.payinAddress}',
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
                          'Recipient address (${transactionDetails.currencyTo?.toUpperCase()})',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                        Text(
                          '${transactionDetails.payoutAddress}',
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
                          transactionDetails.payinExtraIdName ?? '---',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373)),
                        ),
                        Text(
                          transactionDetails.payinExtraId ?? '---',
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
                          '~ ${transactionDetails.amountExpectedTo} ${transactionDetails.currencyTo?.toUpperCase()}',
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
        ),
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
    if(_isInitialized) {
      getCurrenciesFullProvider.dispose();
    }
    super.dispose();
  }
}
