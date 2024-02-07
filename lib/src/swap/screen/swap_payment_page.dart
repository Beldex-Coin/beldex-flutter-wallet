import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:beldex_wallet/src/swap/util/swap_page_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../provider/get_currencies_full_provider.dart';
import 'number_stepper.dart';

class SwapPaymentPage extends BasePage {
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
    return SwapPaymentHome();
  }
}

class SwapPaymentHome extends StatefulWidget {
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

  @override
  void initState() {
    Provider.of<GetCurrenciesFullProvider>(context, listen: false).getCurrenciesFullData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getCurrenciesFullProvider = Provider.of<GetCurrenciesFullProvider>(context);
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    final swapExchangePageChangeNotifier = Provider.of<SwapExchangePageChangeNotifier>(context);
    return getCurrenciesFullProvider.loading
        ? Center(
      child: Container(
        child: const CircularProgressIndicator(),
      ),
    )
        : body(_screenWidth,_screenHeight,settingsStore,_scrollController,swapExchangePageChangeNotifier,getCurrenciesFullProvider.data,getCurrenciesFullProvider);
  }

  Widget body(double _screenWidth, double _screenHeight, SettingsStore settingsStore, ScrollController _scrollController, SwapExchangePageChangeNotifier swapExchangePageChangeNotifier, GetCurrenciesFullModel? getCurrenciesFullData, GetCurrenciesFullProvider getCurrenciesFullProvider){
    final List<Result> enableFrom = [];
    final List<Result> enableTo = [];
    for (int i = 0; i < getCurrenciesFullData!.result!.length; i++) {
      if (getCurrenciesFullData.result![i].enabledFrom == true) {
        enableFrom.add(getCurrenciesFullData.result![i]);
      }
      if (getCurrenciesFullData.result![i].enabledTo == true) {
        enableTo.add(getCurrenciesFullData.result![i]);
      }
      if (getCurrenciesFullData.result![i].name == "BDX" && getCurrenciesFullData.result![i].enabled == true) {
        getCurrenciesFullProvider.setBdxIsEnabled(true);
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Payment->Checkout Screen
                            Visibility(
                              visible: currentStep == 3,
                              child: paymentCheckoutScreen(settingsStore),
                            ),
                            //Payment->Send funds to the address below Screen
                            Visibility(
                              visible: false,
                              child: paymentSendFundsToTheAddressBelowScreen(
                                  settingsStore),
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

  Widget paymentCheckoutScreen(SettingsStore settingsStore) {
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
                        '10 BDX',
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
                                text: 'Beldex',
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
                        '0.00063271 BTC',
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
                                text: 'Bitcoin',
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
              'Exchange Fee 0.25%',
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
              '0.00000225 BTC',
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
              '0.000265 BTC',
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
              '79bf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
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
              '1 BDX ~ 0.00000116 BTC',
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
              next();
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xff0BA70F),
              padding:
              EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Confirm & Make Payment',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  Widget paymentSendFundsToTheAddressBelowScreen(SettingsStore settingsStore) {
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
                        '10 BDX',
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
                      'bcbf9e4b0703d65',
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
                  'Time left to send 0.1 BTC',
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
                      '02:59:00',
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
                    'bcbf9e4b0703d65223af71f3318711d1bc5462588c901c09bda751447b69a0a1',
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
                        onTap: () {},
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
                        onTap: () {},
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
              Row(
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
                  Text('Time Remaining : 2:59:00',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)))
                ],
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
                  '10 ETH',
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
                  '1 ETH ~ 2,518.97904761 XRP',
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
                  '62.99676191 XRP',
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
                  '0.154938 XRP',
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
                  '~ 25135.553062 XRP',
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
        SizedBox(
          height: 20,
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
