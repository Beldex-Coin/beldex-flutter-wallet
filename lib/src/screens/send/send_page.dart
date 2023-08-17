import 'dart:async';
import 'dart:ui';

import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/screens/send/confirm_sending.dart';
import 'package:beldex_wallet/src/widgets/common_loader.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:provider/provider.dart';

bool canLoad = false;

class SendPage extends BasePage {
  String controller;

  @override
  String get title => S.current.send;

  @override
  Widget trailing(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container();
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
  final _formKey = GlobalKey<FormState>();
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



void _startCreatingTransaction(SendStore sendStore,String address){

  print('address -----> $address');
  Navigator.push(context, MaterialPageRoute<void>(builder: (context)=> CommonLoader(address: address,sendStore: sendStore)));

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
                      const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).send_beldex_address,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w700)),
                      GestureDetector(
                          onTap: () async{
                            final contact = await Navigator.of(context, rootNavigator: true).pushNamed(Routes.pickerAddressBook);
                              if (contact is Contact && contact.address != null) {
                                _addressController.text = contact.address;
                              }
                          },
                          child: SvgPicture.asset(
                              'assets/images/new-images/Address.svg',
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffffffff)
                                  : Color(0xff16161D)))
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(
                        //left: constants.leftPx, right: constants.rightPx,
                        top: 10,
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
                        onChanged: (val) => _formKey.currentState.validate(),
                        validator: (value) {
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
                          left: 7,
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Enter BDX to send',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),

                      Container(
                          height: MediaQuery.of(context).size.height *
                              0.60 /
                              3, //150,
                          margin: EdgeInsets.only(
                            top: 15,
                            left: 5,
                            right: 4,
                          ),
                          padding: EdgeInsets.only(
                            left: 25,
                            right:5,
                            top: 10,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor),
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
                                      hintStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey.withOpacity(0.6)),
                                      hintText: 'Enter Amount',
                                      errorStyle:
                                          TextStyle(color: BeldexPalette.red)),
                                  onChanged: (val)=> _formKey.currentState.validate(),
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

                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 25,left: 10),
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
                    ]),
                  ),
                ),
                /*SizedBox(height: 110,)*/
              ],
            ),
          ],
        ),
      ),

      bottomSection: Observer(builder: (_) {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 30),
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
                           _startCreatingTransaction(sendStore, _addressController.text);
                          isSuccessful = true;
                        });
                        return isSuccessful;
                      }
                    } else {
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
            Navigator.of(context)..pop()..pop();
          }, onDismiss: (_) {
            Navigator.of(context)..pop()..pop();
          });
        });
      }
    });

    _effectsInstalled = true;
  }
}
