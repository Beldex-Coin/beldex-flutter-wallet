import 'dart:ui';

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
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../../routes.dart';

class BnsPage extends BasePage {
  @override
  String get title => S.current.bns;

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
  BnsForm({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BnsFormState();
}

class BnsFormState extends State<BnsForm> with TickerProviderStateMixin {
  TabController _bnsTabController;
  List<BnsPriceItem> bnsPriceDetailsList = [
    BnsPriceItem('1y', '1 Year', '650 BDX'),
    BnsPriceItem('2y', '2 Years', '1000 BDX'),
    BnsPriceItem('5y', '5 Years', '2000 BDX'),
    BnsPriceItem('10y', '10 Years', '4000 BDX')
  ];

  final List<BnsPurchaseOptions> _bnsPurchaseOptions = [
    BnsPurchaseOptions('Address', true),
    BnsPurchaseOptions('BChat ID', true),
    BnsPurchaseOptions('Belnet ID', true)
  ];

  final _bnsNameController = TextEditingController();
  final _bnsOwnerNameController = TextEditingController();
  final _bnsBackUpOwnerNameController = TextEditingController();
  final _bChatIdController = TextEditingController();
  final _belnetIdController = TextEditingController();
  final _walletAddressController = TextEditingController();
  bool _effectsInstalled = false;
  ReactionDisposer rDisposer;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TabBar(
          controller: _bnsTabController,
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor:
              settingsStore.isDarkTheme ? Color(0xff77778B) : Color(0xffA8A8A8),
          isScrollable: true,
          labelStyle: TextStyle(
              backgroundColor: Colors.transparent,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
          tabs: <Widget>[
            Tab(
              text: 'Buy BNS',
            ),
            Tab(
              text: 'My BNS',
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _bnsTabController,
              children: <Widget>[
                buyBns(settingsStore, bnsPriceDetailsList,sendStore,syncStore),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: settingsStore.isDarkTheme
                        ? Color(0xff24242f)
                        : Color(0xffF3F3F3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buyBns(
      SettingsStore settingsStore, List<BnsPriceItem> bnsPriceDetailsList, SendStore sendStore, SyncStore syncStore) {
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
                    height: 190,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: bnsPriceDetailsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final current = 3;
                          return bnsPriceItem(bnsPriceDetailsList[index], index,
                              current, settingsStore);
                        }),
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
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            //BNS Owner Name
            Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Text('Owner (optional)',
                  style: TextStyle(
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: 12.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xff77778B)
                          : Color(0xff77778B)),
                  hintText: 'bxcALKJHSakhdsadhaskdhHHHDJADHUAWasasgjhrewrb6…',
                ),
                validator: (value) {
                 return null;
                },
              ),
            ),
            //BNS Backup Owner Name
            Container(
              margin: EdgeInsets.only(left: 15, top: 10),
              child: Text('Backup Owner name (optional)',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xffFFFFFF)
                          : Color(0xff000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'OpenSans')),
            ),
            //BNS Backup Owner Name Field
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 10),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontSize: 12.0,
                      color: settingsStore.isDarkTheme
                          ? Color(0xff77778B)
                          : Color(0xff77778B)),
                  hintText: 'bxcALKJHSakhdsadhaskdhHHHDJADHUAWasasgjhrewrb6…',
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
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
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      bnsPurchaseOptions(_bnsPurchaseOptions[0],settingsStore),
                      bnsPurchaseOptions(_bnsPurchaseOptions[1],settingsStore),
                      bnsPurchaseOptions(_bnsPurchaseOptions[2],settingsStore)
                    ],
                  ),
                  Visibility(
                    visible: _bnsPurchaseOptions[0].selected,
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
                      padding: EdgeInsets.only(left: 8, right: 5,bottom: 15),
                      child: TextFormField(
                        controller: _walletAddressController,
                        style: TextStyle(fontSize: 14.0),
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
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _bnsPurchaseOptions[1].selected,
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
                      padding: EdgeInsets.only(left: 8, right: 5,bottom: 15),
                      child: TextFormField(
                        controller: _bChatIdController,
                        style: TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          hintText: 'BChat ID',
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _bnsPurchaseOptions[0].selected,
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
                      padding: EdgeInsets.only(left: 8, right: 5,bottom: 15),
                      child: TextFormField(
                        controller: _belnetIdController,
                        style: TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: settingsStore.isDarkTheme
                                  ? Color(0xff77778B)
                                  : Color(0xff77778B)),
                          hintText: 'Belnet ID',
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
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
                  await Navigator.of(context).pushNamed(Routes.auth,
                      arguments: (bool isAuthenticatedSuccessfully,
                          AuthPageState auth) async {
                        print('inside authentication $isAuthenticatedSuccessfully');
                        if (!isAuthenticatedSuccessfully) {
                          return;
                        }
                        Navigator.of(auth.context).pop();
                        _startingBnsTransaction(sendStore,_bnsOwnerNameController.text,_bnsBackUpOwnerNameController.text,'1y',_bChatIdController.text,_walletAddressController.text,_belnetIdController.text,_bnsNameController.text);
                      });
                }
                    : null,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 20,left: 40,right: 40,bottom: 30),
                  decoration: BoxDecoration(
                      color: Color(0xff00AD07),
                      borderRadius: BorderRadius.circular(10)),
                  child:  Text(
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

  Widget bnsPriceItem(BnsPriceItem bnsPriceDetailsListItem, int index,
      int current, SettingsStore settingsStore) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: current == index
                  ? Color(0xff0ba70f)
                  : settingsStore.isDarkTheme
                      ? Color(0xff3c3c51)
                      : Color(0xffFFFFFF),
              width: 2.0),
          color: settingsStore.isDarkTheme
              ? Color(0xff3c3c51)
              : Color(0xffFFFFFF)),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bnsPriceDetailsListItem.year,
            style: TextStyle(
                color: settingsStore.isDarkTheme
                    ? Color(0xffFFFFFF)
                    : Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontFamily: 'OpenSans'),
          ),
          Text(bnsPriceDetailsListItem.amountOfBdx,
              style: TextStyle(
                  color: Color(0xff0ba70f),
                  fontWeight: FontWeight.w800,
                  fontFamily: 'OpenSans'))
        ],
      ),
    );
  }

  Widget bnsPurchaseOptions(BnsPurchaseOptions bnsPurchaseOption, SettingsStore settingsStore) {
    return Container(
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
                unselectedWidgetColor: Colors.green,
              ),
              child: SizedBox(
                width: 10,
                height: 10,
                child: Checkbox(value: bnsPurchaseOption.selected, onChanged: (bool value) {  },checkColor: settingsStore.isDarkTheme
                    ? Color(0xff3c3c51)
                    : Color(0xffFFFFFF),activeColor: Colors.green,),
              )),
          SizedBox(width: 10,),
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
    );
  }

  void _startingBnsTransaction(SendStore sendStore, String owner, String backUpOwner, String mappingYears, String bchatId, String walletAddress, String belnetId, String bnsName) {
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
    _bnsTabController.dispose();
    _bnsNameController.dispose();
    _bnsOwnerNameController.dispose();
    _bnsBackUpOwnerNameController.dispose();
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
        //WidgetsBinding.instance.addPostFrameCallback((_) {
        Wakelock.disable();
        Navigator.of(context).pop();
        showSimpleBeldexDialog(
            context, S.of(context).alert, state.error,
            onPressed: (_) => Navigator.of(context).pop());
        //});
      }

      if (state is TransactionCreatedSuccessfully &&
          sendStore.pendingTransaction != null) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        print('transactionDescription fee --> created');
        Wakelock.disable();
        Navigator.of(context).pop();
        showSimpleConfirmDialog(
            context,
            S.of(context).confirm_sending,
            sendStore.pendingTransaction.amount,
            sendStore.pendingTransaction.fee,
            '_addressController.text', onPressed: (_) {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (context) =>
                      CommitTransactionLoader(sendStore: sendStore)));
        }, onDismiss: (_) {
          /*_addressController.text = '';
          _cryptoAmountController.text = '';*/
          Navigator.of(context).pop();
        });
      }

      if (state is TransactionCommitted) {
        //WidgetsBinding.instance.addPostFrameCallback((_) {
        print('transactionDescription fee --> committed');
        Wakelock.disable();
        Navigator.of(context).pop();
        showDialogTransactionSuccessfully(context, onPressed: (_) {
         /* _addressController.text = '';
          _cryptoAmountController.text = '';*/
          Navigator.of(context)..pop()..pop();
        }, onDismiss: (_) {
          Navigator.of(context)..pop()..pop();
        });
        //});
      }
    });

    _effectsInstalled = true;
  }
}

class BnsPriceItem {
  BnsPriceItem(this.id, this.year, this.amountOfBdx);

  String id;
  String year;
  String amountOfBdx;
}

class BnsPurchaseOptions {
  BnsPurchaseOptions(this.title, this.selected);

  String title;
  bool selected;
}

class CommitTransactionLoader extends StatelessWidget {
  CommitTransactionLoader({Key key, this.sendStore}) : super(key: key);

  final SendStore sendStore;


  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.of(context).size.height;
    Wakelock.enable();
    Future.delayed(const Duration(seconds: 1), () {
      sendStore.commitTransaction();
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
                    Text(
                      S.of(context).initiatingTransactionTitle,
                      style: TextStyle(
                          fontSize: height * 0.07 / 3,
                          fontWeight: FontWeight.w800,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left:8.0,right:8.0),
                      child: Text(
                        S.of(context).initiatingTransactionDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height * 0.07 / 3,
                            fontWeight: FontWeight.w700,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffEBEBEB)
                                : Color(0xff222222)),
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
