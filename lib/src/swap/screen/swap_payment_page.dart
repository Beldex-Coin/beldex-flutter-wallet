import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/swap/api_client/get_exchange_amount_api_client.dart';
import 'package:beldex_wallet/src/swap/model/create_transaction_model.dart';
import 'package:beldex_wallet/src/swap/model/get_exchange_amount_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../../util/constants.dart';
import '../../util/network_provider.dart';
import '../../widgets/no_internet.dart';
import '../api_client/create_transaction_api_client.dart';
import '../dialog/showSwapInitiatingTransactionDialog.dart';
import '../util/circular_progress_bar.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapPaymentPage extends BasePage {
  SwapPaymentPage({required this.exchangeDataWithRecipientAddress});

  final ExchangeDataWithRecipientAddress exchangeDataWithRecipientAddress;

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
    return SwapPaymentHome(exchangeDataWithRecipientAddress: exchangeDataWithRecipientAddress,);
  }
}

class SwapPaymentHome extends StatefulWidget {
  SwapPaymentHome({required this.exchangeDataWithRecipientAddress});

  final ExchangeDataWithRecipientAddress exchangeDataWithRecipientAddress;

  @override
  State<SwapPaymentHome> createState() => _SwapPaymentHomeState();
}

class _SwapPaymentHomeState extends State<SwapPaymentHome> {
  int currentStep = 3;
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

  late CreateTransactionApiClient createTransactionApiClient;
  late GetExchangeAmountApiClient getExchangeAmountApiClient;
  late StreamController<GetExchangeAmountModel>
      _getExchangeAmountStreamController;
  late Timer timer;
  late ExchangeDataWithRecipientAddress _exchangeDataWithRecipientAddress;
  var sendAmount;
  var from;
  var to;
  late FlutterSecureStorage secureStorage;
  late NetworkProvider networkProvider;

