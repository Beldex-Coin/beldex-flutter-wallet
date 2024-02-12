import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/swap/provider/validate_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../api_client/get_exchange_amount_api_client.dart';
import '../model/get_exchange_amount_model.dart';
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

  final _recipientAddressController = TextEditingController();
  final _destinationTagController = TextEditingController();
  final _refundWalletAddressController = TextEditingController();
  var showPrefixIcon = true;
  var showMemo = false;
  var acceptTermsAndConditions = false;
  late ValidateAddressProvider validateAddressProvider;
  late GetExchangeAmountApiClient getExchangeAmountApiClient;
  late StreamController<GetExchangeAmountModel> _getExchangeAmountStreamController;
  late Timer timer;

  @override
  void initState() {
    getExchangeAmountApiClient = GetExchangeAmountApiClient();
    // Create a stream controller and exchange amount to the stream.
    _getExchangeAmountStreamController = StreamController<GetExchangeAmountModel>();
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
        {'from': 'btc', "to": 'bdx', "amountFrom": '0.001665'}).then((value) {
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
                    child: walletAddressScreen(settingsStore, sendAmount,
                        exchangeRate, serviceFee, networkFee, getAmount,from,to),
                  ),
                ),
              ),
            ));
          }),
        ),
      ],
    );
  }

  Widget walletAddressScreen(
      SettingsStore settingsStore,
      String sendAmount,
      String exchangeRate,
      String serviceFee,
      String networkFee,
      double getAmount, String from, String to) {
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
        Consumer<ValidateAddressProvider>(
          builder: (context, validateAddressProvider, child) {
            this.validateAddressProvider = validateAddressProvider;
            if (validateAddressProvider.loading == false) {
              if (validateAddressProvider.data != null) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  validateAddressProvider.setSuccessState(
                      validateAddressProvider.data!.result!.result ?? true);
                  validateAddressProvider.setErrorMessage(
                      validateAddressProvider.data!.result!.message ?? '');
                });
              }
            }
            return Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff24242f)
                        : Color(0xfff3f3f3),
                    border: Border.all(
                      color: !validateAddressProvider.getSuccessState()
                          ? Colors.red
                          : Color(0xff333343),
                    ),
                  ),
                  child: TextFormField(
                    controller: _recipientAddressController,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color:
                            Theme.of(context).primaryTextTheme.caption!.color),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Container(
                            margin:
                                EdgeInsets.only(right: 3, top: 3, bottom: 3),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff333343)
                                    : Color(0xffEBEBEB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              '---',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff060606)),
                            )),
                        suffixIcon: validateAddressProvider.loading &&
                                _recipientAddressController.text.isNotEmpty
                            ? Container(
                                width: 10.0,
                                margin: EdgeInsets.all(6),
                                padding: EdgeInsets.all(0),
                                child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)
                                ),
                              ))
                            : InkWell(
                                onTap: () async => _presentQRScanner(
                                    context, validateAddressProvider),
                                child: Container(
                                  width: 20.0,
                                  margin: EdgeInsets.only(
                                      left: 3, top: 3, bottom: 3),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff333343)
                                          : Color(0xffEBEBEB),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: SvgPicture.asset(
                                    'assets/images/swap/scan_qr.svg',
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffA9A9CD)
                                        : Color(0xff222222),
                                    width: 20,
                                    height: 20,
                                  ),
                                )),
                        hintStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: 'Enter your ${to.toUpperCase()} recipient address',
                        errorStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: BeldexPalette.red)),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          validateAddressProvider.setRecipientAddress(value);
                          validateAddressProvider.validateAddressData(context, {
                            "currency": "${to}",
                            "address": value,
                            "extraId": ""
                          });
                        });
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          validateAddressProvider.setSuccessState(true);
                          validateAddressProvider.setErrorMessage('');
                        });
                      }
                    },
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      validateAddressProvider.getErrorMessage(),
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
                          color: Colors.red),
                    )),
                SizedBox(height: 10)
              ],
            );
          },
        ),
        //Refund wallet Address Title
        Visibility(
          visible: false,
          child: Container(
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
        ),
        //Refund wallet Address TextFormField
        Visibility(
          visible: false,
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
              controller: _refundWalletAddressController,
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
                  hintText: 'Enter your ${to.toUpperCase()} refund address',
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
                        'Please specify the Destination Tag for your ${to.toUpperCase()} receiving address if your wallet provides it. Your transaction will not go through if you omit it. If your wallet doesn’t require a Destination Tag, remove the tick.',
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
              controller: _destinationTagController,
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
                  '$sendAmount ${from.toUpperCase()}',
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
                  '1 ${from.toUpperCase()} ~ $exchangeRate ${to.toUpperCase()}',
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
                  '$serviceFee ${to.toUpperCase()}',
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
                  '$networkFee ${to.toUpperCase()}',
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
                  '~ $getAmount ${to.toUpperCase()}',
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
            onPressed: () => acceptTermsAndConditions && !validateAddressProvider.loading && _recipientAddressController.text.isNotEmpty && validateAddressProvider.successState ?{
              //Payment Screen
            }:null,
            style: ElevatedButton.styleFrom(
              primary: acceptTermsAndConditions && !validateAddressProvider.loading && _recipientAddressController.text.isNotEmpty && validateAddressProvider.successState
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

  Future<void> _presentQRScanner(BuildContext context,
      ValidateAddressProvider validateAddressProvider) async {
    try {
      final code = await presentQRScanner();
      final uri = Uri.parse(code!);
      var address = '';

      address = uri.path;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        validateAddressProvider.setRecipientAddress(address);
        _recipientAddressController.text =
            validateAddressProvider.getRecipientAddress();
        validateAddressProvider.validateAddressData(context, {
          "currency": "bdx",
          "address": _recipientAddressController.text.toString(),
          "extraId": ""
        });
      });
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  void dispose() {
    _recipientAddressController.dispose();
    _destinationTagController.dispose();
    _refundWalletAddressController.dispose();
    _getExchangeAmountStreamController.close();
    timer.cancel();
    validateAddressProvider.dispose();
    super.dispose();
  }
}

class Coins {
  Coins(this.id, this.name);

  String? id;
  String? name;
}
