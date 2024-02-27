import 'dart:async';
import 'dart:ui';

import 'package:beldex_coin/transaction_history.dart';
import 'package:beldex_wallet/src/bns/buy_bns_change_notifier.dart';
import 'package:beldex_wallet/src/bns/fetching_bns_record_dialog_box.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:beldex_coin/beldex_coin_structs.dart';

class MyBnsPage extends StatefulWidget {
  MyBnsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyBnsPageState();
}

class MyBnsPageState extends State<MyBnsPage> with TickerProviderStateMixin {
  final _decryptRecordController = TextEditingController();
  StreamController<List<BnsRow>> _getAllBnsStreamController;

  @override
  void initState() {
    _getAllBnsStreamController = StreamController<List<BnsRow>>();
    callGetAllBns();
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
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(
          0xffffffff),
      child: myBns(sendStore, settingsStore, syncStore),
    );
  }

  Widget myBns(SendStore sendStore, SettingsStore settingsStore,
      SyncStore syncStore) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
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
            Text(
              'Here you can find all the BNS Names owned by this wallet. Decrypting a record you own will return the name and value at the BNS record.',
              style: TextStyle(
                  fontSize: 13.0,
                  color: settingsStore.isDarkTheme
                      ? Color(0xffAFAFBE)
                      : Color(0xff000000),
                  fontWeight: FontWeight.w300,
                  fontFamily: 'OpenSans'),
            ),
            //Decrypt Record
            Container(
              margin: EdgeInsets.only(left: 5, top: 10),
              child: Text('Add Record',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans')),
            ),
            //Decrypt Record Field
            Container(
              margin: EdgeInsets.only(top: 5),
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
                controller: _decryptRecordController,
                style: TextStyle(fontSize: 14.0),
                maxLength: _decryptRecordController.text.contains('-')
                    ? 63
                    : 32,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      '[a-z0-9-]')),
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
                  hintText: 'A BNS name that belongs to you',
                  counterText: '',
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Observer(builder: (_) {
              return InkWell(
                onTap: syncStore.status is SyncedSyncStatus ||
                    syncStore.status.blocksLeft == 0
                    ? () async {
                  final currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (_decryptRecordController.text.isNotEmpty) {
                    FetchingBnsRecordDialogBox().showFetchingBnsRecordDialog(
                        context, settingsStore);
                    await getNameToNameHash('${_decryptRecordController
                        .text}.bdx').then((nameHash) {
                      var isValidBns = false;
                      getAllBns().then((value) {
                        if (value.isNotEmpty) {
                          for (var i = 0; i < value.length; i++) {
                            if (nameHash == value[i].nameHash) {
                              isValidBns = true;
                            }
                          }
                          if (isValidBns) {
                            final bnsSetRecordResponse = bnsSetRecord(
                                '${_decryptRecordController.text}.bdx');
                            if (bnsSetRecordResponse) {
                              callGetAllBns();
                              Navigator.of(context).pop();
                              Toast.show(
                                'Successfully decrypted BNS Record for ${_decryptRecordController
                                    .text}.bdx', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM,
                                textColor: Colors.white,
                                backgroundColor: Color(0xff0ba70f),
                              );
                              _decryptRecordController.clear();
                            }
                          } else {
                            Navigator.of(context).pop();
                            Toast.show(
                              'The given BNS record doesn\'t exist or does not belong to this wallet.',
                              context, duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM,
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                            );
                            _decryptRecordController.clear();
                          }
                        } else {
                          Navigator.of(context).pop();
                          Toast.show(
                            'Failed to decrypt BNS Record for ${_decryptRecordController
                                .text}.bdx', context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Colors.red,
                          );
                          _decryptRecordController.clear();
                        }
                      });
                    });
                  } else {
                    return null;
                  }
                }
                    : null,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        color: Color(0xff00AD07),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Add BNS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }),
            //BNS Records
            Container(
              margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
              child: Text('BNS Records',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans')),
            ),
            StreamBuilder<List<BnsRow>>(
              stream: _getAllBnsStreamController.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<BnsRow>> snapshot) {
                if (snapshot.data != null) {
                  final allBns = snapshot.data;
                  if (allBns.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      reverse: true,
                      itemCount: allBns.length,
                      itemBuilder: (BuildContext context, int index) {
                        final bnsDetails = allBns[index];
                        return Theme(
                          data: Theme.of(context).copyWith(
                              accentColor: settingsStore.isDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                              dividerColor: Colors.transparent,
                              textSelectionTheme: TextSelectionThemeData(
                                  selectionColor: Color(0xff0ba70f))),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff32324A)
                                    : Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(10)),
                            child: ExpansionTile(
                              title: bnsDetails.name != '(none)' ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bnsDetails.name,
                                    style: TextStyle(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffD1D1D3)
                                          : Color(0xff77778B),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Expiration Height : ',
                                        style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff222222),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Flexible(
                                        child: Text(
                                          bnsDetails.expirationHeight
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff77778B),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ) : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bnsDetails.nameHash,
                                    style: TextStyle(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xffD1D1D3)
                                          : Color(0xff77778B),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Expiration Height : ',
                                        style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff222222),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Flexible(
                                        child: Text(
                                          bnsDetails.expirationHeight
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff77778B),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Divider(
                                  color: settingsStore.isDarkTheme ? Color(
                                      0xff484856) : Color(0xffDADADA),
                                ),
                                //Update Height
                                Container(
                                  margin: EdgeInsets.only(left: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Update Height',
                                        style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff222222),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Flexible(
                                        child: Text(
                                          bnsDetails.updateHeight.toString(),
                                          style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff77778B),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: settingsStore.isDarkTheme ? Color(
                                      0xff484856) : Color(0xffDADADA),
                                ),
                                //Owner
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 16, right: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          'Owner',
                                          style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff222222),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          bnsDetails.owner,
                                          style: TextStyle(
                                            color: settingsStore.isDarkTheme
                                                ? Color(0xffD1D1D3)
                                                : Color(0xff77778B),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: settingsStore.isDarkTheme ? Color(
                                      0xff484856) : Color(0xffDADADA),
                                ),
                                //Backup Owner
                                Visibility(
                                  visible: bnsDetails.backUpOwner != '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Backup Owner',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.backUpOwner,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.backUpOwner != '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                                //Encrypted Address Value
                                Visibility(
                                  visible: bnsDetails.name == '(none)' &&
                                      bnsDetails.encryptedWalletValue !=
                                          '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Encrypted Address Value',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.encryptedWalletValue,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.name == '(none)' &&
                                      bnsDetails.encryptedWalletValue !=
                                          '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                                //Encrypted BChat ID Value
                                Visibility(
                                  visible: bnsDetails.name == '(none)' &&
                                      bnsDetails.encryptedBchatValue !=
                                          '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Encrypted BChat Value',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.encryptedBchatValue,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.name == '(none)' &&
                                      bnsDetails.encryptedBchatValue !=
                                          '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                                //Encrypted Belnet ID Value
                                Visibility(
                                  visible: bnsDetails.name == '(none)' &&
                                      bnsDetails.encryptedBelnetValue !=
                                          '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Encrypted Belnet Value',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.encryptedBelnetValue,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.name == '(none)' &&
                                      bnsDetails.encryptedBelnetValue !=
                                          '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                                //Address Value
                                Visibility(
                                  visible: bnsDetails.valueWallet != '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Address',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.valueWallet,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.valueWallet != '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                                //BChat Id Value
                                Visibility(
                                  visible: bnsDetails.valueBchat != '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'BChat ID',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.valueBchat,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.valueBchat != '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                                //Belnet Id Value
                                Visibility(
                                  visible: bnsDetails.valueBelnet != '(none)',
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Belnet ID',
                                            style: TextStyle(
                                                color: settingsStore.isDarkTheme
                                                    ? Color(0xffFFFFFF)
                                                    : Color(0xff222222),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          Text(
                                            bnsDetails.valueBelnet,
                                            style: TextStyle(
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffD1D1D3)
                                                  : Color(0xff77778B),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: bnsDetails.valueBelnet != '(none)',
                                  child: Divider(
                                    color: settingsStore.isDarkTheme ? Color(
                                        0xff484856) : Color(0xffDADADA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 310,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff24242f)
                              : Color(0xffF3F3F3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset(
                            'assets/images/new-images/ic_bns_dark.svg',
                            color: settingsStore.isDarkTheme
                                ? Color(0xff484860)
                                : Color.fromRGBO(72, 72, 96, 0.2),
                            width: 100, height: 100,),
                          Text(
                            'Here you can find all the BNS Names owned by this wallet. Decrypting a record you own will return the name and value at the BNS record.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13.0,
                                color: settingsStore.isDarkTheme
                                    ? Color(0xffAFAFBE)
                                    : Color(0xff626262),
                                fontWeight: FontWeight.w300,
                                fontFamily: 'OpenSans'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void validateBnsName(String value,
      BuyBnsChangeNotifier buyBnsChangeNotifier) {
    var errorMessage = '';
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBnsNameFieldIsValid(true);
      });
      errorMessage = 'Please fill in this field';
    } else if (value.isNotEmpty && value.characters.first == '-') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBnsNameFieldIsValid(true);
      });
      errorMessage = 'Invalid BNS Name';
    } else if (value.isNotEmpty && value.characters.last == '-') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBnsNameFieldIsValid(true);
      });
      errorMessage = 'Invalid BNS Name';
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBnsNameFieldIsValid(false);
      });
      errorMessage = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buyBnsChangeNotifier.setBnsNameFieldErrorMessage(errorMessage);
    });
  }

  void callGetAllBns() {
    getAllBns().then((value) {
      _getAllBnsStreamController.sink.add(value);
    });
  }

  @override
  void dispose() {
    _decryptRecordController.dispose();
    _getAllBnsStreamController.close();
    super.dispose();
  }
}
