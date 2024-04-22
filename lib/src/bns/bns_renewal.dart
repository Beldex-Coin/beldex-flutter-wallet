import 'dart:ui';

import 'package:beldex_wallet/src/bns/bns_renewal_change_notifier.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/send/confirm_sending.dart';
import 'package:beldex_wallet/src/stores/send/sending_state.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/bns/bns_renewal_initiating_transaction_loader.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../routes.dart';
import 'bns_commit_transaction_loader.dart';
import 'bns_price_item.dart';

class BnsRenewalPage extends BasePage {
  BnsRenewalPage({this.bnsName});

  final String bnsName;

  @override
  String get title => S.current.bnsRenewal;

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
    return BnsRenewalPageForm(bnsName: bnsName,);
  }
}

class BnsRenewalPageForm extends StatefulWidget {
  BnsRenewalPageForm({this.bnsName});

  final String bnsName;

  @override
  State<StatefulWidget> createState() => BnsRenewalPageFormState();
}

class BnsRenewalPageFormState extends State<BnsRenewalPageForm> with TickerProviderStateMixin {
  List<BnsPriceItem> bnsPriceDetailsList = [
    BnsPriceItem('1y', '1 Yr', '1 Year', '650 BDX', ''),
    BnsPriceItem('2y', '2 Yrs', '2 Years', '1000 BDX', '23.08%'),
    BnsPriceItem('5y', '5 Yrs', '5 Years', '2000 BDX', '38.46%'),
    BnsPriceItem('10y', '10 Yrs', '10 Years', '4000 BDX', '38.46%')
  ];

  final _bnsNameController = TextEditingController();
  bool _effectsInstalled = false;
  ReactionDisposer rDisposer;

