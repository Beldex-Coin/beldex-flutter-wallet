import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/create_transaction_model.dart';
import 'package:beldex_wallet/src/swap/api_client/get_status_api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../screens/receive/qr_image.dart';
import '../model/get_status_model.dart';
import '../provider/get_transactions_provider.dart';
import 'number_stepper.dart';

class SwapPaymentDetailsPage extends BasePage {
  SwapPaymentDetailsPage({required this.transactionDetails});

  final CreateTransactionModel transactionDetails;

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
    return SwapPaymentDetailsHome(transactionDetails: transactionDetails);
  }
}

class SwapPaymentDetailsHome extends StatefulWidget {
  SwapPaymentDetailsHome({required this.transactionDetails});

  final CreateTransactionModel transactionDetails;

  @override
  State<SwapPaymentDetailsHome> createState() => _SwapPaymentDetailsHomeState();
}

class _SwapPaymentDetailsHomeState extends State<SwapPaymentDetailsHome> {
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

  late CreateTransactionModel createdTransactionDetails;
  late Timer timer;
  late GetStatusApiClient getStatusApiClient;
  late StreamController<GetStatusModel> _getStatusStreamController;

  @override
  void initState() {
    createdTransactionDetails = widget.transactionDetails;
    getStatusApiClient = GetStatusApiClient();
    // Create a stream controller and get status to the stream.
    _getStatusStreamController = StreamController<GetStatusModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetStatusApi(createdTransactionDetails.result, getStatusApiClient);
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        callGetStatusApi(createdTransactionDetails.result, getStatusApiClient);
      }); // Start adding getStatus api result to the stream.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetTransactionsProvider>(context, listen: false)
            .getTransactionsData(
            context, {"id": "${createdTransactionDetails.result?.id}"});
      });
    });
    super.initState();
  }

  void callGetStatusApi(Result? result, GetStatusApiClient getStatusApiClient){
    getStatusApiClient.getStatusData(context, {"id":"${result?.id}"}).then((value){
      if(value!.result!.isNotEmpty){
        _getStatusStreamController.sink.add(value);
        switch(value.result){
          case "waiting" :{
            //Swap Payment Details Screen
            /*Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Routes.swapExchanging,arguments: createdTransactionDetails);*/
            break;
          }
          case "confirming" : {
            //Exchanging Screen
            break;
          }
          case "failed" : {
            break;
          }
          case "refunded" : {
            break;
          }
          case "overdue" : {
            break;
          }
          case "expired" : {
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
          return Center(
              child:
              CircularProgressIndicator(valueColor:
              AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)))); // Display a loading indicator when waiting for data.
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          ); // Display an error message if an error occurs.
        } else if (!snapshot.hasData) {
          return Center(
            child: Text('No data available'),
          ); // Display a message when no data is available.
        } else {
          return body(
              _screenWidth,
              _screenHeight,
              settingsStore,
              _scrollController,
              createdTransactionDetails.result);
        }
      },
    );
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, Result? createdTransactionDetails){
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
        Flexible(
          flex:1,
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Card(
                      margin: EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 15),
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
                        child: paymentSendFundsToTheAddressBelowScreen(settingsStore,createdTransactionDetails),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ],
    );
  }

  Widget paymentSendFundsToTheAddressBelowScreen(SettingsStore settingsStore, Result? createdTransactionDetails,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Send funds to the address below Title
        Text(
          'Send funds to the address below',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //Amount Details
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              border: Border(
                  left: BorderSide(
                    width: 1.0,
                    color: settingsStore.isDarkTheme
                        ? Color(0xff303041)
                        : Color(0xffDADADA),
                  )),
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
                        'Amount',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff222222)),
                      ),
                      Text(
                        '${createdTransactionDetails?.amountExpectedFrom} ${createdTransactionDetails?.currencyFrom?.toUpperCase()}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff20D030)),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff20D030),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        settingsStore.isDarkTheme
                            ? SvgPicture.asset(
                          'assets/images/swap/swap_wallet_dark.svg',
                          width: 25,
                          height: 25,
                        )
                            : SvgPicture.asset(
                          'assets/images/swap/swap_wallet_light.svg',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Wallet',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)))
                      ],
                    ),
                  ),
                ),
              ],
            )),
        //Transaction ID with Time Details
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction ID',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${createdTransactionDetails?.id}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.copy,
                      color: Color(0xff20D030),
                      size: 14,
                    )
                  ],
                )
              ],
            )),
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: settingsStore.isDarkTheme
                  ? Colors.transparent
                  : Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff484856)
                    : Color(0xffDADADA),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time left to send ${createdTransactionDetails?.amountExpectedFrom} ${createdTransactionDetails?.currencyFrom?.toUpperCase()}',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373),
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${createdTransactionDetails?.createdAt}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                  ],
                )
              ],
            )),
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
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffAFAFBE)
                      : Color(0xff737373)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    '${createdTransactionDetails?.payinAddress}',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffFFFFFF)
                            : Color(0xff222222)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                              text: createdTransactionDetails!.payinAddress.toString()));
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
                        child: Container(
                          width: 30.0,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color(0xff00AD07),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: Icon(
                            Icons.copy,
                            color: Color(0xffFFFFFF),
                            size: 20,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                            showQRCodeDialog(context, settingsStore,createdTransactionDetails?.payinAddress);
                        },
                        child: Container(
                          width: 30.0,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff32324A)
                                  : Color(0xffFFFFFF),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: SvgPicture.asset(
                            'assets/images/swap/scan_qr.svg',
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222),
                            width: 20,
                            height: 20,
                          ),
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text('blockchain : bitcoin',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff00AD07))),
          ],
        ),
        //Time Remaining Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 20, bottom: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xff00AD07).withAlpha(25),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 15,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffAFAFBE)
                          : Color(0xff737373),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text('Time Remaining : ${createdTransactionDetails?.createdAt}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff222222))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'You Have 3 Hours to send funds otherwise the transaction will be cancelled automatically.\n\nThe exchange will be initiated once the funds are received.',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff222222)))
            ],
          ),
        ),
        //Transaction Preview
        Container(
          margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
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
              if (getTransactionsProvider.loading) {
                return Center(
                    child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xff0BA70F))
                    ));
              } else {
                if (getTransactionsProvider.loading == false &&
                    getTransactionsProvider.data!.result!.isNotEmpty) {
                  final transactionDetails =
                  getTransactionsProvider.data?.result![0];
                  final expectedAmount = double.parse(
                      transactionDetails!.amountExpectedTo.toString()) -
                      double.parse(transactionDetails!.networkFee.toString());
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
                          //Floating Exchange Rate
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Text(
                                'You send',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373)),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                              child: Text(
                                '${transactionDetails?.amountExpectedFrom} ${transactionDetails?.currencyFrom?.toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff222222)),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Text(
                                'Exchange rate',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373)),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                              child: Text(
                                '1 ${transactionDetails.currencyFrom?.toUpperCase()} ~ ${transactionDetails.rate} ${transactionDetails.currencyTo?.toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff222222)),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Text(
                                'Service fee 0.25%',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373)),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                              child: Text(
                                '--- ${transactionDetails.currencyTo?.toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff222222)),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Text(
                                'Network fee',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '${transactionDetails.networkFee} ${transactionDetails.currencyTo?.toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff222222)),
                              ),
                            )
                          ]),

                          //Fixed Exchange Rate
                          if (false)
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                child: Text(
                                  'Fixed rate',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373)),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                child: Column(
                                  children: [
                                    Text('1 ETH ~ 2,518.97904761 XRP',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffEBEBEB)
                                                : Color(0xff222222))),
                                    Text('The fixed rate is updated every 30 Seconds',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffAfAFBE)
                                                : Color(0xff737373)))
                                  ],
                                ),
                              )
                            ]),
                          if (false)
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                child: Text(
                                  'Network fee',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffAFAFBE)
                                          : Color(0xff737373)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'All fees included in the rate',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffEBEBEB)
                                          : Color(0xff222222)),
                                ),
                              )
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
                              padding:
                              const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
                              child: Text(
                                'You Get',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '~ ${expectedAmount} ${transactionDetails.currencyTo?.toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffEBEBEB)
                                        : Color(0xff222222)),
                              ),
                            )
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
          height: 20,
        )
      ],
    );
  }

  Future showQRCodeDialog(BuildContext context, SettingsStore settingsStore, String? payInAddress) {
    final AlertDialog alert = AlertDialog(
      content: Container(
        height:
        MediaQuery.of(context).size.height * 0.60 / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: settingsStore.isDarkTheme
              ? Color(0xff1F1F28)
              : Color(0xffEDEDED),
        ),
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: QrImage(
            data: payInAddress.toString(),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}