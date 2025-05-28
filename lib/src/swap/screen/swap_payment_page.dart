import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/api_client/get_exchange_amount_api_client.dart';
import 'package:beldex_wallet/src/swap/model/create_transaction_model.dart';
import 'package:beldex_wallet/src/swap/model/get_exchange_amount_model.dart';
import 'package:beldex_wallet/src/swap/screen/swap_wallet_address_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../routes.dart';
import '../api_client/create_transaction_api_client.dart';
import '../util/data_class.dart';
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

  @override
  void initState() {
    _exchangeDataWithRecipientAddress = widget.exchangeDataWithRecipientAddress;
    createTransactionApiClient = CreateTransactionApiClient();
    getExchangeAmountApiClient = GetExchangeAmountApiClient();
    // Create a stream controller and exchange amount to the stream.
    _getExchangeAmountStreamController =
        StreamController<GetExchangeAmountModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetExchangeAmountApi(getExchangeAmountApiClient);
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        callGetExchangeAmountApi(getExchangeAmountApiClient);
      }); // Start adding getExchangeAmount api result to the stream.
    });
    super.initState();
  }

  void callGetExchangeAmountApi(
      GetExchangeAmountApiClient getExchangeAmountApiClient) {
    getExchangeAmountApiClient.getExchangeAmountData(context,
        {'from': _exchangeDataWithRecipientAddress.from, "to": _exchangeDataWithRecipientAddress.to, "amountFrom": _exchangeDataWithRecipientAddress.amountFrom}).then((value) {
      if (value!.result!.isNotEmpty) {
        _getExchangeAmountStreamController.sink.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    return StreamBuilder<GetExchangeAmountModel>(
      stream: _getExchangeAmountStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(
                      0xff0BA70F)))); // Display a loading indicator when waiting for data.
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          ); // Display an error message if an error occurs.
        } else if (!snapshot.hasData) {
          return Center(
            child: Text('No data available'),
          ); // Display a message when no data is available.
        } else {
          if (snapshot.data!.result!.isNotEmpty) {
            return body(_screenWidth, _screenHeight, settingsStore,
                _scrollController, snapshot.data!);
          } else {
            return Container();
          }
        }
      },
    );
  }

  Widget body(
    double _screenWidth,
    double _screenHeight,
    SettingsStore settingsStore,
    ScrollController _scrollController,
    GetExchangeAmountModel getExchangeAmountModel,
  ) {
    //GetExchangeAmount
    final sendAmount = getExchangeAmountModel.result![0].amountFrom.toString();
    final exchangeRate = getExchangeAmountModel.result![0].rate.toString();
    final serviceFee = getExchangeAmountModel.result![0].fee.toString();
    final networkFee = getExchangeAmountModel.result![0].networkFee.toString();
    final getAmount =
        double.parse(getExchangeAmountModel.result![0].amountTo!) -
            double.parse(getExchangeAmountModel.result![0].networkFee!);
    final from = getExchangeAmountModel.result![0].from.toString();
    final to = getExchangeAmountModel.result![0].to.toString();
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
                            sendAmount,
                            exchangeRate,
                            serviceFee,
                            networkFee,
                            getAmount,
                            from,
                            to,
                            getExchangeAmountModel),
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
      String sendAmount,
      String exchangeRate,
      String serviceFee,
      String networkFee,
      double getAmount,
      String from,
      String to, GetExchangeAmountModel getExchangeAmountModel,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Checkout Title
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/swap/swap_back.svg',
              color: settingsStore.isDarkTheme
                  ? Color(0xffffffff)
                  : Color(0xff16161D),
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Checkout',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
          ],
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
              margin: EdgeInsets.only(top: 10.0),
              height: 1,
              color: settingsStore.isDarkTheme
                  ? Color(0xff4F4F70)
                  : Color(0xffDADADA),
            )
          ],
        ),
        //Estimated Time
        Container(
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
        //Confirm and Make Payment Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              showLoaderDialog(context);
              if (_exchangeDataWithRecipientAddress.extraIdName!.isNotEmpty) {
                createTransaction({
                  "from": from,
                  "to": to,
                  "address": _exchangeDataWithRecipientAddress.recipientAddress!,
                  "extraId": _exchangeDataWithRecipientAddress.extraIdName!,
                  "amountFrom": _exchangeDataWithRecipientAddress.amountFrom!
                }, _exchangeDataWithRecipientAddress.fromBlockChain!);
              } else {
                createTransaction({
                  "from": from,
                  "to": to,
                  "address": _exchangeDataWithRecipientAddress.recipientAddress!,
                  "amountFrom": _exchangeDataWithRecipientAddress.amountFrom!
                }, _exchangeDataWithRecipientAddress.toBlockChain!);
              }
            },
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color(0xffffffff),
                fontWeight: FontWeight.bold
              ),
              backgroundColor: Color(0xff0BA70F),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Confirm & Make Payment',
                style: TextStyle(
                    backgroundColor: Colors.transparent,
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Future showLoaderDialog(BuildContext context) {
    final AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0BA70F))),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void createTransaction(Map<String, String> params, String? fromBlockChain) {
    callCreateTransactionApi(params).then((value) {
      if (value?.result != null) {
        print('Status -> Success');
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context)
            .pushNamed(Routes.swapPaymentDetails, arguments: TransactionDetails(value, fromBlockChain));
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
