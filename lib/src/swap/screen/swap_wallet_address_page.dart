import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/swap/provider/validate_address_provider.dart';
import 'package:beldex_wallet/src/swap/screen/swap_exchange_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../../../routes.dart';
import '../api_client/get_exchange_amount_api_client.dart';
import '../model/get_exchange_amount_model.dart';
import '../provider/valdiate_extra_id_field_provider.dart';
import 'number_stepper.dart';

class SwapWalletAddressPage extends BasePage {
  SwapWalletAddressPage({required this.exchangeData});

  final ExchangeData exchangeData;

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
    return SwapWalletAddressHome(exchangeData: exchangeData,);
  }
}

class SwapWalletAddressHome extends StatefulWidget {
  SwapWalletAddressHome({required this.exchangeData});

  final ExchangeData exchangeData;

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
  var acceptTermsAndConditions = false;
  late ValidateAddressProvider validateAddressProvider;
  late GetExchangeAmountApiClient getExchangeAmountApiClient;
  late StreamController<GetExchangeAmountModel> _getExchangeAmountStreamController;
  late Timer timer;
  late ExchangeData _exchangeData;
  late ValidateExtraIdFieldProvider validateExtraIdFieldProvider;
  var sendAmount;
  var from;
  var to;

  @override
  void initState() {
    _exchangeData = widget.exchangeData;
    sendAmount = _exchangeData.amountFrom;
    from = _exchangeData.from;
    to = _exchangeData.to;
    getExchangeAmountApiClient = GetExchangeAmountApiClient();
    // Create a stream controller and exchange amount to the stream.
    _getExchangeAmountStreamController = StreamController<GetExchangeAmountModel>();
    Future.delayed(Duration(seconds: 2), () {
      callGetExchangeAmountApi(getExchangeAmountApiClient, _exchangeData.amountFrom);
      timer = Timer.periodic(Duration(seconds: 30), (timer) {
        callGetExchangeAmountApi(getExchangeAmountApiClient, sendAmount);
      }); // Start adding getExchangeAmount api result to the stream.
    });
    super.initState();
  }

  void callGetExchangeAmountApi(
      GetExchangeAmountApiClient getExchangeAmountApiClient, String? amountFrom) {
    getExchangeAmountApiClient.getExchangeAmountData(context,
        {'from': _exchangeData.from, "to": _exchangeData.to, "amountFrom": amountFrom}).then((value) {
      _getExchangeAmountStreamController.sink.add(value!);
    });
  }

