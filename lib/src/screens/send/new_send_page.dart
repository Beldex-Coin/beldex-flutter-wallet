import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:beldex_wallet/src/domain/common/fiatCurrencyModel.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:beldex_wallet/src/screens/send/confirm_sending.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/widgets/loading_provider.dart';
import 'package:beldex_wallet/src/widgets/new_slide_to_act.dart';
import 'package:delayed_consumer_hud/delayed_consumer_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/send/sending_state.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/calculate_estimated_fee.dart';
import 'package:beldex_wallet/src/widgets/address_text_field.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:beldex_wallet/src/widgets/slide_to_act.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:beldex_wallet/src/util/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

bool canLoad = false;

class SendPage extends BasePage {
  String controller;

  @override
  String get title => S.current.send; //wallet_list_title;

  // @override
  // Widget leading(BuildContext context) {
  //   final settingsStore = Provider.of<SettingsStore>(context);
  //   return Container(
  //       padding: const EdgeInsets.only(top: 12.0, left: 10),
  //       child: Image.asset(settingsStore.isDarkTheme ? 'assets/images/new-images/arrow_white.png': 'assets/images/new-images/arrow_white.png') //SvgPicture.asset('assets/images/beldex_logo_foreground1.svg')
  //       );
  // }

  @override
  Widget trailing(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container();
    // Container(
    //   width: 60,
    //   height: 60,
    //   alignment: Alignment.centerLeft,
    //   // decoration: BoxDecoration(
    //   //   color: Theme.of(context).accentTextTheme.headline6.color,
    //   //   borderRadius: BorderRadius.only(
    //   //       topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
    //   //   boxShadow: [
    //   //     BoxShadow(
    //   //       color: Theme.of(context).accentTextTheme.headline6.color,
    //   //       blurRadius: 2.0,
    //   //       spreadRadius: 1.0,
    //   //       offset: Offset(2.0, 2.0), // shadow direction: bottom right
    //   //     )
    //   //   ],
    //   // ),
    //   child: SizedBox(
    //     height: 55, //55
    //     width: 55, //37
    //     child: ButtonTheme(
    //       minWidth: double.minPositive,
    //       child: TextButton(
    //           /* highlightColor: Colors.transparent,
    //           splashColor: Colors.transparent,
    //           padding: EdgeInsets.all(0),*/
    //           style: ButtonStyle(
    //             overlayColor: MaterialStateColor.resolveWith(
    //                 (states) => Colors.transparent),
    //           ),
    //           onPressed: () => Navigator.of(context).pushNamed(Routes.profile),
    //           child: SvgPicture.asset(
    //             'assets/images/new-images/setting.svg',
    //             fit: BoxFit.cover,
    //             color:settingsStore.isDarkTheme ? Color(0xffFFFFFF) : Color(0xff16161D),
    //             width: 25,
    //             height: 25,
    //           ) /*Icon(Icons.account_circle_rounded,
    //               color: Theme.of(context).primaryTextTheme.caption.color,
    //               size: 30)*/
    //           ),
    //     ),
    //   ),
    // );
  }

  @override
  Color get textColor => Colors.white;

  @override
  bool get isModalBackButton => false;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget body(BuildContext context) => SendForm(
        controllerValue: controller,
      );
}

class SendForm extends StatefulWidget {
  final String controllerValue;

  SendForm({Key key, @required this.controllerValue}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SendFormState();
}

class SendFormState extends State<SendForm> with TickerProviderStateMixin {
  final _addressController = TextEditingController();
  final _cryptoAmountController = TextEditingController();
  final _fiatAmountController = TextEditingController();

  final _focusNodeAddress = FocusNode();

  bool _effectsInstalled = false;

  // bool _isFlashTransaction = false;
  final _formKey = GlobalKey<FormState>();

  //
  var controller = StreamController<double>.broadcast();
  double position;
  AnimationController animationController;

  bool addressValidation = false;
  var addressErrorMessage = "";
  bool amountValidation = false;
  var amountErrorMessage = "";
  final List<ReactionDisposer> reactionDisposers =
      []; // dispose the reactions we used in this file to avoid the memory leaks
  final List<ReactionDisposer> whenDisposers =
      []; //dispose the when functions we used in this file to avoid the memory leaks
  ReactionDisposer rdisposer1, rdisposer2, rdisposer3;

  @override
  void initState() {
    _focusNodeAddress.addListener(() {
      if (!_focusNodeAddress.hasFocus && _addressController.text.isNotEmpty) {
        getOpenAliasRecord(context);
      }
    });

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);

// getQrvalue();
    if (widget.controllerValue != null || widget.controllerValue != '') {
      setState(() {
        _addressController.text = widget.controllerValue;
      });
    }

    super.initState();
  }

  bool getAmountValidation(String amount) {
    final maxValue = 150000000.00000;
    final pattern = RegExp(r'^(([0-9]{1,9})(\.[0-9]{1,5})?$)|\.[0-9]{1,5}?$');
    var isValid = false;

    if (pattern.hasMatch(amount)) {
      try {
        final dValue = double.parse(amount);
        isValid = (dValue <= maxValue && dValue > 0);
      } catch (e) {
        isValid = false;
      }
    }
    return isValid;
  }

