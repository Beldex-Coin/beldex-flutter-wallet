import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../../routes.dart';
import '../api_client/get_status_api_client.dart';
import '../util/data_class.dart';
import '../util/utils.dart';
import 'number_stepper.dart';

class SwapUnPaidPage extends BasePage {
  SwapUnPaidPage({required this.transactionStatus});

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
    return SwapUnPaidHome(transactionStatus: transactionStatus);
  }
}

class SwapUnPaidHome extends StatefulWidget {
  SwapUnPaidHome({required this.transactionStatus});

  final TransactionStatus transactionStatus;

  @override
  State<SwapUnPaidHome> createState() => _SwapUnPaidHomeState();
}

class _SwapUnPaidHomeState extends State<SwapUnPaidHome> {
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

  late TransactionStatus transactionStatus;
  late GetStatusApiClient getStatusApiClient;

  @override
  void initState() {
    transactionStatus = widget.transactionStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    ToastContext().init(context);
    return body(
        _screenWidth,
        _screenHeight,
        settingsStore,
        _scrollController);
  }

  Widget body(
      double _screenWidth,
      double _screenHeight,
      SettingsStore settingsStore,
      ScrollController _scrollController
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
                            child: exchangeNotPaidScreen(settingsStore),
                          ),
                        ),
                      ),
                    ));
              }),
        ),
      ],
    );
  }

  Widget exchangeNotPaidScreen(SettingsStore settingsStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Not Paid Details
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 5, right: 5, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Not Paid Title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isFailed() ?
                  SvgPicture.asset(
                    'assets/images/swap/swap_failed.svg',
                    colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ) : SvgPicture.asset(
                    'assets/images/swap/swap_waiting.svg',
                    colorFilter: ColorFilter.mode(settingsStore.isDarkTheme
                        ? Color(0xffAFAFBE)
                        : Color(0xff737373), BlendMode.srcIn),
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    validateStatus(),
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: isFailed() ? Colors.red :settingsStore.isDarkTheme
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
                                transactionStatus.transactionModel.result!.id!,
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
                                    text: transactionStatus.transactionModel.id!));
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
                            '${toStringAsFixed(transactionStatus.transactionModel.result!.amountExpectedFrom)} ${transactionStatus.transactionModel.result!.currencyFrom!.toUpperCase()}',
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
                            '${toStringAsFixed(transactionStatus.transactionModel.result!.amountExpectedTo)} ${transactionStatus.transactionModel.result!.currencyTo!.toUpperCase()}',
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
                      transactionStatus.transactionModel.result!.payinAddress!,
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
                    'The funds were not received within 3 hours. Please check the rates and create a new transaction',
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
            onPressed:() {
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
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
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

  @override
  void dispose() {
    super.dispose();
  }

  String validateStatus() {
    final status = transactionStatus.status;
    if(status == "failed") {
      return "Failed";
    } else {
      return "Not Paid";
    }
  }

  bool isFailed() {
    final status = transactionStatus.status;
    return status == "failed";
  }
}