  @override
  void initState() {
    if(widget.bnsName!=null){
      final bnsName = widget.bnsName;
      _bnsNameController.text = bnsName.substring(0, bnsName.indexOf('.'));
    }
    super.initState();
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
    return Scaffold(
      backgroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(
          0xffffffff),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(
            0xffffffff),
        child: Consumer<BnsRenewalChangeNotifier>(
            builder: (context, bnsRenewalChangeNotifier, child) {
              return bnsRenewal(settingsStore, bnsPriceDetailsList, sendStore,
                  syncStore, bnsRenewalChangeNotifier, walletStore);
            }),
      ),
    );
  }

  Widget bnsRenewal(
      SettingsStore settingsStore,
      List<BnsPriceItem> bnsPriceDetailsList,
      SendStore sendStore,
      SyncStore syncStore,
      BnsRenewalChangeNotifier bnsRenewalChangeNotifier, WalletStore walletStore) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: settingsStore.isDarkTheme
              ? Color(0xff24242f)
              : Color(0xffF3F3F3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //BNS Price
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff32324a)
                        : Color(0xffDEDEDE)),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          text: S.of(context).bns,
                          style: TextStyle(
                              color: Color(0xff0ba70f),
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'OpenSans'),
                          children: [
                            TextSpan(
                                text: ' Price',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff000000)))
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bnsPriceDetailsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final selectedIndex =
                                bnsRenewalChangeNotifier.selectedBnsPriceIndex;
                            return bnsPriceItem(
                                bnsPriceDetailsList[index],
                                index,
                                selectedIndex,
                                settingsStore,
                                bnsRenewalChangeNotifier);
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff3c3c51)
                              : Color(0xffFFFFFF)),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text:
                                '${bnsPriceDetailsList[bnsRenewalChangeNotifier.selectedBnsPriceIndex].detailYears} : ',
                                style: TextStyle(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff000000),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'OpenSans'),
                                children: [
                                  TextSpan(
                                      text: bnsPriceDetailsList[
                                      bnsRenewalChangeNotifier
                                          .selectedBnsPriceIndex]
                                          .amountOfBdx,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff0ba70f)))
                                ]),
                          ),
                          bnsPriceDetailsList[
                          bnsRenewalChangeNotifier.selectedBnsPriceIndex]
                              .youSave
                              .isNotEmpty
                              ? RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                                text: 'You Save ',
                                style: TextStyle(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff000000),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'OpenSans'),
                                children: [
                                  TextSpan(
                                      text: bnsPriceDetailsList[
                                      bnsRenewalChangeNotifier
                                          .selectedBnsPriceIndex]
                                          .youSave,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff0ba70f)))
                                ]),
                          )
                              : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //BNS Name
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text('Name',
                    style: TextStyle(
                        fontSize: 13.0,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OpenSans')),
              ),
              //BNS Name Field
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff24242F)
                      : Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: settingsStore.isDarkTheme
                          ? Color(0xff3c3c51)
                          : Color(0xffDADADA)),
                ),
                padding: EdgeInsets.only(left: 8, right: 5),
                child: TextFormField(
                  readOnly: true,
                  controller: _bnsNameController,
                  style: TextStyle(fontSize: 14.0),
                  maxLength: _bnsNameController.text.contains('-') ? 63 : 32,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9-]')),
                    FilteringTextInputFormatter.deny(RegExp('[,. ]'))
                  ],
                  decoration: InputDecoration(
                    suffix: Text(
                      '.bdx',
                      style: TextStyle(
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff000000),
                          fontWeight: FontWeight.w300,
                          fontFamily: 'OpenSans'),
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: settingsStore.isDarkTheme
                            ? Color(0xff77778B)
                            : Color(0xff77778B)),
                    hintText: 'The name to purchase via Beldex Name Service',
                    counterText: '',
                  ),
                  validator: (value) {
                    return null;
                  },
                  onChanged: (value) {
                    return null;
                    //validateBnsName(value, bnsRenewalChangeNotifier);
                  },
                ),
              ),
              //BNS Name Field Error Message
              /*Visibility(
                visible: bnsRenewalChangeNotifier.bnsNameFieldIsValid,
                child: Container(
                  margin: EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(bnsRenewalChangeNotifier.bnsNameFieldErrorMessage,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'OpenSans')),
                ),
              ),*/
            ],
          ),
          Observer(builder: (_) {
            return InkWell(
              onTap: validateAllFields(
                  syncStore, bnsRenewalChangeNotifier, settingsStore)
                  ? () async {
                final currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                bnsRenewalConfirmationDialogBox(
                    sendStore,
                    '${_bnsNameController.text}.bdx',
                    bnsPriceDetailsList[
                    bnsRenewalChangeNotifier.selectedBnsPriceIndex]
                        .id,
                    bnsPriceDetailsList[
                    bnsRenewalChangeNotifier.selectedBnsPriceIndex]
                        .detailYears,
                    walletStore);
              }
                  : null,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                margin:
                EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 30),
                decoration: BoxDecoration(
                    color: Color(0xff00AD07),
                    borderRadius: BorderRadius.circular(10)),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        'assets/images/new-images/bns_renewal.svg',
                        color: Color(0xffffffff),
                        width: 19,height: 19,),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                            'Renew',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold))
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  bool validateAllFields(SyncStore syncStore,
      BnsRenewalChangeNotifier bnsRenewalChangeNotifier, SettingsStore settingsStore) {
    var isValid = false;
    if (syncStore.status is SyncedSyncStatus ||
        syncStore.status.blocksLeft == 0) {
      /*if (_bnsNameController.text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateBnsName(_bnsNameController.text, bnsRenewalChangeNotifier);
        });
        isValid = false;
      } else if (_bnsNameController.text.isNotEmpty && _bnsNameController.text.characters.first == '-') {
        isValid = false;
      } else if (_bnsNameController.text.isNotEmpty && _bnsNameController.text.characters.last == '-') {
        isValid = false;
      } else {
        isValid = true;
      }*/
      isValid = true;
    } else {
      isValid = false;
    }
    return isValid;
  }