  @override
  void initState() {
    secureStorage = FlutterSecureStorage(aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    _exchangeDataWithRecipientAddress = widget.exchangeDataWithRecipientAddress;
    sendAmount = _exchangeDataWithRecipientAddress.amountFrom;
    from = _exchangeDataWithRecipientAddress.from;
    to = _exchangeDataWithRecipientAddress.to;
    createTransactionApiClient = CreateTransactionApiClient();
    getExchangeAmountApiClient = GetExchangeAmountApiClient();
    // Create a stream controller and exchange amount to the stream.
    _getExchangeAmountStreamController =
        StreamController<GetExchangeAmountModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetExchangeAmountApi(getExchangeAmountApiClient, sendAmount);
      if (!mounted) return;
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        if (!mounted && !networkProvider.isConnected) return;
        callGetExchangeAmountApi(getExchangeAmountApiClient, sendAmount);
      }); // Start adding getExchangeAmount api result to the stream.
    });
    super.initState();
  }

  void callGetExchangeAmountApi(
      GetExchangeAmountApiClient getExchangeAmountApiClient, String amountFrom) {
    getExchangeAmountApiClient.getExchangeAmountData(context,
        {'from': _exchangeDataWithRecipientAddress.from, "to": _exchangeDataWithRecipientAddress.to, "amountFrom": amountFrom}).then((value) {
      _getExchangeAmountStreamController.sink.add(value!);
    });
  }

  bool isConfirmationButtonEnabled(String minimumAmount, String maximumAmount, BuildContext context, NetworkProvider networkProvider) {
    return (minimumAmount.trim().isEmpty && maximumAmount.trim().isEmpty) && networkProvider.isConnected;
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    final walletStore = Provider.of<WalletStore>(context);
    return Consumer<NetworkProvider>(
        builder: (context, networkProvider, child) {
          this.networkProvider = networkProvider;
        return StreamBuilder<GetExchangeAmountModel>(
          stream: _getExchangeAmountStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: circularProgressBar(Color(0xff0BA70F), 4.0)); // Display a loading indicator when waiting for data.
            } else if (snapshot.hasError || !snapshot.hasData || !networkProvider.isConnected) {
              return noInternet(settingsStore, _screenWidth); // Display an error message if an error occurs. or Display a message when no data is available.
            } else {
              return body(_screenWidth, _screenHeight, settingsStore,
                  _scrollController, snapshot.data!, networkProvider, walletStore.subaddress.address);
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
    GetExchangeAmountModel getExchangeAmountModel, NetworkProvider networkProvider, String walletAddress,
  ) {
    //GetExchangeAmount
    var exchangeRate = "---";
    var serviceFee = "---";
    var networkFee = "---";
    var getAmount = "---";
    var minimumAmount = "";
    var maximumAmount = "";
    if(getExchangeAmountModel.result!.isNotEmpty){
      sendAmount = toStringAsFixed(getExchangeAmountModel.result![0].amountFrom.toString());
      exchangeRate = toStringAsFixed(getExchangeAmountModel.result![0].rate.toString());
      serviceFee = toStringAsFixed(getExchangeAmountModel.result![0].fee.toString());
      networkFee = toStringAsFixed(getExchangeAmountModel.result![0].networkFee.toString());
      getAmount = toStringAsFixed(getExchangeAmountModel.result![0].amountTo!.toString());
      from = getExchangeAmountModel.result![0].from.toString();
      to = getExchangeAmountModel.result![0].to.toString();
      minimumAmount = "";
      maximumAmount = "";
    } else {
      if(getExchangeAmountModel.error != null && getExchangeAmountModel.error!.data != null){
        if(double.parse(_exchangeDataWithRecipientAddress.amountFrom!) < double.parse(getExchangeAmountModel.error!.data!.limits!.min!.from!)){
          minimumAmount = getExchangeAmountModel.error!.data!.limits!.min!.from!;
        }
        if(double.parse(_exchangeDataWithRecipientAddress.amountFrom!) > double.parse(getExchangeAmountModel.error!.data!.limits!.max!.from!)){
          maximumAmount = getExchangeAmountModel.error!.data!.limits!.max!.from!;
        }
      }
    }
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Payment->Checkout Screen
                        paymentCheckoutScreen(
                            settingsStore,
                            exchangeRate,
                            serviceFee,
                            networkFee,
                            getAmount,
                            getExchangeAmountModel, minimumAmount, maximumAmount, networkProvider, walletAddress),
                        //Payment->Send funds to the address below Screen
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }),
        ),
      ],
    );
  }

  Widget paymentCheckoutScreen(
      SettingsStore settingsStore,
      String exchangeRate,
      String serviceFee,
      String networkFee,
      String getAmount,
      GetExchangeAmountModel getExchangeAmountModel, String minimumAmount, String maximumAmount, NetworkProvider networkProvider, String walletAddress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Checkout Title
        Text(
          'Checkout',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //You Send Details
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(5),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You send',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '$sendAmount ${from.toUpperCase()}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 3, top: 3, bottom: 3),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff4F4F70)
                              : Color(0xffDADADA),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Blockchain:',
                          style: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: _exchangeDataWithRecipientAddress.fromBlockChain,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff222222)))
                          ]),
                    ),
                  ),
                ),
              ],
            )),
        Visibility(
          visible: minimumAmount.trim().isNotEmpty || maximumAmount.trim().isNotEmpty,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: Color(0xff00AD07).withAlpha(25),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: InkWell(
              onTap: networkProvider.isConnected ? () {
                if(minimumAmount.trim().isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    //Get Exchange Amount API Call
                    callGetExchangeAmountApi(getExchangeAmountApiClient, minimumAmount);
                  });
                } else if(maximumAmount.trim().isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    //Get Exchange Amount API Call
                    callGetExchangeAmountApi(getExchangeAmountApiClient, maximumAmount);
                  });
                }
              } : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: minimumAmount.trim().isNotEmpty ?'The minimum amount value has changed, The new value is ':maximumAmount.trim().isNotEmpty ?'The maximum amount value has changed, The new value is ':'',
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222),
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                      children: [
                        TextSpan(
                            text: minimumAmount.trim().isNotEmpty ?'${minimumAmount} ${from}':maximumAmount.trim().isNotEmpty ?'${maximumAmount} ${from}':'',
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)))
                      ]),
                ),
              ),
            ),
          ),
        ),
        //You Get Details
        Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(5),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You get',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '${getAmount == 0.0 ? "..." : getAmount} ${to.toUpperCase()}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 3, top: 3, bottom: 3),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff4F4F70)
                              : Color(0xffDADADA),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Blockchain:',
                          style: TextStyle(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: _exchangeDataWithRecipientAddress.toBlockChain,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff222222)))
                          ]),
                    ),
                  ),
                ),
              ],
            )),
        //Exchange Fee 0.25 % Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Service Fee 0.25%',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$serviceFee ${to.toUpperCase()}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Network Fee Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Network Fee',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$networkFee ${to.toUpperCase()}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Recipient Address Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Recipient Address',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              _exchangeDataWithRecipientAddress.recipientAddress!,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Exchange Rate Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Exchange Rate',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '1 ${from.toUpperCase()} ~ $exchangeRate ${to.toUpperCase()}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff222222)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 30),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Estimated Time
        Visibility(
          visible: false,
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? Colors.transparent
                    : Color(0xffFFFFFF),
                border: Border.all(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff4F4F70)
                      : Color(0xffDADADA),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 12,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffAFAFBE)
                      : Color(0xff737373),
                ),
                SizedBox(
                  width: 5,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Estimated Time ',
                      style: TextStyle(
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: '5-30 mins',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)))
                      ]),
                ),
              ],
            ),
          ),
        ),
        //Confirm and Make Payment Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              if(isConfirmationButtonEnabled(minimumAmount, maximumAmount, context, networkProvider)) {
                showSwapInitiatingTransactionDialog(context, settingsStore);
                if (_exchangeDataWithRecipientAddress.extraIdName!.isNotEmpty) {
                  createTransaction({
                    "from": from,
                    "to": to,
                    "address": _exchangeDataWithRecipientAddress
                        .recipientAddress!,
                    "extraId": _exchangeDataWithRecipientAddress.extraIdName!,
                    "amountFrom": sendAmount
                  }, _exchangeDataWithRecipientAddress.toBlockChain!, walletAddress);
                } else {
                  createTransaction({
                    "from": from,
                    "to": to,
                    "address": _exchangeDataWithRecipientAddress
                        .recipientAddress!,
                    "amountFrom": sendAmount
                  }, _exchangeDataWithRecipientAddress.toBlockChain!, walletAddress);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isConfirmationButtonEnabled(minimumAmount, maximumAmount, context, networkProvider)
                  ? Color(0xff0BA70F)
                  : settingsStore.isDarkTheme
                  ? Color(0xff32324A)
                  : Color(0xffFFFFFF),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Confirm & Make Payment',
                style: TextStyle(
                    color: isConfirmationButtonEnabled(minimumAmount, maximumAmount, context, networkProvider)
                        ? Color(0xffffffff)
                        : settingsStore.isDarkTheme
                        ? Color(0xff77778B)
                        : Color(0xffB1B1D1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  void createTransaction(Map<String, String> params, String? toBlockChain, String walletAddress) {
    callCreateTransactionApi(params).then((value) {
      if (value?.result != null) {
        print('Status -> Success');
        storeTransactionIds(swapTransactionHistoryFileName, walletAddress, value!.result!.id);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(true);
          Navigator.of(context).pushNamed(Routes.swapPaymentDetails, arguments: TransactionDetails(value, toBlockChain, walletAddress)); // Start adding getExchangeAmount api result to the stream.
        });
      } else if (value?.error != null) {
        print('Status -> error ${value!.error!.message}');
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  Future<CreateTransactionModel?> callCreateTransactionApi(params) async {
    try {
      return await createTransactionApiClient.createTransactionData(
          context, params);
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    _getExchangeAmountStreamController.close();
    super.dispose();
  }
}
