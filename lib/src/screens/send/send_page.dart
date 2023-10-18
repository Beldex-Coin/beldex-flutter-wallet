import 'dart:async';
import 'dart:ui';

import 'package:beldex_wallet/src/domain/common/contact.dart';
import 'package:beldex_wallet/src/screens/send/confirm_sending.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
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
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';

bool canLoad = false;

class SendPage extends BasePage {
  SendPage({this.flashMap});

  final Map<String, dynamic> flashMap;

  @override
  String get title => S.current.send;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Color get textColor => Colors.white;

  @override
  bool get isModalBackButton => false;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget body(BuildContext context) {
    return SendForm(
      flashMap: flashMap,
    );
  }
}

class SendForm extends StatefulWidget {
  SendForm({Key key, this.flashMap}) : super(key: key);
  final Map<String, dynamic> flashMap;

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
  bool addressValidation = false;
  var addressErrorMessage = '';
  bool amountValidation = false;
  var amountErrorMessage = '';
  final List<ReactionDisposer> reactionDisposers =
      []; // dispose the reactions we used in this file to avoid the memory leaks
  final List<ReactionDisposer> whenDisposers =
      []; //dispose the when functions we used in this file to avoid the memory leaks
  ReactionDisposer rdisposer1, rdisposer2, rdisposer3;
  bool isFlashTransaction = false;

  @override
  void initState() {
    _focusNodeAddress.addListener(() {
      if (!_focusNodeAddress.hasFocus && _addressController.text.isNotEmpty) {
        getOpenAliasRecord(context);
      }
    });
    getFlashData();
    super.initState();
  }