/*  void validateBnsName(
      String value, BnsRenewalChangeNotifier bnsRenewalChangeNotifier) {
    var errorMessage = '';
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsRenewalChangeNotifier.setBnsNameFieldIsValid(true);
      });
      errorMessage = 'Please fill in this field';
    } else if (value.isNotEmpty && value.characters.first == '-') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsRenewalChangeNotifier.setBnsNameFieldIsValid(true);
      });
      errorMessage = 'Invalid BNS Name';
    } else if (value.isNotEmpty && value.characters.last == '-') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsRenewalChangeNotifier.setBnsNameFieldIsValid(true);
      });
      errorMessage = 'Invalid BNS Name';
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsRenewalChangeNotifier.setBnsNameFieldIsValid(false);
      });
      errorMessage = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bnsRenewalChangeNotifier.setBnsNameFieldErrorMessage(errorMessage);
    });
  }*/

  Widget bnsPriceItem(
      BnsPriceItem bnsPriceDetailsListItem,
      int index,
      int selectedIndex,
      SettingsStore settingsStore,
      BnsRenewalChangeNotifier bnsRenewalChangeNotifier) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          bnsRenewalChangeNotifier.setSelectedBnsPriceIndex(index);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: selectedIndex == index
                    ? Color(0xff0ba70f)
                    : settingsStore.isDarkTheme
                    ? Color(0xff3c3c51)
                    : Color(0xffFFFFFF),
                width: 2.0),
            color: settingsStore.isDarkTheme
                ? Color(0xff3c3c51)
                : Color(0xffFFFFFF)),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 5, left: 8, right: 8),
        child: Text(
          bnsPriceDetailsListItem.year,
          style: TextStyle(
              color: settingsStore.isDarkTheme
                  ? Color(0xffFFFFFF)
                  : Color(0xff000000),
              fontWeight: FontWeight.w500,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  void _startingBnsRenewalTransaction(
      SendStore sendStore,
      String mappingYears,
      String bnsName) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => BnsRenewalInitiatingTransactionLoader(
                mappingYears: mappingYears,
                bnsName: bnsName,
                sendStore: sendStore)));
  }

  @override
  void dispose() {
    _bnsNameController.dispose();
    Wakelock.disable();
    rDisposer?.call();
    super.dispose();
  }

  void _setEffects(BuildContext context) {
    if (_effectsInstalled) return;

    final sendStore = Provider.of<SendStore>(context);

    rDisposer = reaction((_) => sendStore.state, (SendingState state) {
      if (state is SendingFailed) {
        Wakelock.disable();
        Navigator.of(context).pop();
        var errorMessage = state.error;
        if(state.error.contains('Reason: Cannot buy an BNS name that is already registered')){
          errorMessage = 'BNS name is taken. Choose a different one.';
        }else if(state.error.contains('Could not convert the wallet address string, check it is correct,')){
          errorMessage = 'Enter a valid wallet address.';
        }else if(state.error.contains('Wallet address provided could not be parsed owner')){
          errorMessage = 'Invalid wallet address. Leave blank if you want to use the current wallet as the BNS owner.';
        }else if(state.error.contains('specifying owner the same as the backup owner')){
          errorMessage = 'Owner and backup address must be different.';
        }else if(state.error.contains('Failed to get output distribution')){
          errorMessage = 'Failed to get output distribution';
        }
        showSimpleBeldexDialog(context, S.of(context).alert, errorMessage,
            onPressed: (_) {
              Navigator.of(context).pop();
            });
      }

      if (state is TransactionCreatedSuccessfully &&
          sendStore.pendingTransaction != null) {
        print('transactionDescription fee --> created');
        Wakelock.disable();
        Navigator.of(context).pop();
        showSimpleConfirmDialog(
            context,
            S.of(context).confirm_sending,
            sendStore.pendingTransaction.amount,
            sendStore.pendingTransaction.fee,
            '${_bnsNameController.text}.bdx', onPressed: (_) {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) =>
                      CommitTransactionLoader(sendStore: sendStore)));
        }, onDismiss: (_) {
          Navigator.of(context).pop();
        });
      }

      if (state is TransactionCommitted) {
        print('transactionDescription fee --> committed');
        Wakelock.disable();
        Navigator.of(context).pop();
        showDialogTransactionSuccessfully(context, 'BNS Renewed Successfully', onPressed: (_) {
          Navigator.of(context)..pop()..pop();
        }, onDismiss: (_) {
          Navigator.of(context)..pop()..pop();
        });
      }
    });

    _effectsInstalled = true;
  }

  void bnsRenewalConfirmationDialogBox(
      SendStore sendStore,
      String bnsName,
      String mappingYearsId,
      String mappingYears,
      WalletStore walletStore) {
    showBnsRenewalConfirmationDialogBox(
        context,
        bnsName,
        mappingYearsId,
        mappingYears,
        walletStore, onPressed: (_) async {
      Navigator.of(context).pop();
      await Navigator.of(context).pushNamed(Routes.auth, arguments:
          (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
        print('inside authentication $isAuthenticatedSuccessfully');
        if (!isAuthenticatedSuccessfully) {
          return;
        }
        Navigator.of(auth.context).pop();
        _startingBnsRenewalTransaction(sendStore, mappingYearsId, bnsName);
      });
    }, onDismiss: (_) {
      Navigator.of(context).pop();
    });
  }
}