  bool getAddressBasicValidation(String value) {
    final pattern = RegExp(r'^[a-zA-Z0-9]+$');
    if (!pattern.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

// Dispose of the 'reaction' and 'when' reactions

  @override
  void dispose() {
    animationController.dispose();
    rdisposer1?.call();
    rdisposer2?.call();
    rdisposer3?.call();

    super.dispose();
  }

  Future<void> getOpenAliasRecord(BuildContext context) async {
    final sendStore = Provider.of<SendStore>(context, listen: false);
    final isOpenAlias =
        await sendStore.isOpenaliasRecord(_addressController.text);

    if (isOpenAlias) {
      _addressController.text = sendStore.recordAddress;

      await showSimpleBeldexDialog(context, S.of(context).openalias_alert_title,
          S.of(context).openalias_alert_content(sendStore.recordName),
          onPressed: (_) => Navigator.of(context).pop());
    }
  }

  void _loading(bool _canLoad) {
    // setState(() {
    //   canLoad = true;
    // });

    // Simulate an asynchronous task, e.g., fetching data from an API
    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     canLoad = false;
    //   });

    //   // Close the HUD progress loader
    //   Navigator.pop(context);
    // });
    if (_canLoad) {
      // Show the HUD progress loader
      showHUDLoader(context);
    } else {
      Navigator.pop(context);
    }
  }

  void showHUDLoader(BuildContext context) {
    //final settingsStore = Provider.of<SettingsStore>(context,listen: false);
    showDialog<void>(
      context: context,
      //barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevent closing the dialog when the user presses the back button
          onWillPop: () async => false,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

            //backgroundColor: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text('Creating the Transaction',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        );
      },
    );
  }


void setLoaderPage(BuildContext context){
  final loadingProvider = Provider.of<LoadingProvider>(context);
     if(loadingProvider.isLoading){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       
           await showDialog<void>(
      context: context,
      //barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevent closing the dialog when the user presses the back button
          onWillPop: () async => false,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

            //backgroundColor: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text('Creating the Transaction',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        );
      },
    );
          
        });
     }
}



  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final sendStore = Provider.of<SendStore>(context);
    sendStore.settingsStore = settingsStore;
    final balanceStore = Provider.of<BalanceStore>(context);
    final walletStore = Provider.of<WalletStore>(context);
    final syncStore = Provider.of<SyncStore>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    _setEffects(context);
    setLoaderPage(context);
    return ScrollableWithBottomSection(
      //bottomSectionPadding: EdgeInsets.only(bottom: 230),
      content: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.50 / 3,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: settingsStore.isDarkTheme
                              ? Color(0xff454557)
                              : Color(0xffDADADA)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Observer(builder: (_) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /* Text(S.of(context).send_your_wallet,
                                      style: TextStyle(
                                          fontSize: 12, color: BeldexPalette.teal)),*/
                              Text(
                                walletStore.name,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6
                                        .color),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                walletStore.account != null
                                    ? '${walletStore.account.label}'
                                    : '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff9292A7)
                                        : Color(0xff737373)
                                    // Theme.of(context)
                                    //     .accentTextTheme
                                    //     .caption
                                    //     .decorationColor //Theme.of(context).primaryTextTheme.headline6.color
                                    ),
                              ),
                            ]);
                      }),
                      Observer(builder: (context) {
                        final savedDisplayMode =
                            settingsStore.balanceDisplayMode;
                        final availableBalance = savedDisplayMode ==
                                BalanceDisplayMode.hiddenBalance
                            ? '---'
                            : savedDisplayMode == BalanceDisplayMode.fullBalance
                                ? balanceStore.fullBalanceString
                                : balanceStore.unlockedBalanceString;

                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*Text(S.current.beldex_available_balance,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .overline
                                            .backgroundColor,
                                      )),*/
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text('Available BDX : ',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .caption
                                            .color,
                                        fontSize: 16,
                                        //fontWeight: FontWeight.w600,
                                      )),
                                  Text(availableBalance,
                                      style: TextStyle(
                                        color: Color(0xff0BA70F),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ]);
                      }),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).send_beldex_address,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700)),
                      GestureDetector(
                          onTap: () => AddressTextField()
                              .presetAddressBookPicker(context),
                          child: SvgPicture.asset(
                              'assets/images/new-images/Address.svg',
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffffffff)
                                  : Color(0xff16161D)))
                    ],
                  ),
                ),

                // Card(
                //   elevation:0, //2,
                //   color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                //  // margin: EdgeInsets.only(left: constants.leftPx, right: constants.rightPx, top: 30),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   child: Container(
                //     color: Colors.transparent,
                //     width: MediaQuery.of(context).size.width,
                //     padding:
                //         EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Observer(builder: (_) {
                //           return Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 /* Text(S.of(context).send_your_wallet,
                //                       style: TextStyle(
                //                           fontSize: 12, color: BeldexPalette.teal)),*/
                //                 Text(
                //                   walletStore.name,
                //                   style: TextStyle(
                //                       fontSize: 25,
                //                       fontWeight: FontWeight.bold,
                //                       color: Theme.of(context)
                //                           .primaryTextTheme
                //                           .headline6
                //                           .color),
                //                 ),
                //                 SizedBox(
                //                   height: 10,
                //                 ),
                //                 Text(
                //                   walletStore.account != null
                //                       ? '${walletStore.account.label}'
                //                       : '',
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 16,
                //                       color: Theme.of(context)
                //                           .accentTextTheme
                //                           .caption
                //                           .decorationColor //Theme.of(context).primaryTextTheme.headline6.color
                //                       ),
                //                 ),
                //               ]);
                //         }),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Observer(builder: (context) {
                //           final savedDisplayMode = settingsStore.balanceDisplayMode;
                //           final availableBalance =
                //               savedDisplayMode == BalanceDisplayMode.hiddenBalance
                //                   ? '---'
                //                   : savedDisplayMode==BalanceDisplayMode.fullBalance?balanceStore.fullBalanceString:balanceStore.unlockedBalanceString;

                //           return Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 /*Text(S.current.beldex_available_balance,
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                         color: Theme.of(context)
                //                             .accentTextTheme
                //                             .overline
                //                             .backgroundColor,
                //                       )),*/
                //                 Text(availableBalance,
                //                     style: TextStyle(
                //                       color: Theme.of(context)
                //                           .primaryTextTheme
                //                           .caption
                //                           .color,
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.bold,
                //                     )),
                //               ]);
                //         }),
                //         SizedBox(height: 12,)
                //         /*Align(
                //           alignment: Alignment.centerRight,
                //           child: GestureDetector(
                //             onTap: () {},
                //             child: Container(
                //               width: 65,
                //               height: 30,
                //               decoration: BoxDecoration(
                //                 gradient: LinearGradient(
                //                   colors: [
                //                     Color.fromARGB(255, 40, 42, 51),
                //                     Theme.of(context).backgroundColor,
                //                   ],
                //                   begin: Alignment.topLeft,
                //                   end: Alignment.bottomRight,
                //                 ),
                //                 borderRadius: BorderRadius.circular(20),
                //                 border: Border.all(color: Colors.grey[600]),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.black12,
                //                     offset: Offset(5, 5),
                //                     blurRadius: 10,
                //                   )
                //                 ],
                //               ),
                //               child: Center(
                //                 child: Text(
                //                   'Change',
                //                   style: TextStyle(
                //                     color: Theme.of(context)
                //                         .primaryTextTheme
                //                         .button
                //                         .backgroundColor,
                //                     fontSize: 13,
                //                     fontWeight: FontWeight.w500,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),*/
                //       ],
                //     ),
                //   ),
                // ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(
                        //left: constants.leftPx, right: constants.rightPx,
                        top: 25,
                        bottom: 30),
                    child: Column(children: <Widget>[
                      //Beldex Address
                      AddressTextField(
                        controller: _addressController,
                        placeholder: S.of(context).send_beldex_address,
                        focusNode: _focusNodeAddress,
                        onURIScanned: (uri) {
                          var address = '';
                          var amount = '';
                          if (uri != null) {
                            address = uri.path;
                            if (uri.queryParameters[
                                    uri.queryParameters.keys.first] !=
                                null) {
                              amount = uri.queryParameters[
                                  uri.queryParameters.keys.first];
                            }
                          } else {
                            address = uri.toString();
                          }

                          _addressController.text = address;
                          _cryptoAmountController.text = amount;
                        },
                        options: [
                          AddressTextFieldOption.saveAddress,
                          AddressTextFieldOption.qrCode,

                          //AddressTextFieldOption.addressBook
                        ],
                        validator: (value) {
                          /* if(value.isEmpty){
                            return 'Please fill in this field\n';
                          }else {
                            sendStore.validateAddress(value,
                                cryptoCurrency: CryptoCurrency.bdx);
                            return sendStore.errorMessage;
                          }*/

                          if (value.isEmpty) {
                            setState(() {
                              addressValidation = true;
                              addressErrorMessage =
                                  'Please enter a bdx address';
                            });
                            return null;
                          } else {
                            final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

                            if (!alphanumericRegex.hasMatch(value)) {
                              setState(() {
                                addressErrorMessage = 'Enter a valid address';
                              });
                              return;
                            } else {
                              if (getAddressBasicValidation(value)) {
                                sendStore.validateAddress(value,
                                    cryptoCurrency: CryptoCurrency.bdx);
                                if (sendStore.errorMessage != null) {
                                  setState(() {
                                    addressValidation = true;
                                    addressErrorMessage = 'Invalid bdx address';
                                  });
                                } else {
                                  setState(() {
                                    addressValidation = false;
                                    addressErrorMessage = '';
                                  });
                                }
                                return null;
                              } else {
                                setState(() {});
                                addressErrorMessage = 'Enter a valid address';
                                return;
                              }
                            }
                          }
                        },
                      ),
                      Visibility(
                        visible: addressValidation,
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  addressErrorMessage,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ))),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          top: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Enter BDX to Send',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),

                      Container(
                          height: MediaQuery.of(context).size.height * 0.60 / 3,
                          //150,
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          padding: EdgeInsets.only(
                            left: 15,
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff272733)
                                  : Color(0xffEDEDED)),
                          child: Column(
                            children: [
                              TextFormField(
                                  style: TextStyle(
                                      fontSize: 26.0,
                                      //fontFamily: 'Poppinsbold',
                                      fontWeight: FontWeight.w900,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .caption
                                          .color),
                                  controller: _cryptoAmountController,
                                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp('[-, ]'))
                                  ],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      /*prefixIcon: SizedBox(
                                              width: 75,
                                              child: Padding(
                                                  padding: EdgeInsets.only(left: 8, top: 12),
                                                  child: Text('Beldex:',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Theme.of(context)
                                                              .accentTextTheme
                                                              .overline
                                                              .color))),
                                            ),
                                            suffixIcon: Container(
                                              width: 1,
                                              padding: EdgeInsets.only(top: 0),
                                              child: Center(
                                                  child: InkWell(
                                                      onTap: () => sendStore.setSendAll(),
                                                      child: Text(S.of(context).all,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Theme.of(context)
                                                                  .accentTextTheme
                                                                  .overline
                                                                  .decorationColor)))),
                                            ),*/
                                      hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff77778B)
                                              : Color(0xff6F6F6F)),
                                      hintText: 'Enter Amount',
                                      //'00.000000000',
                                      /*focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: BeldexPalette.teal, width: 2.0)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context).focusColor,
                                                    width: 1.0)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: BeldexPalette.red, width: 1.0)),
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: BeldexPalette.red, width: 1.0)),*/
                                      errorStyle:
                                          TextStyle(color: BeldexPalette.red)),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        amountValidation = true;
                                        amountErrorMessage =
                                            'Please enter a amount';
                                      });
                                      return null;
                                    } else {
                                      if (getAmountValidation(value)) {
                                        sendStore.validateBELDEX(value,
                                            balanceStore.unlockedBalance);
                                        if (sendStore.errorMessage != null) {
                                          setState(() {
                                            amountValidation = true;
                                            amountErrorMessage = S.current
                                                .pleaseEnterAValidAmount;
                                          });
                                          return;
                                        } else {
                                          setState(() {
                                            amountValidation = false;
                                            amountErrorMessage = "";
                                          });
                                        }
                                        return null;
                                      } else {
                                        setState(() {
                                          amountValidation = true;
                                          amountErrorMessage =
                                              'Enter a valid amount';
                                        });
                                        return;
                                      }
                                    }
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 50,
                                      width: 170,
                                      // padding: EdgeInsets.all(8.0),
                                      margin:
                                          EdgeInsets.only(top: 15, right: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff1A1A23)
                                              : Color(0xffFFFFFF)),
                                      child: Row(
                                        children: [
                                          Observer(builder: (_) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                '${settingsStore.fiatCurrency.toString()}',
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }),
                                          Expanded(
                                            child: Container(
                                                width: 120,
                                                padding: EdgeInsets.only(
                                                  left: 8,
                                                  right: 10,
                                                ),
                                                child: TextField(
                                                  readOnly: true,
                                                  controller:
                                                      _fiatAmountController,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      /*prefixIcon: SizedBox(
                                                width: 75,
                                                child: Padding(
                                                    padding: EdgeInsets.only(left: 8, top: 12),
                                                    child: Text('Beldex:',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Theme.of(context)
                                                                .accentTextTheme
                                                                .overline
                                                                .color))),
                                              ),
                                              suffixIcon: Container(
                                                width: 1,
                                                padding: EdgeInsets.only(top: 0),
                                                child: Center(
                                                    child: InkWell(
                                                        onTap: () => sendStore.setSendAll(),
                                                        child: Text(S.of(context).all,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Theme.of(context)
                                                                    .accentTextTheme
                                                                    .overline
                                                                    .decorationColor)))),
                                              ),*/
                                                      hintStyle: TextStyle(
                                                          fontSize: 15.0,
                                                          color: settingsStore
                                                                  .isDarkTheme
                                                              ? Color(
                                                                  0xffffffff)
                                                              : Color(
                                                                  0xff16161D)
                                                          // color: Theme.of(context)
                                                          //     .hintColor
                                                          ),
                                                      hintText: '00.000000000',
                                                      /*focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: BeldexPalette.teal, width: 2.0)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Theme.of(context).focusColor,
                                                      width: 1.0)),
                                              errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: BeldexPalette.red, width: 1.0)),
                                              focusedErrorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: BeldexPalette.red, width: 1.0)),*/
                                                      errorStyle: TextStyle(
                                                          color: BeldexPalette
                                                              .red)),
                                                )),
                                          )
                                        ],
                                      )),
                                ],
                              )
                            ],
                          )),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //           flex: 2,
                      //           child: Align(
                      //             alignment: Alignment.center,
                      //             child: Text(
                      //               'Beldex',
                      //               style: TextStyle(
                      //                   color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           )),
                      //       Expanded(
                      //         flex: 4,
                      //         child: Card(
                      //           elevation: 2,
                      //           color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(10)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(left: 25.0),
                      //             child: TextFormField(
                      //                 style: TextStyle(
                      //                     fontSize: 18.0, color: Theme.of(context).primaryTextTheme.caption.color),
                      //                 controller: _cryptoAmountController,
                      //                 keyboardType: TextInputType.numberWithOptions(
                      //                     signed: false, decimal: true),
                      //                 inputFormatters: [
                      //                   FilteringTextInputFormatter.deny(
                      //                       RegExp('[- ]'))
                      //                 ],
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     /*prefixIcon: SizedBox(
                      //                         width: 75,
                      //                         child: Padding(
                      //                             padding: EdgeInsets.only(left: 8, top: 12),
                      //                             child: Text('Beldex:',
                      //                                 style: TextStyle(
                      //                                     fontSize: 18,
                      //                                     color: Theme.of(context)
                      //                                         .accentTextTheme
                      //                                         .overline
                      //                                         .color))),
                      //                       ),
                      //                       suffixIcon: Container(
                      //                         width: 1,
                      //                         padding: EdgeInsets.only(top: 0),
                      //                         child: Center(
                      //                             child: InkWell(
                      //                                 onTap: () => sendStore.setSendAll(),
                      //                                 child: Text(S.of(context).all,
                      //                                     style: TextStyle(
                      //                                         fontSize: 10,
                      //                                         color: Theme.of(context)
                      //                                             .accentTextTheme
                      //                                             .overline
                      //                                             .decorationColor)))),
                      //                       ),*/
                      //                     hintStyle: TextStyle(
                      //                         fontSize: 18.0, color:Theme.of(context).hintColor),
                      //                     hintText: '00.000000000',
                      //                     /*focusedBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: BeldexPalette.teal, width: 2.0)),
                      //                       enabledBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Theme.of(context).focusColor,
                      //                               width: 1.0)),
                      //                       errorBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: BeldexPalette.red, width: 1.0)),
                      //                       focusedErrorBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: BeldexPalette.red, width: 1.0)),*/
                      //                     errorStyle:
                      //                         TextStyle(color: BeldexPalette.red)),
                      //                 validator: (value) {
                      //                   if(value.isEmpty){
                      //                     setState(() {
                      //                       amountValidation = true;
                      //                       amountErrorMessage = 'Please enter a amount';
                      //                     });
                      //                     return null;
                      //                   }else {
                      //                     sendStore.validateBELDEX(
                      //                         value,
                      //                         balanceStore.unlockedBalance);
                      //                     if(sendStore.errorMessage!=null) {
                      //                       setState(() {
                      //                         amountValidation = true;
                      //                         amountErrorMessage = 'The enter a valid amount';
                      //                       });
                      //                     }else{
                      //                       setState(() {
                      //                         amountValidation = false;
                      //                         amountErrorMessage = "";
                      //                       });
                      //                     }
                      //                     return null;
                      //                   }
                      //                 }),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Visibility(
                        visible: amountValidation,
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //     flex: 2,
                                    //     child: Container()),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        amountErrorMessage,
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ))),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 20),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //           flex: 2,
                      //           child: Align(
                      //             alignment: Alignment.center,
                      //             child: Text(
                      //               '${settingsStore.fiatCurrency.toString()}',
                      //               style: TextStyle(
                      //                   color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           )),
                      //       Expanded(
                      //         flex: 4,
                      //         child: Card(
                      //           elevation: 2,
                      //           color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(10)),
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(left: 25.0),
                      //             child: TextFormField(
                      //                 style: TextStyle(
                      //                     fontSize: 18.0, color: Theme.of(context).primaryTextTheme.caption.color),
                      //                 controller: _fiatAmountController,
                      //                 keyboardType: TextInputType.numberWithOptions(
                      //                     signed: false, decimal: true),
                      //                 inputFormatters: [
                      //                   FilteringTextInputFormatter.deny(
                      //                       RegExp('[- ]'))
                      //                 ],
                      //                 decoration: InputDecoration(
                      //                     border: InputBorder.none,
                      //                     /* prefixIcon: SizedBox(
                      //                         width: 75,
                      //                         child: Padding(
                      //                             padding: EdgeInsets.only(left: 8, top: 12),
                      //                             child: Text(
                      //                                 '${settingsStore.fiatCurrency.toString()}:',
                      //                                 style: TextStyle(
                      //                                     fontSize: 18,
                      //                                     color: Theme.of(context)
                      //                                         .accentTextTheme
                      //                                         .overline
                      //                                         .color))),
                      //                       ),*/
                      //                     hintStyle: TextStyle(
                      //                         fontSize: 18.0, color: Theme.of(context).hintColor),
                      //                     hintText: '00.000000000',
                      //                     /* focusedBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: BeldexPalette.teal, width: 2.0)),
                      //                       enabledBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: Theme.of(context).focusColor,
                      //                               width: 1.0)),
                      //                       errorBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: BeldexPalette.red, width: 1.0)),
                      //                       focusedErrorBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                               color: BeldexPalette.red, width: 1.0)),*/
                      //                     errorStyle:
                      //                         TextStyle(color: BeldexPalette.red))),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('${S.of(context).send_estimated_fee}   ',
                                style: TextStyle(
                                  fontSize: 15,
                                  //fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .grey, //Theme.of(context).accentTextTheme.overline.backgroundColor,
                                )),
                            Text(
                                '${calculateEstimatedFee(priority: settingsStore.transactionPriority //BeldexTransactionPriority.flash
                                    )}',
                                //'${calculateEstimatedFee(priority: BeldexTransactionPriority.slow)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .grey, //Theme.of(context).primaryTextTheme.overline.backgroundColor,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                            S.of(context).send_priority(
                                settingsStore.transactionPriority.toString()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors
                                  .grey, //Theme.of(context).primaryTextTheme.subtitle2.color,
                            )),
                      ),
                      /* Observer(
                        builder: (_) {
                          return InkWell(
                            onTap: () {
                              syncStore.status is SyncedSyncStatus
                                  ? () async {
                                      if (_formKey.currentState.validate()) {
                                        var isSuccessful = false;

                                        await Navigator.of(context)
                                            .pushNamed(Routes.auth, arguments:
                                                (bool isAuthenticatedSuccessfully,
                                                    AuthPageState auth) async {
                                          if (!isAuthenticatedSuccessfully) {
                                            isSuccessful = false;
                                            return;
                                          }

                                          await sendStore.createTransaction(
                                              address: _addressController.text);

                                          Navigator.of(auth.context).pop();
                                          isSuccessful = true;
                                        });
                                        return isSuccessful;
                                      } else {
                                        return false;
                                      }
                                    }
                                  : null;
                            },
                            child: Column(
                              children: [
                                ClipOval(
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.green.shade600,
                                        Colors.green,
                                        Colors.blue
                                      ], transform: GradientRotation(math.pi / 4)),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .backgroundColor, //kHintColor, so this should be changed?
                                      ),
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: ClipOval(
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        width: 75,
                                        // this width forces the container to be a circle
                                        height: 75,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).backgroundColor,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        // this height forces the container to be a circle
                                        child: SvgPicture.asset(
                                          'assets/images/up_arrow_svg.svg',
                                          color: Colors.white,
                                          width: 25,
                                          height: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(S.current.send_title,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors
                                          .grey, //Theme.of(context).accentTextTheme.overline.backgroundColor,
                                    )),
                              ],
                            ),
                          );
                        },
                      ),*/
                    ]),
                  ),
                ),
                /*SizedBox(height: 110,)*/
              ],
            ),
            /*Observer(
              builder: (_) {
                return  ElevatedButton(
                  onPressed: ()async{
                    print('send page syncStore status ${syncStore.status.progress()}, ${syncStore.status.title()}, ${syncStore.status is SyncedSyncStatus}');
                    //syncStore.status is SyncedSyncStatus
                      //  ? () async {
                      print('before _formKey.currentState.validate()');
                      if (_formKey.currentState
                          .validate()) {
                        var isSuccessful = false;

                        await Navigator.of(context).pushNamed(
                            Routes.auth, arguments: (bool
                        isAuthenticatedSuccessfully,
                            AuthPageState auth) async {
                          if (!isAuthenticatedSuccessfully) {
                            isSuccessful = false;
                            return;
                          }

                          await sendStore.createTransaction(
                              address:
                              _addressController.text);

                          Navigator.of(auth.context).pop();
                          isSuccessful = true;
                        });
                        print('send page --> success');
                        return isSuccessful;
                      } else {
                        print('send page fail');
                        return false;
                      }
                    //}
                       // : null;
                    print('sdadasda');
                  },
                  child: Text('Submit'),
                );
              },
            ),*/
            /* Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Container(
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0 * animationController.value),
                          child: child,
                        ),
                      );
                    },
                    child: Observer(
                      builder: (_) {
                        return StreamBuilder<double>(
                          stream: controller.stream,
                          builder: (context, spanshot) => GestureDetector(
                            onVerticalDragUpdate:
                                (DragUpdateDetails details) {
                              position =
                                  MediaQuery.of(context).size.height -
                                      details.globalPosition.dy;
                              if (!position.isNegative && position < 240) {
                                controller.add(position);
                              }
                            },
                            onVerticalDragEnd: (details) {
                              controller.add(
                                  MediaQuery.of(context).size.height *
                                      0.12);
                              print('send page syncStore status ${syncStore.status.progress()}, ${syncStore.status.title()}, ${syncStore.status is SyncedSyncStatus}');
                              syncStore.status is SyncedSyncStatus
                                  ? () async {
                                print('before _formKey.currentState.validate()');
                                if (_formKey.currentState
                                    .validate()) {
                                  var isSuccessful = false;

                                  await Navigator.of(context).pushNamed(
                                      Routes.auth, arguments: (bool
                                  isAuthenticatedSuccessfully,
                                      AuthPageState auth) async {
                                    if (!isAuthenticatedSuccessfully) {
                                      isSuccessful = false;
                                      return;
                                    }

                                    await sendStore.createTransaction(
                                        address:
                                        _addressController.text);

                                    Navigator.of(auth.context).pop();
                                    isSuccessful = true;
                                  });
                                  print('send page --> success');
                                  return isSuccessful;
                                } else {
                                  print('send page fail');
                                  return false;
                                }
                              }
                                  : null;
                              print('sdadasda');
                            },
                            child: Container(
                                height: spanshot.hasData
                                    ? spanshot.data
                                    : MediaQuery.of(context).size.height *
                                    0.12,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipOval(
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.green.shade600,
                                                Colors.green,
                                                Colors.blue
                                              ],
                                              transform: GradientRotation(
                                                  math.pi / 4)),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .backgroundColor, //kHintColor, so this should be changed?
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(100),
                                        ),
                                        child: ClipOval(
                                          clipBehavior: Clip.antiAlias,
                                          child: Container(
                                            width: 75,
// this width forces the container to be a circle
                                            height: 75,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .backgroundColor),
                                              borderRadius:
                                              BorderRadius.circular(
                                                  100),
                                            ),
// this height forces the container to be a circle
                                            child: SvgPicture.asset(
                                              'assets/images/up_arrow_svg.svg',
                                              color: Colors.white,
                                              width: 25,
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                   SizedBox(
                        height: 5,
                      ),
                      Text(S.current.send_title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors
                                .grey, //Theme.of(context).accentTextTheme.overline.backgroundColor,
                          )),
                ],
              ),
            ),*/
          ],
        ),
      ),

      bottomSection: Observer(builder: (_) {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 40),
          child: InkWell(
            onTap: syncStore.status is SyncedSyncStatus
                ? () async {
                    final currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    // await Future.delayed(
                    //     const Duration(milliseconds: 100), () {});
                    if (_formKey.currentState.validate()) {
                      if (!addressValidation && !amountValidation) {
                        var isSuccessful = false;

                        await Navigator.of(context).pushNamed(Routes.auth,
                            arguments: (bool isAuthenticatedSuccessfully,
                                AuthPageState auth) async {
                          print(
                              'inside authendication $isAuthenticatedSuccessfully');
                          if (!isAuthenticatedSuccessfully) {
                            isSuccessful = false;
                            return;
                          }
                          Navigator.of(auth.context).pop();
                          loadingProvider.showLoader();
                          //_loading(true);
                          print('create transaction ---> going to');
                          await sendStore.createTransaction(
                              address: _addressController.text);
                          //print('create transaction data -----> $data');
                          print('create transaction ---> reached');
                      // await Future.delayed(
                           // const Duration(milliseconds: 400), () {
                             loadingProvider.hideLoader();
                          //  });
                          
                         // _loading(false);
                          isSuccessful = true;
                        });
                        return isSuccessful;
                      }
                    } else {
                      loadingProvider.hideLoader();
                      return false;
                    }
                  }
                : null,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0xff0BA70F),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/images/new-images/send.svg',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Send',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),

      // bottomSection: Observer(builder: (_) {
      //   return NewSlideToAct(
      //     text: S.of(context).send_title,
      //     outerColor: Theme.of(context).primaryTextTheme.subtitle2.color,
      //     innerColor: BeldexPalette.teal,
      //     onFutureSubmit: syncStore.status is SyncedSyncStatus
      //         ? () async {
      //       final currentFocus = FocusScope.of(context);

      //       if (!currentFocus.hasPrimaryFocus) {
      //         currentFocus.unfocus();
      //       }
      //       await Future.delayed(const Duration(milliseconds: 100), (){});
      //       if (_formKey.currentState.validate()) {

      //         if(!addressValidation && !amountValidation) {
      //           var isSuccessful = false;

      //           await Navigator.of(context).pushNamed(Routes.auth,
      //               arguments: (bool isAuthenticatedSuccessfully,
      //                   AuthPageState auth) async {
      //                 if (!isAuthenticatedSuccessfully) {
      //                   isSuccessful = false;
      //                   return;
      //                 }

      //                 await sendStore.createTransaction(
      //                     address: _addressController.text);

      //                 Navigator.of(auth.context).pop();
      //                 isSuccessful = true;
      //               });
      //           return isSuccessful;
      //         }
      //       } else {
      //         return false;
      //       }
      //     }
      //         : null,
      //   );
      // })
      /* bottomSection: Observer(builder: (_) {
          return SlideToAct(
            text: S.of(context).send_title,
            outerColor: Theme.of(context).primaryTextTheme.subtitle2.color,
            innerColor: BeldexPalette.teal,
            onFutureSubmit: syncStore.status is SyncedSyncStatus
                ? () async {
                    if (_formKey.currentState.validate()) {
                      var isSuccessful = false;

                      await Navigator.of(context).pushNamed(Routes.auth,
                          arguments: (bool isAuthenticatedSuccessfully,
                              AuthPageState auth) async {
                        if (!isAuthenticatedSuccessfully) {
                          isSuccessful = false;
                          return;
                        }

                        await sendStore.createTransaction(
                            address: _addressController.text);

                        Navigator.of(auth.context).pop();
                        isSuccessful = true;
                      });
                      return isSuccessful;
                    } else {
                      return false;
                    }
                  }
                : null,
          );
        })*/
    );
  }

  void _setEffects(BuildContext context) {
    if (_effectsInstalled) return;

    final sendStore = Provider.of<SendStore>(context);
    rdisposer1 = reaction((_) => sendStore.fiatAmount, (String amount) {
      print('amount inside reaction $amount');
      if (amount != _fiatAmountController.text) {
        _fiatAmountController.text = amount;
      }
    });
    reactionDisposers.add(rdisposer1);

    rdisposer2 = reaction((_) => sendStore.cryptoAmount, (String amount) {
      if (amount != _cryptoAmountController.text) {
        _cryptoAmountController.text = amount;
      }
    });
    reactionDisposers.add(rdisposer2);
    _fiatAmountController.addListener(() {
      final fiatAmount = _fiatAmountController.text;
      print('fiat amount ----> $fiatAmount');
      if (sendStore.fiatAmount != fiatAmount) {
        sendStore.changeFiatAmount(fiatAmount);
      }
    });

    _cryptoAmountController.addListener(() {
      final cryptoAmount = _cryptoAmountController.text;
      print('crypto amount ----> $cryptoAmount');
      if (sendStore.cryptoAmount != cryptoAmount) {
        sendStore.changeCryptoAmount(cryptoAmount);
        // final fiatAmount= cryptoAmount;
        // sendStore.changeFiatAmount(fiatAmount);
      }
    });

    rdisposer3 = reaction((_) => sendStore.state, (SendingState state) {
      //  final wDisposer1 = when( (_) => state is SendingFailed, (){
      //      WidgetsBinding.instance.addPostFrameCallback((_) {
      //         showSimpleBeldexDialog(context, 'Alert', ( state as SendingFailed).error,
      //             onPressed: (_) => Navigator.of(context).pop());
      //       });
      //   });
      //   whenDisposers.add(wDisposer1);
      //  final wDisposer2 = when( (_)=> state is TransactionCreatedSuccessfully && sendStore.pendingTransaction != null,(){
      //        WidgetsBinding.instance.addPostFrameCallback((_) {
      //         print('inside the transaction created successfully---->');
      //       showSimpleConfirmDialog(context,
      //        S.of(context).confirm_sending,
      //         sendStore.pendingTransaction.amount,
      //         sendStore.pendingTransaction.fee,
      //         _addressController.text,
      //         onPressed: (_) {
      //           Navigator.of(context).pop();
      //           sendStore.commitTransaction();
      //         },
      //         onDismiss: (_){
      //           _addressController.text = '';
      //           _cryptoAmountController.text = '';
      //           Navigator.of(context).pop();
      //         }
      //         );
      //       });
      //   } );
      //  whenDisposers.add(wDisposer2);
      //  final wDisposer3 = when( (_)=> state is TransactionCommitted ,(){
      //       WidgetsBinding.instance.addPostFrameCallback((_) {
      //          print('inside the transaction commiteed ---->');
      //         showSimpleSentTrans( context, S.of(context).sending, sendStore.pendingTransaction.amount,'fee',_addressController.text,
      //             onPressed: (_) {
      //           _addressController.text = '';
      //           _cryptoAmountController.text = '';
      //           Navigator.of(context)..pop()..pop();
      //         },
      //          onDismiss: (_){
      //           Navigator.of(context)..pop()..pop();
      //         }
      //         );
      //       });
      //   });

      //  whenDisposers.add(wDisposer3);

      if (state is SendingFailed) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showSimpleBeldexDialog(context, 'Alert', state.error,
              onPressed: (_) => Navigator.of(context).pop());
        });
      }

      if (state is TransactionCreatedSuccessfully &&
          sendStore.pendingTransaction != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          print('inside the transaction created successfully---->');
          await showSimpleConfirmDialog(
              context,
              S.of(context).confirm_sending,
              sendStore.pendingTransaction.amount,
              sendStore.pendingTransaction.fee,
              _addressController.text, onPressed: (_) async {
            Navigator.of(context).pop();
            await sendStore.commitTransaction();
          }, onDismiss: (_) {
            _addressController.text = '';
            _cryptoAmountController.text = '';
            Navigator.of(context).pop();
          });
        });
      }

      if (state is TransactionCommitted) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          print('inside the transaction commiteed ---->');
          await showSimpleSentTrans(
              context,
              S.of(context).sending,
              sendStore.pendingTransaction.amount,
              'fee',
              _addressController.text, onPressed: (_) {
            _addressController.text = '';
            _cryptoAmountController.text = '';
            Navigator.of(context)..pop()..pop()..pop();
          }, onDismiss: (_) {
            Navigator.of(context)..pop()..pop()..pop();
          });
        });
      }
    });

    _effectsInstalled = true;
  }
}

