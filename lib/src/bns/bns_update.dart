import 'dart:ui';

import 'package:beldex_wallet/src/bns/bns_update_change_notifier.dart';
import 'package:beldex_wallet/src/bns/bns_update_initiating_transaction_loader.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/send/confirm_sending.dart';
import 'package:beldex_wallet/src/stores/send/sending_state.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
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
import 'bns_purchase_options.dart';

class BnsUpdatePage extends BasePage {
  BnsUpdatePage({this.bnsDetails});

  final Map<String, dynamic> bnsDetails;

  @override
  String get title => S.current.bnsUpdate;

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
    return BnsUpdatePageForm(bnsDetails: bnsDetails,);
  }
}

class BnsUpdatePageForm extends StatefulWidget {
  BnsUpdatePageForm({this.bnsDetails});

  final Map<String, dynamic> bnsDetails;

  @override
  State<StatefulWidget> createState() => BnsUpdatePageFormState();
}

class BnsUpdatePageFormState extends State<BnsUpdatePageForm>
    with TickerProviderStateMixin {
  final _bnsOwnerNameController = TextEditingController();
  //final _bnsBackUpOwnerNameController = TextEditingController();
  final _bChatIdController = TextEditingController();
  final _belnetIdController = TextEditingController();
  final _walletAddressController = TextEditingController();
  bool _effectsInstalled = false;
  ReactionDisposer rDisposer;
  var _bnsUpdateChangeNotifier = BnsUpdateChangeNotifier();
  var bnsName = '';
  var ownerAddress = '';
  var walletAddress = '';
  var bchatId = '';
  var belnetId = '';
  @override
  void initState() {
    if(widget.bnsDetails != null){
      bnsName = widget.bnsDetails['bnsName'] as String ?? '';
      ownerAddress = widget.bnsDetails['ownerAddress'] as String ?? '';
      walletAddress = widget.bnsDetails['walletAddress'] as String ?? '';
      bchatId = widget.bnsDetails['bchatId'] as String ?? '';
      belnetId = widget.bnsDetails['belnetId'] as String ?? '';
      if(belnetId.isNotEmpty && belnetId != '(none)'){
        belnetId = belnetId.substring(0, belnetId.indexOf('.'));
      }
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
      backgroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        child: Consumer<BnsUpdateChangeNotifier>(
            builder: (context, bnsUpdateChangeNotifier, child) {
              _bnsUpdateChangeNotifier = bnsUpdateChangeNotifier;
          return bnsUpdate(settingsStore, sendStore, syncStore,
              bnsUpdateChangeNotifier, walletStore);
        }),
      ),
    );
  }

  Widget bnsUpdate(
      SettingsStore settingsStore,
      SendStore sendStore,
      SyncStore syncStore,
      BnsUpdateChangeNotifier bnsUpdateChangeNotifier,
      WalletStore walletStore) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: settingsStore.isDarkTheme
                ? Color(0xff24242f)
                : Color(0xffF3F3F3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //Update Owner
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: settingsStore.isDarkTheme
                      ? Color(0xff2C2C3F)
                      : Color(0xffFFFFFF),
                  border: Border.all(
                    color: settingsStore.isDarkTheme?Color(0xff484856):Color(0xffDADADA))
              ),
              foregroundDecoration: BoxDecoration(
                color: settingsStore.isDarkTheme
                    ? bnsUpdateChangeNotifier.selectedBnsUpdateOption == 2?Color(0x9324242F):Colors.transparent
                    : bnsUpdateChangeNotifier.selectedBnsUpdateOption == 2?Color(0x93F3F3F3):Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Update Owner Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue:
                            bnsUpdateChangeNotifier.selectedBnsUpdateOption,
                        activeColor: Color(0xff00AD07),
                        fillColor: MaterialStateProperty.all(Color(0xff00AD07)),
                        onChanged: (value) {
                          bnsUpdateChangeNotifier
                              .setSelectedBnsUpdateOption(value);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      Container(
                        child: Text('Update Owner',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff222222),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'OpenSans')),
                      ),
                    ],
                  ),
                  AbsorbPointer(
                    absorbing: bnsUpdateChangeNotifier.selectedBnsUpdateOption == 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //BNS Owner Name
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 5),
                          child: Text('Owner',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffAFAFBE)
                                      : Color(0xff222222),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'OpenSans')),
                        ),
                        //BNS Owner Name Field
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                          decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff24242F)
                                : Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff484856)
                                    : Color(0xffDADADA)),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 5),
                          child: TextFormField(
                            controller: _bnsOwnerNameController,
                            style: TextStyle(fontSize: 14.0),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff77778B)
                                      : Color(0xff77778B)),
                              hintText: 'The wallet address of the owner',
                            ),
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {
                              validateOwner(value, bnsUpdateChangeNotifier);
                            },
                          ),
                        ),
                        //BNS Owner Field Error Message
                        Visibility(
                          visible: bnsUpdateChangeNotifier.ownerAddressFieldIsValid && bnsUpdateChangeNotifier.selectedBnsUpdateOption == 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(bnsUpdateChangeNotifier.ownerAddressFieldErrorMessage,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'OpenSans')),
                          ),
                        ),
                        SizedBox(height: 15,),
                        //BNS Backup Owner Name
                        /*Container(
                          margin: EdgeInsets.only(left: 15, top: 10),
                          child: Text('Backup Owner (optional)',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffAFAFBE)
                                      : Color(0xff222222),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'OpenSans')),
                        ),*/
                        //BNS Backup Owner Name Field
                        /*Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 10),
                          decoration: BoxDecoration(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff24242F)
                                : Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff484856)
                                    : Color(0xffDADADA)),
                          ),
                          padding: EdgeInsets.only(left: 8, right: 5),
                          child: TextFormField(
                            controller: _bnsBackUpOwnerNameController,
                            style: TextStyle(fontSize: 14.0),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff77778B)
                                      : Color(0xff77778B)),
                              hintText: 'The wallet address of the backup owner',
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Update Values
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff2C2C3F)
                        : Color(0xffFFFFFF),
                    border: Border.all(
                        color: settingsStore.isDarkTheme?Color(0xff484856):Color(0xffDADADA))),
                foregroundDecoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ?  bnsUpdateChangeNotifier.selectedBnsUpdateOption == 1?Color(0x9324242F):Colors.transparent
                      : bnsUpdateChangeNotifier.selectedBnsUpdateOption == 1?Color(0x93F3F3F3):Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Update Values Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<int>(
                          value: 2,
                          groupValue:
                              bnsUpdateChangeNotifier.selectedBnsUpdateOption,
                          activeColor: Color(0xff00AD07),
                          fillColor: MaterialStateProperty.all(Color(0xff00AD07)),
                          onChanged: (value) {
                            bnsUpdateChangeNotifier
                                .setSelectedBnsUpdateOption(value);
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        Container(
                          child: Text('Update Values',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff222222),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'OpenSans')),
                        ),
                      ],
                    ),
                    AbsorbPointer(
                      absorbing: bnsUpdateChangeNotifier.selectedBnsUpdateOption == 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: settingsStore.isDarkTheme
                                ? Color(0xff32324a)
                                : Color(0xffDEDEDE)),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                bnsPurchaseOptions(
                                    bnsUpdateChangeNotifier.bnsPurchaseOptions[0],
                                    settingsStore,
                                    bnsUpdateChangeNotifier,
                                    0),
                                bnsPurchaseOptions(
                                    bnsUpdateChangeNotifier.bnsPurchaseOptions[1],
                                    settingsStore,
                                    bnsUpdateChangeNotifier,
                                    1),
                                bnsPurchaseOptions(
                                    bnsUpdateChangeNotifier.bnsPurchaseOptions[2],
                                    settingsStore,
                                    bnsUpdateChangeNotifier,
                                    2)
                              ],
                            ),
                            Visibility(
                              visible: bnsUpdateChangeNotifier
                                  .bnsPurchaseOptions[0].selected,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff24242F)
                                      : Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff484856)
                                          : Color(0xffDADADA)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 8, right: 5, bottom: 15),
                                child: TextFormField(
                                  controller: _walletAddressController,
                                  style: TextStyle(fontSize: 14.0),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 12.0,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff77778B)
                                            : Color(0xff77778B)),
                                    hintText: 'Address',
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                  onChanged: (value) {
                                    validateWalletAddressField(
                                        value, bnsUpdateChangeNotifier);
                                  },
                                ),
                              ),
                            ),
                            //Wallet Address Field Error Message
                            Visibility(
                              visible: bnsUpdateChangeNotifier
                                  .bnsPurchaseOptions[0].selected &&
                                  bnsUpdateChangeNotifier
                                      .walletAddressFieldIsValid && bnsUpdateChangeNotifier.selectedBnsUpdateOption == 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 15, bottom: 10),
                                child: Text(
                                    bnsUpdateChangeNotifier
                                        .walletAddressFieldErrorMessage,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'OpenSans')),
                              ),
                            ),
                            Visibility(
                              visible: bnsUpdateChangeNotifier
                                  .bnsPurchaseOptions[1].selected,
                              child: Container(
                                margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                                decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff24242F)
                                      : Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff484856)
                                          : Color(0xffDADADA)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 8, right: 5, bottom: 15),
                                child: TextFormField(
                                  controller: _bChatIdController,
                                  style: TextStyle(fontSize: 14.0),
                                  maxLength: 66,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 12.0,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff77778B)
                                            : Color(0xff77778B)),
                                    hintText: 'BChat ID',
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                  onChanged: (value) {
                                    validateBchatIdField(
                                        value, bnsUpdateChangeNotifier);
                                  },
                                ),
                              ),
                            ),
                            //Bchat Id Field Error Message
                            Visibility(
                              visible: bnsUpdateChangeNotifier
                                  .bnsPurchaseOptions[1].selected &&
                                  bnsUpdateChangeNotifier.bchatIdFieldIsValid && bnsUpdateChangeNotifier.selectedBnsUpdateOption == 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 15, bottom: 10),
                                child: Text(
                                    bnsUpdateChangeNotifier
                                        .bchatIdFieldErrorMessage,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'OpenSans')),
                              ),
                            ),
                            Visibility(
                              visible: bnsUpdateChangeNotifier
                                  .bnsPurchaseOptions[2].selected,
                              child: Container(
                                margin:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                                decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff24242F)
                                      : Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff484856)
                                          : Color(0xffDADADA)),
                                ),
                                padding: EdgeInsets.only(
                                    left: 8, right: 5, bottom: 15),
                                child: TextFormField(
                                  controller: _belnetIdController,
                                  style: TextStyle(fontSize: 14.0),
                                  maxLength: 52,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 12.0,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff77778B)
                                            : Color(0xff77778B)),
                                    hintText: 'Belnet ID',
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                  onChanged: (value) {
                                    validateBelnetIdField(
                                        value, bnsUpdateChangeNotifier);
                                  },
                                ),
                              ),
                            ),
                            //Belnet Id Field Error Message
                            Visibility(
                              visible: bnsUpdateChangeNotifier
                                  .bnsPurchaseOptions[2].selected &&
                                  bnsUpdateChangeNotifier.belnetIdFieldIsValid && bnsUpdateChangeNotifier.selectedBnsUpdateOption == 2,
                              child: Container(
                                margin: EdgeInsets.only(left: 15, bottom: 10),
                                child: Text(
                                    bnsUpdateChangeNotifier
                                        .belnetIdFieldErrorMessage,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'OpenSans')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Note : ',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffAFAFBE)
                              : Color(0xff626262)),
                      children: [
                        TextSpan(
                          text:
                              'You can only update owner address or values at a time. If you want to update both, you can either update the value before ownership or after transferring ownership.',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xffAFAFBE)
                                  : Color(0xff626262)),
                        )
                      ]),
                )),
            Observer(builder: (_) {
              return InkWell(
                onTap: validateAllFields(
                        syncStore, bnsUpdateChangeNotifier, settingsStore)
                    ? () async {
                        final currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        final bnsUpdateOption = bnsUpdateChangeNotifier.selectedBnsUpdateOption;
                        if(bnsUpdateOption == 1){
                          bnsUpdateConfirmationDialogBox(
                              sendStore,
                              bnsName,
                              _bnsOwnerNameController.text,
                              '',//_bnsBackUpOwnerNameController.text,
                              '',
                              '',
                              '',
                              walletStore,bnsUpdateOption);
                        }else{
                          bnsUpdateConfirmationDialogBox(
                              sendStore,
                              bnsName,
                              '',
                              '',
                              _walletAddressController.text,
                              _bChatIdController.text,
                              _belnetIdController.text.isNotEmpty
                                  ? '${_belnetIdController.text}.bdx'
                                  : _belnetIdController.text,
                              walletStore,bnsUpdateOption);
                        }
                      }
                    : null,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin:
                      EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 30),
                  decoration: BoxDecoration(
                      color: Color(0xff00AD07),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          'assets/images/new-images/bns_update.svg',
                          color: Color(0xffffffff),
                        width: 19,height: 19,),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                              'Update',
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
      ),
    );
  }

  bool validateAllFields(
      SyncStore syncStore,
      BnsUpdateChangeNotifier bnsUpdateChangeNotifier,
      SettingsStore settingsStore) {
    var isValid = false;
    if (syncStore.status is SyncedSyncStatus ||
        syncStore.status.blocksLeft == 0) {
      if(bnsUpdateChangeNotifier.selectedBnsUpdateOption == 1){
        if (_bnsOwnerNameController.text.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateOwner(_bnsOwnerNameController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        }else if (_bnsOwnerNameController.text == ownerAddress){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateOwner(_bnsOwnerNameController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        }else{
          isValid = true;
        }
      }else{
        if (!bnsUpdateChangeNotifier.bnsPurchaseOptions[0].selected &&
            !bnsUpdateChangeNotifier.bnsPurchaseOptions[1].selected &&
            !bnsUpdateChangeNotifier.bnsPurchaseOptions[2].selected) {
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[0].selected &&
            _walletAddressController.text.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateWalletAddressField(
                _walletAddressController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[0].selected &&
            _walletAddressController.text == walletAddress) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateWalletAddressField(
                _walletAddressController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        }else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[1].selected &&
            _bChatIdController.text.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateBchatIdField(
                _bChatIdController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[1].selected &&
            _bChatIdController.text == bchatId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateBchatIdField(
                _bChatIdController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[1].selected &&
            _bChatIdController.text.isNotEmpty &&
            _bChatIdController.text.length < 66) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateBchatIdField(
                _bChatIdController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[2].selected &&
            _belnetIdController.text.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateBelnetIdField(
                _belnetIdController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[2].selected &&
            _belnetIdController.text == belnetId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateBelnetIdField(
                _belnetIdController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else if (bnsUpdateChangeNotifier.bnsPurchaseOptions[2].selected &&
            _belnetIdController.text.isNotEmpty &&
            _belnetIdController.text.length < 52) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            validateBelnetIdField(
                _belnetIdController.text, bnsUpdateChangeNotifier);
          });
          isValid = false;
        } else {
          isValid = true;
        }
      }
    } else {
      isValid = false;
    }
    return isValid;
  }

  void validateOwner(
      String value, BnsUpdateChangeNotifier bnsUpdateChangeNotifier) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setOwnerAddressFieldIsValid(true);
      });
    } else if (value == ownerAddress){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setOwnerAddressFieldIsValid(true);
      });
    }else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setOwnerAddressFieldIsValid(false);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bnsUpdateChangeNotifier.setOwnerAddressFieldErrorMessage(
          bnsUpdateChangeNotifier.ownerAddressFieldIsValid
              ? value == ownerAddress ?'same owner address':'Please fill in this field'
              : '');
    });
  }

  void validateWalletAddressField(
      String value, BnsUpdateChangeNotifier bnsUpdateChangeNotifier) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setWalletAddressFieldIsValid(true);
      });
    } else if (value == walletAddress){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setWalletAddressFieldIsValid(true);
      });
    }else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setWalletAddressFieldIsValid(false);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bnsUpdateChangeNotifier.setWalletAddressFieldErrorMessage(
          bnsUpdateChangeNotifier.walletAddressFieldIsValid
              ? value == walletAddress?'same wallet address':'Please fill in this field'
              : '');
    });
  }

  void validateBchatIdField(
      String value, BnsUpdateChangeNotifier bnsUpdateChangeNotifier) {
    var errorMessage = '';
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'Please fill in this field';
    } else if (value.isNotEmpty && value.length < 66) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'Invalid BChat ID';
    } else if (value.isNotEmpty && value.substring(0, 2) != 'bd') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'Invalid BChat ID';
    } else if (value == bchatId){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'same Bchat id';
    }else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBchatIdFieldIsValid(false);
      });
      errorMessage = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bnsUpdateChangeNotifier.setBchatIdFieldErrorMessage(errorMessage);
    });
  }

  void validateBelnetIdField(
      String value, BnsUpdateChangeNotifier bnsUpdateChangeNotifier) {
    var errorMessage = '';
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBelnetIdFieldIsValid(true);
      });
      errorMessage = 'Please fill in this field';
    } else if (value.isNotEmpty && value.length < 52) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBelnetIdFieldIsValid(true);
      });
      errorMessage = 'Invalid Belnet ID';
    } else if (value == belnetId){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBelnetIdFieldIsValid(true);
      });
      errorMessage = 'same Belnet id';
    }else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bnsUpdateChangeNotifier.setBelnetIdFieldIsValid(false);
      });
      errorMessage = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bnsUpdateChangeNotifier.setBelnetIdFieldErrorMessage(errorMessage);
    });
  }

  Widget bnsPurchaseOptions(
      BnsPurchaseOptions bnsPurchaseOption,
      SettingsStore settingsStore,
      BnsUpdateChangeNotifier bnsUpdateChangeNotifier,
      int index) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          bnsUpdateChangeNotifier.updateBnsPurchaseOptionsStatus(index,
              !bnsUpdateChangeNotifier.bnsPurchaseOptions[index].selected);
          switch (index) {
            case 0:
              _walletAddressController.clear();
              break;
            case 1:
              _bChatIdController.clear();
              break;
            case 2:
              _belnetIdController.clear();
              break;
            default:
              break;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: bnsPurchaseOption.selected
                    ? Color(0xff0ba70f)
                    : settingsStore.isDarkTheme
                        ? Color(0xff333343)
                        : Color(0xffFFFFFF),
                width: 1.0),
            color: settingsStore.isDarkTheme
                ? Color(0xff3c3c51)
                : Color(0xffFFFFFF)),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Color(0xff0ba70f),
                ),
                child: SizedBox(
                  width: 10,
                  height: 10,
                  child: Checkbox(
                    value: bnsPurchaseOption.selected,
                    onChanged: (bool value) {},
                    checkColor: settingsStore.isDarkTheme
                        ? Color(0xff3c3c51)
                        : Color(0xffFFFFFF),
                    activeColor: Color(0xff0ba70f),
                  ),
                )),
            SizedBox(
              width: 10,
            ),
            Text(
              bnsPurchaseOption.title,
              style: TextStyle(
                  color: settingsStore.isDarkTheme
                      ? Color(0xffFFFFFF)
                      : Color(0xff000000),
                  fontWeight: FontWeight.w300,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans'),
            ),
          ],
        ),
      ),
    );
  }

  void _startingBnsUpdateTransaction(
      SendStore sendStore,
      String owner,
      String backUpOwner,
      String bchatId,
      String walletAddress,
      String belnetId,
      String bnsName) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => BnsUpdateInitiatingTransactionLoader(
                owner: owner,
                backUpOwner: backUpOwner,
                bchatId: bchatId,
                walletAddress: walletAddress,
                belnetId: belnetId,
                bnsName: bnsName,
                sendStore: sendStore)));
  }

  @override
  void dispose() {
    _bnsOwnerNameController.dispose();
    //_bnsBackUpOwnerNameController.dispose();
    _bChatIdController.dispose();
    _belnetIdController.dispose();
    _walletAddressController.dispose();
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
        if (state.error.contains(
            'Reason: Cannot buy an BNS name that is already registered')) {
          errorMessage = 'BNS name is taken. Choose a different one.';
        } else if (state.error.contains(
            'Could not convert the wallet address string, check it is correct,')) {
          errorMessage = 'Enter a valid wallet address.';
        } else if (state.error
            .contains('Wallet address provided could not be parsed owner')) {
          errorMessage =
              'Invalid Owner address.';
        } else if (state.error
            .contains('specifying owner the same as the backup owner')) {
          errorMessage = 'Owner and backup address must be different.';
        } else if (state.error.contains('Failed to get output distribution')) {
          errorMessage = 'Failed to get output distribution';
        }
        showSimpleBeldexDialog(context, S.of(context).alert, errorMessage,
            onPressed: (_) {
          _bnsOwnerNameController.clear();
          //_bnsBackUpOwnerNameController.clear();
          _walletAddressController.clear();
          _bChatIdController.clear();
          _belnetIdController.clear();
          if(_bnsUpdateChangeNotifier!=null){
            _bnsUpdateChangeNotifier.refresh();
          }
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
            bnsName,
            onPressed: (_) {
          _bnsOwnerNameController.clear();
          //_bnsBackUpOwnerNameController.clear();
          _walletAddressController.clear();
          _bChatIdController.clear();
          _belnetIdController.clear();
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) =>
                      CommitTransactionLoader(sendStore: sendStore)));
        }, onDismiss: (_) {
          _bnsOwnerNameController.clear();
          //_bnsBackUpOwnerNameController.clear();
          _walletAddressController.clear();
          _bChatIdController.clear();
          _belnetIdController.clear();
          Navigator.of(context).pop();
        });
      }

      if (state is TransactionCommitted) {
        print('transactionDescription fee --> committed');
        Wakelock.disable();
        Navigator.of(context).pop();
        showDialogTransactionSuccessfully(context, 'BNS Updated Successfully',
            onPressed: (_) {
          Navigator.of(context)..pop()..pop();
        }, onDismiss: (_) {
          Navigator.of(context)..pop()..pop();
        });
      }
    });

    _effectsInstalled = true;
  }

  void bnsUpdateConfirmationDialogBox(
      SendStore sendStore,
      String bnsName,
      String owner,
      String backupOwner,
      String walletAddress,
      String bchatId,
      String belnetId,
      WalletStore walletStore,int bnsUpdateOption) {
    showBnsUpdateConfirmationDialogBox(
        context,
        bnsName,
        owner,
        backupOwner,
        walletAddress,
        bchatId,
        belnetId,
        walletStore,
        bnsUpdateOption, onPressed: (_) async {
      Navigator.of(context).pop();
      await Navigator.of(context).pushNamed(Routes.auth, arguments:
          (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
        print('inside authentication $isAuthenticatedSuccessfully');
        if (!isAuthenticatedSuccessfully) {
          return;
        }
        Navigator.of(auth.context).pop();
        _startingBnsUpdateTransaction(sendStore, owner, backupOwner, bchatId, walletAddress, belnetId, bnsName);
      });
    }, onDismiss: (_) {
      Navigator.of(context).pop();
    });
  }
}
