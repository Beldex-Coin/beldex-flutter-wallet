import 'dart:math';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/swap/model/get_currencies_full_model.dart';
import 'package:beldex_wallet/src/swap/util/swap_page_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../provider/get_currencies_full_provider.dart';
import 'number_stepper.dart';

class SwapWalletAddressPage extends BasePage {
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
    return SwapWalletAddressHome();
  }
}

class SwapWalletAddressHome extends StatefulWidget {
  @override
  State<SwapWalletAddressHome> createState() => _SwapWalletAddressState();
}

class _SwapWalletAddressState extends State<SwapWalletAddressHome> {
  int currentStep = 2;
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

  final _senderAmountController = TextEditingController();
  var showPrefixIcon = false;
  var showMemo = false;
  var acceptTermsAndConditions = false;

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
                        child: walletAddressScreen(settingsStore),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ],
    );
  }

  Widget walletAddressScreen(SettingsStore settingsStore) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Wallet Address Title
        Text(
          'Wallet Address',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff060606)),
        ),
        //Recipient Address Title / Destination wallet Address Title
        Container(
          margin: EdgeInsets.only(top: 20, left: 10, bottom: 10),
          child: Text(
            'Recipient Address',
            //'Destination wallet Address',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        //Recipient Address TextFormField / Destination wallet Address TextFormField
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: settingsStore.isDarkTheme
                ? Color(0xff24242f)
                : Color(0xfff3f3f3),
            border: Border.all(
              color: Color(0xff333343),
            ),
          ),
          child: TextFormField(
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryTextTheme.caption!.color),
            controller: _senderAmountController,
            keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: true),
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                final regEx = RegExp(r'^\d*\.?\d*');
                final newString = regEx.stringMatch(newValue.text) ?? '';
                return newString == newValue.text ? newValue : oldValue;
              }),
              FilteringTextInputFormatter.deny(RegExp('[-, ]'))
            ],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.6)),
                hintText: 'Enter your BTC recipient address',
                errorStyle: TextStyle(color: BeldexPalette.red),
                prefixIcon: showPrefixIcon
                    ? Container(
                    margin: EdgeInsets.only(right: 3, top: 3, bottom: 3),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffEBEBEB),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      'BEP2',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff060606)),
                    ))
                    : null,
                suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 20.0,
                      margin: EdgeInsets.only(left: 3, top: 3, bottom: 3),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff333343)
                              : Color(0xffEBEBEB),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/images/swap/scan_qr.svg',
                        color: settingsStore.isDarkTheme
                            ? Color(0xffA9A9CD)
                            : Color(0xff222222),
                        width: 20,
                        height: 20,
                      ),
                    ))),
          ),
        ),
        //Refund wallet Address Title
        Container(
          margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: Text(
            'Refund wallet Address',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff060606)),
          ),
        ),
        //Refund wallet Address TextFormField
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: settingsStore.isDarkTheme
                ? Color(0xff24242f)
                : Color(0xfff3f3f3),
            border: Border.all(
              color: Color(0xff333343),
            ),
          ),
          child: TextFormField(
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).primaryTextTheme.caption!.color),
            controller: _senderAmountController,
            keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: true),
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                final regEx = RegExp(r'^\d*\.?\d*');
                final newString = regEx.stringMatch(newValue.text) ?? '';
                return newString == newValue.text ? newValue : oldValue;
              }),
              FilteringTextInputFormatter.deny(RegExp('[-, ]'))
            ],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.6)),
                hintText: 'Enter your BDX refund address',
                errorStyle: TextStyle(color: BeldexPalette.red),
                suffixIcon: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 20.0,
                      margin: EdgeInsets.only(left: 3, top: 3, bottom: 3),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff333343)
                              : Color(0xffEBEBEB),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: SvgPicture.asset(
                        'assets/images/swap/scan_qr.svg',
                        color: settingsStore.isDarkTheme
                            ? Color(0xffA9A9CD)
                            : Color(0xff222222),
                        width: 20,
                        height: 20,
                      ),
                    ))),
          ),
        ),
        //Destination Tag Info
        Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
              border: Border.all(
                color: settingsStore.isDarkTheme
                    ? Color(0xff41415B)
                    : Color(0xFFDADADA),
              ),
            ),
            child: Column(
              children: [
                Row(
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
                        'Please specify the Destination Tag for your BDX receiving address if your wallet provides it. Your transaction will not go through if you omit it. If your wallet doesn’t require a Destination Tag, remove the tick.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffAFAFBE)
                                : Color(0xff77778B)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showMemo = !showMemo;
                        });
                      },
                      child: Icon(
                          showMemo
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          size: 15,
                          color: showMemo
                              ? Color(0xff20D030)
                              : settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff222222)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        'My wallet requires Destination Tag',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        //Destination Tag TextFormField
        Visibility(
          visible: showMemo,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: settingsStore.isDarkTheme
                  ? Color(0xff24242f)
                  : Color(0xfff3f3f3),
              border: Border.all(
                color: Color(0xff333343),
              ),
            ),
            child: TextFormField(
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).primaryTextTheme.caption!.color),
              controller: _senderAmountController,
              keyboardType:
              TextInputType.numberWithOptions(signed: false, decimal: true),
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final regEx = RegExp(r'^\d*\.?\d*');
                  final newString = regEx.stringMatch(newValue.text) ?? '';
                  return newString == newValue.text ? newValue : oldValue;
                }),
                FilteringTextInputFormatter.deny(RegExp('[-, ]'))
              ],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.withOpacity(0.6)),
                hintText: 'Enter Destination Tag',
                errorStyle: TextStyle(color: BeldexPalette.red),
              ),
            ),
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

        Container(
          margin:
          EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    acceptTermsAndConditions = !acceptTermsAndConditions;
                  });
                },
                child: Icon(
                    acceptTermsAndConditions
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    size: 15,
                    color: acceptTermsAndConditions
                        ? Color(0xff20D030)
                        : settingsStore.isDarkTheme
                        ? Color(0xffFFFFFF)
                        : Color(0xff222222)),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: 'I agree with Terms of Use, ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffFFFFFF)
                                : Color(0xff222222)),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          ),
                          TextSpan(
                            text: 'AML/KYC',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222)),
                          )
                        ])),
              ),
            ],
          ),
        ),
        //Exchange Button
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              if (acceptTermsAndConditions) {
                next();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: acceptTermsAndConditions
                  ? Color(0xff0BA70F)
                  : settingsStore.isDarkTheme
                  ? Color(0xff32324A)
                  : Color(0xffFFFFFF),
              padding:
              EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Next',
                style: TextStyle(
                    color: acceptTermsAndConditions
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
}

class Coins {
  Coins(this.id, this.name);

  String? id;
  String? name;
}