  // fetch flash transaction data from
  void getFlashData() {
    setState(() {
      if (widget.flashMap != null) {
        isFlashTransaction = widget.flashMap['flash'] as bool;
        _addressController.text = (widget.flashMap['address'] as String) ?? '';
        if (widget.flashMap['amount'] != null) {
          _cryptoAmountController.text = (widget.flashMap['amount'] as String);
        }
      }
    });
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

  void _startCreatingTransaction(
      SendStore sendStore, String address, bool isFlashTransaction) {
    print('address -----> $address');
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => CommonLoader(
                address: address,
                sendStore: sendStore,
                isFlashTransaction: isFlashTransaction)));
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
      content: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                      children: <Widget>[
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
                            Flexible(
                            flex:1,
                              child:Text(S.of(context).availableBdx,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .caption
                                      .color,
                                  fontSize: 16,
                                  //fontWeight: FontWeight.w600,
                                )),
                            ),
                            Flexible(
                              flex:1,
                              child: Text(availableBalance,
                                  style: TextStyle(
                                    color: Color(0xff0BA70F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
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
                    onTap: () async {
                      final contact =
                          await Navigator.of(context, rootNavigator: true)
                              .pushNamed(Routes.pickerAddressBook);
                      if (contact is Contact && contact.address != null) {
                        _addressController.text = contact.address;
                      }
                    },
                    child: SvgPicture.asset(
                        'assets/images/new-images/address_book.svg',
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
                      if (uri.queryParameters.isNotEmpty) {
                        amount = uri.queryParameters[
                            uri.queryParameters.keys.first];
                      }
                    }
                    _addressController.text = address;
                    _cryptoAmountController.text = amount;
                  },
                  options: [
                    AddressTextFieldOption.saveAddress,
                    AddressTextFieldOption.qrCode,
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        addressValidation = true;
                        addressErrorMessage =
                            S.of(context).pleaseEnterABdxAddress;
                      });
                      return null;
                    } else {
                      final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

                      if (!alphanumericRegex.hasMatch(value)) {
                        setState(() {
                          addressErrorMessage =
                              S.of(context).enterAValidAddress;
                        });
                        return;
                      } else {
                        if (getAddressBasicValidation(value)) {
                          sendStore.validateAddress(value,
                              cryptoCurrency: CryptoCurrency.bdx);
                          if (sendStore.errorMessage != null) {
                            setState(() {
                              addressValidation = true;
                              addressErrorMessage =
                                  S.of(context).error_text_address;
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
                          addressErrorMessage =
                              S.of(context).enterAValidAddress;
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
                      Text(S.of(context).enterBdxToSend,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),

                Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 5,
                      right: 4,
                    ),
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 5,
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
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.withOpacity(0.6)),
                                hintText: S.of(context).enterAmount,
                                errorStyle:
                                    TextStyle(color: BeldexPalette.red)),
                              onSaved: (value){
                                print('value from the textfield ---->$value');
                              },
                            validator: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  amountValidation = true;
                                  amountErrorMessage =
                                      S.of(context).pleaseEnterAAmount;
                                });
                                return null;
                              } else {
                                if (getAmountValidation(value)) {
                                  if (!sendStore.compareAvailableBalance(
                                      value,
                                      balanceStore.unlockedBalance)) {
                                    setState(() {
                                      amountValidation = true;
                                      amountErrorMessage = S.of(context).youDontHaveEnoughUnlockedBalance;
                                    });
                                    return;
                                  } else {
                                    setState(() {
                                      amountValidation = false;
                                      amountErrorMessage = '';
                                    });
                                  }
                                  return null;
                                } else {
                                  setState(() {
                                    amountValidation = true;
                                    amountErrorMessage =
                                        S.current.pleaseEnterAValidAmount;
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
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 25, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text('${S.of(context).send_estimated_fee}   ',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors
                                .grey,
                          )),
                      Text(
                          '${isFlashTransaction == true ? calculateEstimatedFee(priority: BeldexTransactionPriority.flash) : calculateEstimatedFee(priority: settingsStore.transactionPriority)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                      '${isFlashTransaction == true ? S.of(context).flashTransactionPriority(
                          settingsStore.transactionPriority.toString()) : S.of(context).send_priority(
                          settingsStore.transactionPriority.toString())}',
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
        ],
      ),

      bottomSection: Observer(builder: (_) {
        return Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 30),
          child: InkWell(
            onTap: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
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
                              'inside authentication $isAuthenticatedSuccessfully');
                          if (!isAuthenticatedSuccessfully) {
                            isSuccessful = false;
                            return;
                          }
                          Navigator.of(auth.context).pop();
                          _startCreatingTransaction(sendStore,
                              _addressController.text, isFlashTransaction);
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
                      S.of(context).send,
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
          Navigator.of(context).pop();
          await showSimpleBeldexDialog(
              context, S.of(context).alert, state.error,
              onPressed: (_) => Navigator.of(context).pop());
        });
      }

      if (state is TransactionCreatedSuccessfully &&
          sendStore.pendingTransaction != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          print('inside the transaction created successfully---->');
          Navigator.of(context).pop();
          await showSimpleConfirmDialog(
              context,
              S.of(context).confirm_sending,
              sendStore.pendingTransaction.amount,
              sendStore.pendingTransaction.fee,
              _addressController.text, onPressed: (_) {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (context) =>
                        CommitTransactionLoader(sendStore: sendStore)));
          }, onDismiss: (_) {
            _addressController.text = '';
            _cryptoAmountController.text = '';
            Navigator.of(context).pop();
          });
        });
      }

      if (state is TransactionCommitted) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          print('inside the transaction committed ---->');
          Navigator.of(context).pop();
          await showDialogTransactionSuccessfully(context, onPressed: (_) {
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

class CommitTransactionLoader extends StatelessWidget {
  CommitTransactionLoader({Key key, this.sendStore}) : super(key: key);

  final SendStore sendStore;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.of(context).size.height;
    Future.delayed(const Duration(seconds: 1), () async {
      await sendStore.commitTransaction();
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
          child: Scaffold(
        body: Container(
            color: settingsStore.isDarkTheme
                ? Color(0xff171720)
                : Color(0xffffffff),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               /* Container(
                    height: height * 0.35 / 3,
                    width: height * 0.35 / 3,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff272733)
                            : Color(0xffEDEDED),
                        shape: BoxShape.circle),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xff0BA70F),
                      ),
                      strokeWidth: 6,
                    )),*/
                Text(
                  S.of(context).initiatingTransactionTitle,
                  style: TextStyle(
                      fontSize: height * 0.07 / 3,fontWeight: FontWeight.w800,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    S.of(context).initiatingTransactionDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: height * 0.07 / 3,fontWeight: FontWeight.w700,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222)),
                  ),
                )
              ],
            )),
      )),
    );
  }
}
