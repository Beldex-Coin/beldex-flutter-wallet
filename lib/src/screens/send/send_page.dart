import 'dart:async';
import 'dart:convert';

import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/widgets/new_slide_to_act.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

class SendPage extends BasePage {
  @override
  String get title => S.current.wallet_list_title;

  @override
  Widget leading(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 12.0, left: 10),
        child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  }

  @override
  Color get textColor => Colors.white;

  @override
  bool get isModalBackButton => false;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget body(BuildContext context) => SendForm();
}

class SendForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SendFormState();
}

class SendFormState extends State<SendForm> with TickerProviderStateMixin {
  final _addressController = TextEditingController();
  final _cryptoAmountController = TextEditingController();
  final _fiatAmountController = TextEditingController();

  final _focusNodeAddress = FocusNode();

  bool _effectsInstalled = false;

  final _formKey = GlobalKey<FormState>();

  //
  var controller = StreamController<double>.broadcast();
  double position;
  AnimationController animationController;

  bool addressValidation = false;
  var addressErrorMessage ="";
  bool amountValidation = false;
  var amountErrorMessage ="";

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

    super.initState();
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }

  Future<void> getOpenAliasRecord(BuildContext context) async {
    final sendStore = Provider.of<SendStore>(context,listen: false);
    final isOpenAlias =
        await sendStore.isOpenaliasRecord(_addressController.text);

    if (isOpenAlias) {
      _addressController.text = sendStore.recordAddress;

      await showSimpleBeldexDialog(context, S.of(context).openalias_alert_title,
          S.of(context).openalias_alert_content(sendStore.recordName),
          onPressed: (_) => Navigator.of(context).pop());
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

    _setEffects(context);

    return ScrollableWithBottomSection(
      bottomSectionPadding: EdgeInsets.only(bottom:230),
      content: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 10,),
                Text(
                  S.current.send_title,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
                Card(
                  elevation: 2,
                  color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                  margin: EdgeInsets.only(left: constants.leftPx, right: constants.rightPx, top: 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Observer(builder: (_) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /* Text(S.of(context).send_your_wallet,
                                      style: TextStyle(
                                          fontSize: 12, color: BeldexPalette.teal)),*/
                                Text(
                                  walletStore.name,
                                  style: TextStyle(
                                      fontSize: 25,
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
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .accentTextTheme
                                          .caption
                                          .decorationColor //Theme.of(context).primaryTextTheme.headline6.color
                                      ),
                                ),
                              ]);
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Observer(builder: (context) {
                          final savedDisplayMode = settingsStore.balanceDisplayMode;
                          final availableBalance =
                              savedDisplayMode == BalanceDisplayMode.hiddenBalance
                                  ? '---'
                                  : savedDisplayMode==BalanceDisplayMode.fullBalance?balanceStore.fullBalanceString:balanceStore.unlockedBalanceString;

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
                                Text(availableBalance,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .caption
                                          .color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ]);
                        }),
                        SizedBox(height: 12,)
                        /*Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 65,
                              height: 30,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 40, 42, 51),
                                    Theme.of(context).backgroundColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[600]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .button
                                        .backgroundColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding:
                        EdgeInsets.only(left: constants.leftPx, right: constants.rightPx, top: 25, bottom: 30),
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
                            if(uri.queryParameters[uri.queryParameters.keys.first]!=null){
                              amount = uri.queryParameters[uri.queryParameters.keys.first];
                            }
                          } else {
                            address = uri.toString();
                          }

                          _addressController.text = address;
                          _cryptoAmountController.text = amount;
                        },
                        options: [
                          AddressTextFieldOption.qrCode,
                          AddressTextFieldOption.addressBook
                        ],
                        validator: (value) {
                         /* if(value.isEmpty){
                            return 'Please fill in this field\n';
                          }else {
                            sendStore.validateAddress(value,
                                cryptoCurrency: CryptoCurrency.bdx);
                            return sendStore.errorMessage;
                          }*/
                          if(value.isEmpty){
                            setState(() {
                            addressValidation =true;
                            addressErrorMessage ='Please enter a bdx address';
                            });
                            return null;
                          }else {
                            sendStore.validateAddress(value,
                                cryptoCurrency: CryptoCurrency.bdx);
                            if(sendStore.errorMessage!=null) {
                              setState(() {
                                addressValidation = true;
                                addressErrorMessage = 'Invalid bdx address';
                              });
                            }else{
                              setState(() {
                                addressValidation = false;
                                addressErrorMessage = '';
                              });
                            }
                            return null;
                          }
                        },
                      ),
                      Visibility(
                        visible: addressValidation,
                        child: Container(margin: EdgeInsets.only(left:10),child: Align(alignment:Alignment.centerLeft,child: Text(addressErrorMessage,style: TextStyle(color: Colors.red,),))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Beldex',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            Expanded(
                              flex: 4,
                              child: Card(
                                elevation: 2,
                                color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 18.0, color: Theme.of(context).primaryTextTheme.caption.color),
                                      controller: _cryptoAmountController,
                                      keyboardType: TextInputType.numberWithOptions(
                                          signed: false, decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp('[- ]'))
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
                                              fontSize: 18.0, color:Theme.of(context).hintColor),
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
                                          errorStyle:
                                              TextStyle(color: BeldexPalette.red)),
                                      validator: (value) {
                                        if(value.isEmpty){
                                          setState(() {
                                            amountValidation = true;
                                            amountErrorMessage = 'Please enter a amount';
                                          });
                                          return null;
                                        }else {
                                          sendStore.validateBELDEX(
                                              value,
                                              balanceStore.unlockedBalance);
                                          if(sendStore.errorMessage!=null) {
                                            setState(() {
                                              amountValidation = true;
                                              amountErrorMessage = 'The enter a valid amount';
                                            });
                                          }else{
                                            setState(() {
                                              amountValidation = false;
                                              amountErrorMessage = "";
                                            });
                                          }
                                          return null;
                                        }
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: amountValidation,
                        child: Container(margin: EdgeInsets.only(left:10),child: Align(alignment:Alignment.centerLeft,child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(amountErrorMessage,style: TextStyle(color: Colors.red,),),
                            ),
                          ],
                        ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${settingsStore.fiatCurrency.toString()}',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryTextTheme.caption.color,//Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            Expanded(
                              flex: 4,
                              child: Card(
                                elevation: 2,
                                color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: TextFormField(
                                      style: TextStyle(
                                          fontSize: 18.0, color: Theme.of(context).primaryTextTheme.caption.color),
                                      controller: _fiatAmountController,
                                      keyboardType: TextInputType.numberWithOptions(
                                          signed: false, decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp('[- ]'))
                                      ],
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          /* prefixIcon: SizedBox(
                                              width: 75,
                                              child: Padding(
                                                  padding: EdgeInsets.only(left: 8, top: 12),
                                                  child: Text(
                                                      '${settingsStore.fiatCurrency.toString()}:',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Theme.of(context)
                                                              .accentTextTheme
                                                              .overline
                                                              .color))),
                                            ),*/
                                          hintStyle: TextStyle(
                                              fontSize: 18.0, color: Theme.of(context).hintColor),
                                          hintText: '00.000000000',
                                          /* focusedBorder: OutlineInputBorder(
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
                                              TextStyle(color: BeldexPalette.red))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('${S.of(context).send_estimated_fee}   ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .grey, //Theme.of(context).accentTextTheme.overline.backgroundColor,
                                )),
                            Text('${calculateEstimatedFee(priority: BeldexTransactionPriority.flash)}',
                                //'${calculateEstimatedFee(priority: BeldexTransactionPriority.slow)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .grey, //Theme.of(context).primaryTextTheme.overline.backgroundColor,
                                )),
                            SizedBox(width: 5,),
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
          return NewSlideToAct(
            text: S.of(context).send_title,
            outerColor: Theme.of(context).primaryTextTheme.subtitle2.color,
            innerColor: BeldexPalette.teal,
            onFutureSubmit: syncStore.status is SyncedSyncStatus
                ? () async {
              final currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              await Future.delayed(const Duration(milliseconds: 100), (){});
              if (_formKey.currentState.validate()) {

                if(!addressValidation && !amountValidation) {
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
                }
              } else {
                return false;
              }
            }
                : null,
          );
        })
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

    reaction((_) => sendStore.fiatAmount, (String amount) {
      if (amount != _fiatAmountController.text) {
        _fiatAmountController.text = amount;
      }
    });

    reaction((_) => sendStore.cryptoAmount, (String amount) {
      if (amount != _cryptoAmountController.text) {
        _cryptoAmountController.text = amount;
      }
    });

    _fiatAmountController.addListener(() {
      final fiatAmount = _fiatAmountController.text;

      if (sendStore.fiatAmount != fiatAmount) {
        sendStore.changeFiatAmount(fiatAmount);
      }
    });

    _cryptoAmountController.addListener(() {
      final cryptoAmount = _cryptoAmountController.text;

      if (sendStore.cryptoAmount != cryptoAmount) {
        sendStore.changeCryptoAmount(cryptoAmount);
      }
    });

    reaction((_) => sendStore.state, (SendingState state) {
      if (state is SendingFailed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSimpleBeldexDialog(context, 'Alert', state.error,
              onPressed: (_) => Navigator.of(context).pop());
        });
      }

      if (state is TransactionCreatedSuccessfully) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSimpleBeldexDialog(
              context,
              S.of(context).confirm_sending,
              S.of(context).commit_transaction_amount_fee(
                  sendStore.pendingTransaction.amount,
                  sendStore.pendingTransaction.fee), onPressed: (_) {
            Navigator.of(context).pop();
            sendStore.commitTransaction();
          });
        });
      }

      if (state is TransactionCommitted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSimpleBeldexDialog(
              context, S.of(context).sending, S.of(context).transaction_sent,
              onPressed: (_) {
            _addressController.text = '';
            _cryptoAmountController.text = '';
            Navigator.of(context)..pop()..pop();
          });
        });
      }
    });

    _effectsInstalled = true;
  }
}
