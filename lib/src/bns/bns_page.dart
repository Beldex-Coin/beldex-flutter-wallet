import 'dart:ui';

import 'package:beldex_wallet/src/bns/buy_bns_change_notifier.dart';
import 'package:beldex_wallet/src/bns/my_bns_page.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/send/confirm_sending.dart';
import 'package:beldex_wallet/src/stores/send/sending_state.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/beldex_dialog.dart';
import 'package:beldex_wallet/src/widgets/bns_initiating_transaction_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../l10n.dart';
import '../../routes.dart';
import 'bns_commit_transaction_loader.dart';
import 'bns_price_item.dart';
import 'bns_purchase_options.dart';

class BnsPage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.bns;


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
    return BnsForm();
  }
}

class BnsForm extends StatefulWidget {
  BnsForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BnsFormState();
}

class BnsFormState extends State<BnsForm> with TickerProviderStateMixin {
  TabController? _bnsTabController;
  List<BnsPriceItem> bnsPriceDetailsList = [
    BnsPriceItem('1y', '1 Yr', '1 Year', '650 BDX', ''),
    BnsPriceItem('2y', '2 Yrs', '2 Years', '1000 BDX', '23.08%'),
    BnsPriceItem('5y', '5 Yrs', '5 Years', '2000 BDX', '38.46%'),
    BnsPriceItem('10y', '10 Yrs', '10 Years', '4000 BDX', '38.46%')
  ];

  final _bnsNameController = TextEditingController();
  final _bnsOwnerNameController = TextEditingController();
  //final _bnsBackUpOwnerNameController = TextEditingController();
  final _bChatIdController = TextEditingController();
  final _belnetIdController = TextEditingController();
  final _walletAddressController = TextEditingController();
  bool _effectsInstalled = false;
  ReactionDisposer? rDisposer;

