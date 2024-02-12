import 'dart:async';
import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';
import 'package:beldex_wallet/src/swap/provider/get_transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../model/create_transaction_model.dart';
import '../api_client/get_status_api_client.dart';
import 'number_stepper.dart';

class SwapExchangingPage extends BasePage {
  SwapExchangingPage({required this.transactionDetails});

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
    return SwapExchangingHome(transactionDetails: transactionDetails);
  }
}

class SwapExchangingHome extends StatefulWidget {
  SwapExchangingHome({required this.transactionDetails});

  final CreateTransactionModel transactionDetails;

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
  late Timer timer;
  late GetStatusApiClient getStatusApiClient;
  late StreamController<GetStatusModel> _getStatusStreamController;

  @override
  void initState() {
    transactionDetails = widget.transactionDetails;
    getStatusApiClient = GetStatusApiClient();
    // Create a stream controller and get status to the stream.
    _getStatusStreamController = StreamController<GetStatusModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetStatusApi(transactionDetails.result, getStatusApiClient);
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        callGetStatusApi(transactionDetails.result, getStatusApiClient);
      }); // Start adding getStatus api result to the stream.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<GetTransactionsProvider>(context, listen: false)
            .getTransactionsData(
                context, {"id": "${transactionDetails.result?.id}"});
      });
    });
    super.initState();
  }

  void callGetStatusApi(Result? result, GetStatusApiClient getStatusApiClient) {
    getStatusApiClient
        .getStatusData(context, {"id": "${result?.id}"}).then((value) {
      if (value!.result!.isNotEmpty) {
        _getStatusStreamController.sink.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
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
    CreateTransactionModel transactionDetails,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Exchange->Completed Screen
                        Visibility(
                          visible: false,
                          child: exchangeCompletedScreen(settingsStore),
                        ),
                        //Exchange->Not Paid Screen
                        Visibility(
                          visible: false,
                          child: exchangeNotPaidScreen(settingsStore),
                        ),
                        //Exchange->Exchanging Screen
                        Visibility(
                          visible: currentStep == 4,
                          child: exchangingScreen(
                              settingsStore, responseData, transactionDetails),
                        ),
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

  @override
  void dispose() {
    timer.cancel();
    _getStatusStreamController.close();
    super.dispose();
  }

  Widget exchangeCompletedScreen(SettingsStore settingsStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Completed Back Title
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
              'Back',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
          ],
        ),
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
                    color: Color(0xff159B24),
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
                                'bcbf9e4b0703d65',
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
                            Icon(
                              Icons.copy,
                              color: Color(0xff20D030),
                              size: 14,
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
                            '0.1 BTC',
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
                            '1.6112626 ETH',
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
                            '22 Jul 2023, 18:45:47',
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
                            '22 Jul 2023, 18:45:47',
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
                            '1 BDX ~ 0.00016151 BNB',
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
                            '0.00068934 BNB',
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
                      '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
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
                      'Memo',
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
                      '400016891',
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
        //Confirm and Make Payment Button
        Table(
          children: [
            //Input Hash and Output Hash
            TableRow(children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
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
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text('Input Hash',
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
              Container(
                margin: EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
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
                          'assets/images/swap/swap_output_hash.svg',
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff737373),
                          width: 18,
                          height: 18,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text('Output Hash',
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: settingsStore.isDarkTheme
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff0BA70F),
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
                          color: Color(0xffffffff),
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

  Widget exchangeNotPaidScreen(SettingsStore settingsStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Completed Back Title
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
              'Back',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff060606)),
            ),
          ],
        ),
        //Completed Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 5, right: 5, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Completed Title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/swap/swap_waiting.svg',
                    color: settingsStore.isDarkTheme
                        ? Color(0xffAFAFBE)
                        : Color(0xff737373),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Not Paid',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff737373)),
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
                                'bcbf9e4b0703d65',
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
                            Icon(
                              Icons.copy,
                              color: Color(0xff20D030),
                              size: 14,
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
                            '0.1 BTC',
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
                            '1.6112626 ETH',
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
                      '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
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
            ],
          ),
        ),
        //Not Paid Warning Info
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xff00AD07).withAlpha(25),
              border: Border.all(
                color: Color(0xff00AD07).withAlpha(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Icon(Icons.info_outline,
                      size: 15,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffD1D1DB)
                          : Color(0xff77778B)),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'The floating rate can change at any point due to market conditions, so you might receive more or less crypto than expected.',
                    //'With the fixed rate, you will receive the exact amount of crypto you see on this screen',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff77778B)),
                  ),
                ),
              ],
            )),
        //Confirm and Make Payment Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Color(0xff0BA70F),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/swap/swap_restart.svg',
                  color: Color(0xffffffff),
                  width: 12,
                  height: 12,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Start Over',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget exchangingScreen(SettingsStore settingsStore,
      GetStatusModel? responseData, CreateTransactionModel transactionDetails) {
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
            value: 0.5,
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
                    child: responseData!.result!.isNotEmpty &&
                            responseData.result == "confirming"
                        ? SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Color(0xff0BA70F))
                            ))
                        : SvgPicture.asset(
                            'assets/images/swap/swap_loading.svg',
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
                        Text(
                          'Confirming in progress',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffEBEBEB)
                                  : Color(0xff222222)),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
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
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                flex: 1,
                                child: Icon(Icons.info_outline,
                                    size: 12,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffD1D1DB)
                                        : Color(0xff77778B)),
                              ),
                            ]),
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
                    child: Transform.rotate(
                      angle: 90 * pi / 180,
                      child: responseData.result!.isNotEmpty &&
                              responseData.result == "exchanging"
                          ? SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(Color(0xff0BA70F))
                              ))
                          : SvgPicture.asset(
                              'assets/images/swap/swap.svg',
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff737373),
                              width: 15,
                              height: 15,
                            ),
                    ),
                  ),
                  SizedBox(width: 10),
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
                            child: CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Color(0xff0BA70F))
                            ))
                        : SvgPicture.asset(
                            'assets/images/swap/swap_wallet.svg',
                            color: settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff737373),
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
                      TextSpan(
                          text: 'history',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff222222))),
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
                                '${transactionDetails?.amountExpectedFrom} ${transactionDetails?.currencyFrom?.toUpperCase()}',
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
                                '1 ${transactionDetails?.currencyFrom?.toUpperCase()} ~ ${transactionDetails?.rate} ${transactionDetails?.currencyTo?.toUpperCase()}',
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
                                'Memo',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffAFAFBE)
                                        : Color(0xff737373)),
                              ),
                              Text(
                                '---',
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
                                '~ ${expectedAmount} ${transactionDetails.currencyTo?.toUpperCase()}',
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
}

class Coins {
  Coins(this.id, this.name);

  String? id;
  String? name;
}