  bool isNextButtonEnabled(String minimumAmount, String maximumAmount){
    if(validateExtraIdFieldProvider.showMemo){
      if(_destinationTagController.text.isEmpty){
        return false;
      }else {
        return acceptTermsAndConditions &&
            !validateAddressProvider.loading &&
            _recipientAddressController.text.isNotEmpty &&
            validateAddressProvider.successState && (minimumAmount.trim().isEmpty && maximumAmount.trim().isEmpty);
      }
    }else{
      return acceptTermsAndConditions && !validateAddressProvider.loading && _recipientAddressController.text.isNotEmpty && validateAddressProvider.successState && (minimumAmount.trim().isEmpty && maximumAmount.trim().isEmpty);
    }
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
          return body(_screenWidth, _screenHeight, settingsStore,
              _scrollController, snapshot.data!);
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
    var exchangeRate = "---";
    var serviceFee = "---";
    var networkFee = "---";
    var getAmount = "---";
    var minimumAmount = "";
    var maximumAmount = "";
    if(getExchangeAmountModel.result!.isNotEmpty){
      sendAmount = getExchangeAmountModel.result![0].amountFrom.toString();
      exchangeRate = getExchangeAmountModel.result![0].rate.toString();
      serviceFee = getExchangeAmountModel.result![0].fee.toString();
      networkFee = getExchangeAmountModel.result![0].networkFee.toString();
      getAmount = getExchangeAmountModel.result![0].amountTo!.toString();
      from = getExchangeAmountModel.result![0].from.toString();
      to = getExchangeAmountModel.result![0].to.toString();
      minimumAmount = "";
      maximumAmount = "";
    } else {
      if(getExchangeAmountModel.error != null){
        if(double.parse(_exchangeData.amountFrom!) < double.parse(getExchangeAmountModel.error!.data!.limits!.min!.from!)){
          minimumAmount = getExchangeAmountModel.error!.data!.limits!.min!.from!;
        }
        if(double.parse(_exchangeData.amountFrom!) > double.parse(getExchangeAmountModel.error!.data!.limits!.max!.from!)){
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
                    child: walletAddressScreen(settingsStore,
                        exchangeRate, serviceFee, networkFee, getAmount, minimumAmount, maximumAmount),
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
      String exchangeRate,
      String serviceFee,
      String networkFee,
      String getAmount, String minimumAmount, String maximumAmount) {
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
                  padding: EdgeInsets.only(left: 5, right: 5),
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
                            Theme.of(context).primaryTextTheme.bodySmall!.color),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    textAlignVertical: TextAlignVertical(y: 0.0),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Container(
                            margin: EdgeInsets.only(right: 3, top: 5, bottom: 3,),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff333343)
                                    : Color(0xffEBEBEB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              _exchangeData.protocol ?? "---",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
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
                                    context, validateAddressProvider,to, ),
                                child: Container(
                                  width: 10,
                                  margin: EdgeInsets.only(top: 5, bottom: 3),
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
                                    width: 10,
                                    height: 10,
                                  ),
                                )),
                        hintStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.6)),
                        hintText: 'Enter your ${to.toUpperCase()} recipient address',
                        errorStyle: TextStyle(backgroundColor: Colors.transparent,height: 0.1)),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          validateAddressProvider.setRecipientAddress(value);
                          validateAddressProvider.validateAddressData(context, {
                            "currency": "${to}",
                            "address": value,
                            "extraId": _exchangeData.extraIdName!
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
                Visibility(
                  visible: validateAddressProvider.getErrorMessage().trim().isNotEmpty,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        validateAddressProvider.getErrorMessage(),
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Colors.red),
                      )),
                ),
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
                  color: Theme.of(context).primaryTextTheme.bodySmall!.color),
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

        Consumer<ValidateExtraIdFieldProvider>(
          builder: (context, validateExtraIdFieldProvider, child) {
            this.validateExtraIdFieldProvider = validateExtraIdFieldProvider;
            return Column(
              children: [
                //Extra Id Name Info
                Visibility(
                  visible: _exchangeData.extraIdName!.isNotEmpty,
                  child: Container(
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
                                  'Please specify the ${_exchangeData.extraIdName} for your ${to.toUpperCase()} receiving address if your wallet provides it. Your transaction will not go through if you omit it. If your wallet doesn’t require a ${_exchangeData.extraIdName}, remove the tick.',
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
                                  _destinationTagController.clear();
                                  validateExtraIdFieldProvider.setShowErrorBorder(false);
                                  validateExtraIdFieldProvider.setErrorMessage("");
                                  validateExtraIdFieldProvider.setShowMemo(!validateExtraIdFieldProvider.getShowMemo());
                                },
                                child: Icon(
                                    validateExtraIdFieldProvider.getShowMemo()
                                        ? Icons.check_box_outlined
                                        : Icons.check_box_outline_blank,
                                    size: 15,
                                    color: validateExtraIdFieldProvider.getShowMemo()
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
                                  'My wallet requires ${_exchangeData.extraIdName}',
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
                ),
                //Extra Id Name TextFormField
                Visibility(
                  visible: validateExtraIdFieldProvider.getShowMemo(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff24242f)
                              : Color(0xfff3f3f3),
                          border: Border.all(
                            color: validateExtraIdFieldProvider.getShowErrorBorder()
                                ? Colors.red
                                : Color(0xff333343),
                          ),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).primaryTextTheme.bodySmall!.color),
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
                            hintText: 'Enter ${_exchangeData.extraIdName}',
                            errorStyle: TextStyle(color: BeldexPalette.red),
                          ),
                          onChanged: (value){
                            if(value.isEmpty){
                              validateExtraIdFieldProvider.setShowErrorBorder(true);
                              validateExtraIdFieldProvider.setErrorMessage("Please enter ${_exchangeData.extraIdName}");
                            }else{
                              validateExtraIdFieldProvider.setErrorMessage("");
                              validateExtraIdFieldProvider.setShowErrorBorder(false);
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible:validateExtraIdFieldProvider.getErrorMessage().isNotEmpty,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              validateExtraIdFieldProvider.getErrorMessage(),
                              style: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Colors.red),
                            )),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        Visibility(
          visible: minimumAmount.trim().isNotEmpty || maximumAmount.trim().isNotEmpty,
          child: Container(
            margin: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: Color(0xff00AD07).withAlpha(25),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: InkWell(
              onTap: (){
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
              },
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
        Consumer<ValidateExtraIdFieldProvider>(
          builder: (context, validateExtraIdFieldProvider, child) {
            this.validateExtraIdFieldProvider = validateExtraIdFieldProvider;
            return Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if(validateExtraIdFieldProvider.showMemo){
                    if(_destinationTagController.text.isEmpty){
                      validateExtraIdFieldProvider.setShowErrorBorder(true);
                      validateExtraIdFieldProvider.setErrorMessage("Please enter ${_exchangeData.extraIdName}");
                    }else {
                      if (acceptTermsAndConditions && !validateAddressProvider.loading && _recipientAddressController.text.isNotEmpty && validateAddressProvider.successState && (minimumAmount.trim().isEmpty && maximumAmount.trim().isEmpty)) {
                        //Navigate to Payment Screen
                        Navigator.of(context).pop();
                        Navigator.of(context, rootNavigator: true).pushNamed(Routes.swapPayment,arguments: ExchangeDataWithRecipientAddress(_exchangeData.from, _exchangeData.to, _exchangeData.amountFrom, _destinationTagController.text, _recipientAddressController.text, _exchangeData.fromBlockChain, _exchangeData.toBlockChain));
                      }
                    }
                  }else{
                    if(acceptTermsAndConditions && !validateAddressProvider.loading && _recipientAddressController.text.isNotEmpty && validateAddressProvider.successState && (minimumAmount.trim().isEmpty && maximumAmount.trim().isEmpty)){
                      //Navigate to Payment Screen
                      Navigator.of(context).pop();
                      Navigator.of(context, rootNavigator: true).pushNamed(Routes.swapPayment,arguments: ExchangeDataWithRecipientAddress(_exchangeData.from, _exchangeData.to, _exchangeData.amountFrom, "", _recipientAddressController.text, _exchangeData.fromBlockChain, _exchangeData.toBlockChain));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isNextButtonEnabled(minimumAmount, maximumAmount)
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
                        color: isNextButtonEnabled(minimumAmount, maximumAmount)
                            ? Color(0xffffffff)
                            : settingsStore.isDarkTheme
                            ? Color(0xff77778B)
                            : Color(0xffB1B1D1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _presentQRScanner(BuildContext context,
      ValidateAddressProvider validateAddressProvider, String to) async {
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
          "currency": "${to}",
          "address": _recipientAddressController.text.toString(),
          "extraId": _exchangeData.extraIdName!
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

class ExchangeDataWithRecipientAddress {
  ExchangeDataWithRecipientAddress(this.from, this.to, this.amountFrom, this.extraIdName, this.recipientAddress, this.fromBlockChain, this.toBlockChain);

  String? from;
  String? to;
  String? amountFrom;
  String? extraIdName = "";
  String? recipientAddress = "";
  String? fromBlockChain;
  String? toBlockChain;
}