  @override
  void initState() {
    _bnsTabController = TabController(length: 2, vsync: this);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Container(
          decoration: BoxDecoration(
              color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(
                  0xffffffff),
              boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.1,
                  offset: Offset(0.0, 0.75)
              ),
              ]
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(child: Container()),
                TabBar(
                  controller: _bnsTabController,
                  indicatorColor: Color(0xff0ba70f),
                  labelColor: Color(0xff0ba70f),
                  unselectedLabelColor: settingsStore.isDarkTheme
                      ? Color(0xff77778B)
                      : Color(0xffA8A8A8),
                  labelPadding: EdgeInsets.all(5),
                  labelStyle: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'),
                  tabs: [Text('Buy BNS'), Text('My BNS')],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(
            0xffffffff),
        child: TabBarView(
          controller: _bnsTabController,
          children: <Widget>[
            Consumer<BuyBnsChangeNotifier>(
                builder: (context, buyBnsChangeNotifier, child) {
                  return buyBns(settingsStore, bnsPriceDetailsList, sendStore,
                      syncStore, buyBnsChangeNotifier, walletStore);
                }),
            MyBnsPage(),
          ],
        ),
      ),
    );
  }

  Widget buyBns(
      SettingsStore settingsStore,
      List<BnsPriceItem> bnsPriceDetailsList,
      SendStore sendStore,
      SyncStore syncStore,
      BuyBnsChangeNotifier buyBnsChangeNotifier, WalletStore walletStore) {
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
            //BNS Description
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text('Purchase or update an BNS record. If you purchase a name, it may take a minute or two for it to show up in the list',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans')),
            ),
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
                        text: tr(context).bns,
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
                              buyBnsChangeNotifier.selectedBnsPriceIndex;
                          return bnsPriceItem(
                              bnsPriceDetailsList[index],
                              index,
                              selectedIndex,
                              settingsStore,
                              buyBnsChangeNotifier);
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
                                  '${bnsPriceDetailsList[buyBnsChangeNotifier.selectedBnsPriceIndex].detailYears} : ',
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
                                            buyBnsChangeNotifier
                                                .selectedBnsPriceIndex]
                                        .amountOfBdx,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff0ba70f)))
                              ]),
                        ),
                        bnsPriceDetailsList[
                                    buyBnsChangeNotifier.selectedBnsPriceIndex]
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
                                                  buyBnsChangeNotifier
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
                        backgroundColor: Colors.transparent,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffFFFFFF)
                            : Color(0xff000000),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OpenSans'),
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      backgroundColor: Colors.transparent,
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
                  validateBnsName(value, buyBnsChangeNotifier);
                },
              ),
            ),
            //BNS Name Field Error Message
            Visibility(
              visible: buyBnsChangeNotifier.bnsNameFieldIsValid,
              child: Container(
                margin: EdgeInsets.only(left: 15, bottom: 10),
                child: Text(buyBnsChangeNotifier.bnsNameFieldErrorMessage,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: 13.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OpenSans')),
              ),
            ),
            //BNS Owner Name
            Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Text('Owner (optional)',
                  style: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 13.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontWeight: FontWeight.w300,
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
                        ? Color(0xff3c3c51)
                        : Color(0xffDADADA)),
              ),
              padding: EdgeInsets.only(left: 8, right: 5),
              child: TextFormField(
                controller: _bnsOwnerNameController,
                style: TextStyle(fontSize: 14.0),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 12.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xff77778B)
                          : Color(0xff77778B)),
                  hintText: 'The wallet address of the owner',
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            //BNS Backup Owner Name
           /* Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Text('Backup Owner (optional)',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans')),
            ),*/
            //BNS Backup Owner Name Field
            /*Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
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
                controller: _bnsBackUpOwnerNameController,
                style: TextStyle(fontSize: 14.0),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
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
                          buyBnsChangeNotifier.bnsPurchaseOptions[0],
                          settingsStore,
                          buyBnsChangeNotifier,
                          0),
                      bnsPurchaseOptions(
                          buyBnsChangeNotifier.bnsPurchaseOptions[1],
                          settingsStore,
                          buyBnsChangeNotifier,
                          1),
                      bnsPurchaseOptions(
                          buyBnsChangeNotifier.bnsPurchaseOptions[2],
                          settingsStore,
                          buyBnsChangeNotifier,
                          2)
                    ],
                  ),
                  Visibility(
                    visible:
                        buyBnsChangeNotifier.bnsPurchaseOptions[0].selected,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff24242F)
                            : Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff3c3c51)
                                : Color(0xffDADADA)),
                      ),
                      padding: EdgeInsets.only(left: 8, right: 5, bottom: 15),
                      child: TextFormField(
                        controller: _walletAddressController,
                        style: TextStyle(backgroundColor: Colors.transparent,fontSize: 14.0),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              backgroundColor: Colors.transparent,
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
                              value, buyBnsChangeNotifier);
                        },
                      ),
                    ),
                  ),
                  //Wallet Address Field Error Message
                  Visibility(
                    visible:
                        buyBnsChangeNotifier.bnsPurchaseOptions[0].selected &&
                            buyBnsChangeNotifier.walletAddressFieldIsValid,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, bottom: 10),
                      child: Text(
                          buyBnsChangeNotifier.walletAddressFieldErrorMessage,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 13.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'OpenSans')),
                    ),
                  ),
                  Visibility(
                    visible:
                        buyBnsChangeNotifier.bnsPurchaseOptions[1].selected,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff24242F)
                            : Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff3c3c51)
                                : Color(0xffDADADA)),
                      ),
                      padding: EdgeInsets.only(left: 8, right: 5, bottom: 15),
                      child: TextFormField(
                        controller: _bChatIdController,
                        style: TextStyle(backgroundColor: Colors.transparent,fontSize: 14.0),
                        maxLength: 66,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]')),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              backgroundColor: Colors.transparent,
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
                          validateBchatIdField(value, buyBnsChangeNotifier);
                        },
                      ),
                    ),
                  ),
                  //Bchat Id Field Error Message
                  Visibility(
                    visible:
                        buyBnsChangeNotifier.bnsPurchaseOptions[1].selected &&
                            buyBnsChangeNotifier.bchatIdFieldIsValid,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, bottom: 10),
                      child: Text(buyBnsChangeNotifier.bchatIdFieldErrorMessage,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 13.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'OpenSans')),
                    ),
                  ),
                  Visibility(
                    visible:
                        buyBnsChangeNotifier.bnsPurchaseOptions[2].selected,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff24242F)
                            : Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: settingsStore.isDarkTheme
                                ? Color(0xff3c3c51)
                                : Color(0xffDADADA)),
                      ),
                      padding: EdgeInsets.only(left: 8, right: 5, bottom: 15),
                      child: TextFormField(
                        controller: _belnetIdController,
                        style: TextStyle(backgroundColor: Colors.transparent,fontSize: 14.0),
                        maxLength: 52,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              backgroundColor: Colors.transparent,
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
                          validateBelnetIdField(value, buyBnsChangeNotifier);
                        },
                      ),
                    ),
                  ),
                  //Belnet Id Field Error Message
                  Visibility(
                    visible:
                        buyBnsChangeNotifier.bnsPurchaseOptions[2].selected &&
                            buyBnsChangeNotifier.belnetIdFieldIsValid,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, bottom: 10),
                      child: Text(
                          buyBnsChangeNotifier.belnetIdFieldErrorMessage,
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              fontSize: 13.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'OpenSans')),
                    ),
                  ),
                ],
              ),
            ),
            Observer(builder: (_) {
              return InkWell(
                onTap: validateAllFields(
                        syncStore, buyBnsChangeNotifier, settingsStore)
                    ? () async {
                        final currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        bnsConfirmationDialogBox(
                            sendStore,
                            '${_bnsNameController.text}.bdx',
                            bnsPriceDetailsList[
                                    buyBnsChangeNotifier.selectedBnsPriceIndex]
                                .id,
                            bnsPriceDetailsList[
                                    buyBnsChangeNotifier.selectedBnsPriceIndex]
                                .detailYears,
                            _bnsOwnerNameController.text,
                            '',//_bnsBackUpOwnerNameController.text,
                            _walletAddressController.text,
                            _bChatIdController.text,
                            _belnetIdController.text.isNotEmpty
                                ? '${_belnetIdController.text}.bdx'
                                : _belnetIdController.text,
                        walletStore);
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
                  child: Text(
                    'Purchase',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  bool validateAllFields(SyncStore syncStore,
      BuyBnsChangeNotifier buyBnsChangeNotifier, SettingsStore settingsStore) {
    var isValid = false;
    if (syncStore.status is SyncedSyncStatus ||
        syncStore.status.blocksLeft == 0) {
      if (_bnsNameController.text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateBnsName(_bnsNameController.text, buyBnsChangeNotifier);
        });
        isValid = false;
      } else if (_bnsNameController.text.isNotEmpty && _bnsNameController.text.characters.first == '-') {
        isValid = false;
      } else if (_bnsNameController.text.isNotEmpty && _bnsNameController.text.characters.last == '-') {
        isValid = false;
      } else if (!buyBnsChangeNotifier.bnsPurchaseOptions[0].selected &&
          !buyBnsChangeNotifier.bnsPurchaseOptions[1].selected &&
          !buyBnsChangeNotifier.bnsPurchaseOptions[2].selected) {
        isValid = false;
      } else if (buyBnsChangeNotifier.bnsPurchaseOptions[0].selected &&
          _walletAddressController.text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateWalletAddressField(
              _walletAddressController.text, buyBnsChangeNotifier);
        });
        isValid = false;
      } else if (buyBnsChangeNotifier.bnsPurchaseOptions[1].selected &&
          _bChatIdController.text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateBchatIdField(_bChatIdController.text, buyBnsChangeNotifier);
        });
        isValid = false;
      } else if (buyBnsChangeNotifier.bnsPurchaseOptions[1].selected &&
          _bChatIdController.text.isNotEmpty &&
          _bChatIdController.text.length < 66) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateBchatIdField(_bChatIdController.text, buyBnsChangeNotifier);
        });
        isValid = false;
      } else if (buyBnsChangeNotifier.bnsPurchaseOptions[2].selected &&
          _belnetIdController.text.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateBelnetIdField(_belnetIdController.text, buyBnsChangeNotifier);
        });
        isValid = false;
      } else if (buyBnsChangeNotifier.bnsPurchaseOptions[2].selected &&
          _belnetIdController.text.isNotEmpty &&
          _belnetIdController.text.length < 52) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          validateBelnetIdField(_belnetIdController.text, buyBnsChangeNotifier);
        });
        isValid = false;
      } else {
        isValid = true;
      }
    } else {
      isValid = false;
    }
    return isValid;
  }

  void validateBnsName(
      String value, BuyBnsChangeNotifier buyBnsChangeNotifier) {
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

  void validateWalletAddressField(
      String value, BuyBnsChangeNotifier buyBnsChangeNotifier) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setWalletAddressFieldIsValid(true);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setWalletAddressFieldIsValid(false);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buyBnsChangeNotifier.setWalletAddressFieldErrorMessage(
          buyBnsChangeNotifier.walletAddressFieldIsValid
              ? 'Please fill in this field'
              : '');
    });
  }

  void validateBchatIdField(
      String value, BuyBnsChangeNotifier buyBnsChangeNotifier) {
    var errorMessage = '';
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'Please fill in this field';
    } else if (value.isNotEmpty && value.length < 66) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'Invalid BChat ID';
    } else if (value.isNotEmpty && value.substring(0, 2) != 'bd') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBchatIdFieldIsValid(true);
      });
      errorMessage = 'Invalid BChat ID';
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBchatIdFieldIsValid(false);
      });
      errorMessage = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buyBnsChangeNotifier.setBchatIdFieldErrorMessage(errorMessage);
    });
  }

  void validateBelnetIdField(
      String value, BuyBnsChangeNotifier buyBnsChangeNotifier) {
    var errorMessage = '';
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBelnetIdFieldIsValid(true);
      });
      errorMessage = 'Please fill in this field';
    } else if (value.isNotEmpty && value.length < 52) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBelnetIdFieldIsValid(true);
      });
      errorMessage = 'Invalid Belnet ID';
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        buyBnsChangeNotifier.setBelnetIdFieldIsValid(false);
      });
      errorMessage = '';
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buyBnsChangeNotifier.setBelnetIdFieldErrorMessage(errorMessage);
    });
  }

  Widget bnsPriceItem(
      BnsPriceItem bnsPriceDetailsListItem,
      int index,
      int selectedIndex,
      SettingsStore settingsStore,
      BuyBnsChangeNotifier buyBnsChangeNotifier) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buyBnsChangeNotifier.setSelectedBnsPriceIndex(index);
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

  Widget bnsPurchaseOptions(
      BnsPurchaseOptions bnsPurchaseOption,
      SettingsStore settingsStore,
      BuyBnsChangeNotifier buyBnsChangeNotifier,
      int index) {
    return InkWell(
      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buyBnsChangeNotifier.updateBnsPurchaseOptionsStatus(
              index, !buyBnsChangeNotifier.bnsPurchaseOptions[index].selected);
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
                    onChanged: (bool? value) {},
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

  void _startingBnsTransaction(
      SendStore sendStore,
      String owner,
      String backUpOwner,
      String mappingYears,
      String bchatId,
      String walletAddress,
      String belnetId,
      String bnsName) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (context) => BnsInitiatingTransactionLoader(
                owner: owner,
                backUpOwner: backUpOwner,
                mappingYears: mappingYears,
                bchatId: bchatId,
                walletAddress: walletAddress,
                belnetId: belnetId,
                bnsName: bnsName,
                sendStore: sendStore)));
  }

  @override
  void dispose() {
    _bnsTabController?.dispose();
    _bnsNameController.dispose();
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
        showSimpleBeldexDialog(context, tr(context).alert, errorMessage,
            onPressed: (_) {
              _bnsNameController.clear();
              _bnsOwnerNameController.clear();
              //_bnsBackUpOwnerNameController.clear();
              _walletAddressController.clear();
              _bChatIdController.clear();
              _belnetIdController.clear();
              Navigator.of(context).pop();
              }, onDismiss: (BuildContext context) {  });
      }

      if (state is TransactionCreatedSuccessfully &&
          sendStore.pendingTransaction != null) {
        print('transactionDescription fee --> created');
        Wakelock.disable();
        Navigator.of(context).pop();
        showSimpleConfirmDialog(
            context,
            tr(context).confirm_sending,
            sendStore.pendingTransaction?.amount,
            sendStore.pendingTransaction?.fee,
            '${_bnsNameController.text}.bdx', onPressed: (_) {
          _bnsNameController.clear();
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
          _bnsNameController.clear();
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
        showDialogTransactionSuccessfully(context, 'BNS Purchased Successfully', onPressed: (_) {
          Navigator.of(context)..pop()..pop();
        }, onDismiss: (_) {
          Navigator.of(context)..pop()..pop();
        });
      }
    });

    _effectsInstalled = true;
  }

  void bnsConfirmationDialogBox(
      SendStore sendStore,
      String bnsName,
      String mappingYearsId,
      String mappingYears,
      String owner,
      String backupOwner,
      String walletAddress,
      String bchatId,
      String belnetId, WalletStore walletStore) {
    showBnsConfirmationDialogBox(
        context,
        bnsName,
        mappingYearsId,
        mappingYears,
        owner,
        backupOwner,
        walletAddress,
        bchatId,
        belnetId,
        walletStore, onPressed: (_) async {
      Navigator.of(context).pop();
      await Navigator.of(context).pushNamed(Routes.auth, arguments:
          (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
        print('inside authentication $isAuthenticatedSuccessfully');
        if (!isAuthenticatedSuccessfully) {
          return;
        }
        Navigator.of(auth.context).pop();
        _startingBnsTransaction(sendStore, owner, backupOwner, mappingYearsId,
            bchatId, walletAddress, belnetId, bnsName);
      });
    }, onDismiss: (_) {
      Navigator.of(context).pop();
    });
  }
}
