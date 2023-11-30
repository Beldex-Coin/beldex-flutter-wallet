import 'dart:async';

import 'package:beldex_wallet/src/wallet/beldex/calculate_estimated_fee.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/widgets/new_slide_to_act.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/send/sending_state.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_text_field.dart';
import 'package:beldex_wallet/src/widgets/scrollable_with_bottom_section.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;

class NewStakePage extends BasePage {
  @override
  String get title => S.current.title_new_stake;

  @override
  bool get isModalBackButton => false;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  Widget body(BuildContext context) => NewStakeForm();
}

class NewStakeForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewStakeFormState();
}

class NewStakeFormState extends State<NewStakeForm>
    with TickerProviderStateMixin {
  final _addressController = TextEditingController();
  final _cryptoAmountController = TextEditingController();

  final _focusNode = FocusNode();

  bool _effectsInstalled = false;

  final _formKey = GlobalKey<FormState>();

  var controller = StreamController<double>.broadcast();
  double position;

  //
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
        contentPadding: EdgeInsets.all(0),
        content: Column(
          children: [
            Card(
              elevation: 2,
              color: Theme.of(context).cardColor,
              //Color.fromARGB(255, 40, 42, 51),
              margin: EdgeInsets.only(
                  left: constants.leftPx, right: constants.rightPx, top: 30),
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
                            Text(walletStore.name,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6
                                        .color)),
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
                              : balanceStore.unlockedBalanceString;

                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                    })
                  ],
                ),
              ),
            ),
            /* Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Palette.shadowGrey,
                      blurRadius: 10,
                      offset: Offset(0, 12),
                    )
                  ],
                  border: Border(
                      top: BorderSide(
                          width: 1,
                          color: Theme.of(context)
                              .accentTextTheme
                              .subtitle2
                              .backgroundColor))),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(S.of(context).send_your_wallet,
                                style: TextStyle(
                                    fontSize: 12, color: BeldexPalette.teal)),
                            Text(walletStore.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .overline
                                        .color,
                                    height: 1.25)),
                          ]);
                    }),
                    Observer(builder: (context) {
                      final savedDisplayMode = settingsStore.balanceDisplayMode;
                      final availableBalance =
                          savedDisplayMode == BalanceDisplayMode.hiddenBalance
                              ? '---'
                              : balanceStore.unlockedBalanceString;

                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(S.current.beldex_available_balance,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .overline
                                      .backgroundColor,
                                )),
                            Text(availableBalance,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .overline
                                        .color,
                                    height: 1.1)),
                          ]);
                    })
                  ],
                ),
              ),
            ),*/
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    left: constants.leftPx,
                    right: constants.rightPx,
                    top: 25,
                    bottom: 30),
                child: Column(children: <Widget>[
                  BeldexTextField(
                    controller: _addressController,
                    hintText: S.of(context).service_node_key,
                    focusNode: _focusNode,
                    validator: (value) {
                      final pattern = RegExp('[0-9a-fA-F]{64}');
                      if (!pattern.hasMatch(value)) {
                        return S.of(context).error_text_service_node;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Card(
                      elevation: 2,
                      color: Theme.of(context)
                          .cardColor, //Color.fromARGB(255, 40, 42, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextFormField(
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .caption
                                    .color),
                            controller: _cryptoAmountController,
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  RegExp('[\\-|\\ |\\,]'))
                            ],
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey.withOpacity(0.6)),
                                hintText: '00.000000000 BDX',
                                errorStyle:
                                    TextStyle(color: BeldexPalette.red)),
                            validator: (value) {
                              sendStore.validateBELDEX(
                                  value, balanceStore.unlockedBalance);
                              return sendStore.errorMessage;
                            }),
                      ),
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
                        Text(
                            '${calculateEstimatedFee(priority: BeldexTransactionPriority.flash)}',
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
                ]),
              ),
            ),
          ],
        ),
        bottomSection: Observer(builder: (_) {
          return NewSlideToAct(
            text: S.of(context).stake_beldex,
            outerColor: Theme.of(context).primaryTextTheme.subtitle2.color,
            innerColor: BeldexPalette.teal,
            onFutureSubmit: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
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

                        await sendStore.createStake(
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
        }) /*Column(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Container(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0 * animationController.value),
                    child: child,
                  ),
                );
              },
              child: Observer(
                builder: (_) { return StreamBuilder<double>(
                  stream: controller.stream,
                  builder: (context, spanshot) => GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      position =
                          MediaQuery.of(context).size.height - details.globalPosition.dy;
                      if (!position.isNegative && position < 240) {
                        controller.add(position);
                      }
                    },
                    onVerticalDragEnd: (details) {
                      controller.add(MediaQuery.of(context).size.height * 0.12);
                      syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
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

                                  await sendStore.createStake(
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
                      print('sdadasda');

                    },
                    child: Container(
                        height: spanshot.hasData
                            ? spanshot.data
                            : MediaQuery.of(context).size.height * 0.12,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  borderRadius: BorderRadius.circular(100),
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
                          ],
                        )
                    ),
                  ),
                ); },
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
        ),*/ /*Observer(builder: (_) {
          return SlideToAct(
            text: S.of(context).stake_beldex,
            outerColor: Theme.of(context).primaryTextTheme.subtitle2.color,
            innerColor: BeldexPalette.teal,
            onFutureSubmit: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
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

                        await sendStore.createStake(
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
    if (_effectsInstalled) {
      return;
    }

    final sendStore = Provider.of<SendStore>(context);

    reaction((_) => sendStore.cryptoAmount, (String amount) {
      if (amount != _cryptoAmountController.text) {
        _cryptoAmountController.text = amount;
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
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(S.of(context).error),
                  content: Text(state.error),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(S.of(context).ok),
                    )
                  ],
                );
              });
        });
      }

      if (state is TransactionCreatedSuccessfully) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(S.of(context).confirm_sending),
                  content: Text(S.of(context).commit_transaction_amount_fee(
                      sendStore.pendingTransaction.amount,
                      sendStore.pendingTransaction.fee)),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        sendStore.commitTransaction();
                      },
                      child: Text(S.of(context).ok),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(S.of(context).cancel),
                    )
                  ],
                );
              });
        });
      }

      if (state is TransactionCommitted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(S.of(context).sending),
                  content: Text(S.of(context).transaction_sent),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        _addressController.text = '';
                        _cryptoAmountController.text = '';
                        Navigator.of(context)..pop()..pop();
                      },
                      child: Text(S.of(context).ok),
                    )
                  ],
                );
              });
        });
      }
    });

    _effectsInstalled = true;
  }
}