// class ConfirmSending extends StatelessWidget {
//   const ConfirmSending({ Key key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//    return  GestureDetector(
//      // onTap: () => _onDismiss(context),
//       child: Container(
//         color: Colors.transparent,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
//           child: Container(
//             margin: EdgeInsets.all(15),
//            // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                         color: Colors.white, //Theme.of(context).backgroundColor,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height*1.4/3,
//                       padding: EdgeInsets.only(top: 15.0,left:20,right: 20),
//                       child: Column(
//                         children: [
//                              Padding(
//                                padding: const EdgeInsets.only(bottom:10.0),
//                                child: Text(S.of(context).confirm_sending,style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
//                              ),
//                              Container(
//                               height:50,
//                               //padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color:Color(0xffEDEDED)
//                               ),
//                               child:Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Text('Amount',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700),),
//                                   ),
//                                   VerticalDivider(

//                                   ),
//                                   Expanded(child: Container(
//                                      padding: const EdgeInsets.all(10.0),
//                                     child: Text('${sendStore.pendingTransaction.amount}',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: 'Poppinsbold'),),
//                                   )),
//                                   Container(
//                                     width:70,
//                                     padding: EdgeInsets.all(10),
//                                     child: Container(
//                                       height:40,width:40,
//                                       padding: EdgeInsets.all(6),
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff00B116),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child:SvgPicture.asset('assets/images/new-images/beldex.svg')
//                                     ),
//                                   )
//                                 ],
//                               )
//                              ),
//                              Container(
//                               margin:EdgeInsets.only(top:10),
//                               padding: EdgeInsets.all(10),
//                               height:MediaQuery.of(context).size.height*0.60/3,
//                               decoration: BoxDecoration(
//                                 color: Color(0xffEDEDED),
//                                 borderRadius: BorderRadius.circular(10)
//                               ),
//                               child:Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text('Address'),
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color:Colors.white,
//                                       borderRadius: BorderRadius.circular(10)
//                                     ),
//                                     child: Text('hacjsjbyafckjdblknbksjsjhvsjkbskbskbdlsdknscmbxjcbjkblklsknslklsjbjs')),
//                                     Text('Fee:000087'),

//                                 ],
//                               )
//                              ),
//                              Container(
//                               margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
//                                child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height:45,width:120,
//                                     decoration: BoxDecoration(
//                                       color:Color(0xffEDEDED),
//                                       borderRadius: BorderRadius.circular(8)
//                                     ),
//                                     child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800))),
//                                   ),
//                                   SizedBox(width:20 ),
//                                   Container(
//                                     height:45,width:120,
//                                     decoration: BoxDecoration(
//                                       color:Color(0xff0BA70F),
//                                       borderRadius: BorderRadius.circular(8)
//                                     ),
//                                     child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),)),
//                                   )
//                                ],),
//                              )
//                         ],
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

