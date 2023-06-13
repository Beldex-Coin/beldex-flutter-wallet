import 'dart:ui';

import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/send/send_page.dart';
import 'package:date_range_picker/date_range_picker.dart' as date_rage_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';

//import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';

//import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/dashboard/date_section_row.dart';
import 'package:beldex_wallet/src/screens/dashboard/transaction_row.dart';
import 'package:beldex_wallet/src/screens/dashboard/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/action_list/action_list_store.dart';
import 'package:beldex_wallet/src/stores/action_list/date_section_item.dart';
import 'package:beldex_wallet/src/stores/action_list/transaction_list_item.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/widgets/picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../palette.dart';

class DashboardPage extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget leading(BuildContext context) {
    return InkWell(
      onTap:() {
        _presentWalletMenu(context);
      },
      child: Container(
        height: 20,
          padding: EdgeInsets.only(top: 12.0,bottom: 10),
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              //color: Colors.black,
              ),
          child: SvgPicture.asset('assets/images/new-images/refresh.svg',color: Theme.of(context).primaryTextTheme.caption.color,)
          // Icon(Icons.autorenew_outlined,color: Theme.of(context).primaryTextTheme.caption.color,
          // )
          ),
    );
  }

  /*@override
  Widget leading(BuildContext context) {
    return SizedBox(
        width: 30,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () => _presentWalletMenu(context),
            child: Icon(Icons.sync_rounded,
                color: Theme.of(context).primaryTextTheme.caption.color,
                size: 30)));
  }*/

 /* @override
  Widget middle(BuildContext context) {
    //final walletStore = Provider.of<WalletStore>(context);

    return Text(
      S.current.wallet_list_title,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    ); *//*Observer(builder: (_) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              walletStore.name,
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6.color),
            ),
            SizedBox(height: 5),
            Text(
              walletStore.account != null ? '${walletStore.account.label}' : '',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Theme.of(context).primaryTextTheme.headline6.color),
            ),
          ]);
    })*//*
  }*/
  @override
  Widget middle(BuildContext context) {
    //final walletStore = Provider.of<WalletStore>(context);
  final walletStore = Provider.of<WalletStore>(context);
    return Observer(builder: (_){
          return Text(walletStore.name,style: TextStyle(fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .headline6
                                                      .color ),); 
    },);
     //Image.asset('assets/images/title_with_logo.png', height: 134, width: 160);
     /*Observer(builder: (_) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              walletStore.name,
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6.color),
            ),
            SizedBox(height: 5),
            Text(
              walletStore.account != null ? '${walletStore.account.label}' : '',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Theme.of(context).primaryTextTheme.headline6.color),
            ),
          ]);
    })*/
  }

  @override
  Widget trailing(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.centerLeft,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).accentTextTheme.headline6.color,
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Theme.of(context).accentTextTheme.headline6.color,
      //       blurRadius: 2.0,
      //       spreadRadius: 1.0,
      //       offset: Offset(2.0, 2.0), // shadow direction: bottom right
      //     )
      //   ],
      // ),
      child: SizedBox(
        height: 55, //55
        width: 55, //37
        child: ButtonTheme(
          minWidth: double.minPositive,
          child: TextButton(
              /* highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(0),*/
              style: ButtonStyle(
                overlayColor:
                    MaterialStateColor.resolveWith((states) => Colors.transparent),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.profile),
              child:
               SvgPicture.asset(
                'assets/images/new-images/setting.svg',
                fit: BoxFit.cover,
                color: settingsStore.isDarkTheme ? Colors.white : Colors.black,
                width: 25,
                height: 25,
              ) /*Icon(Icons.account_circle_rounded,
                  color: Theme.of(context).primaryTextTheme.caption.color,
                  size: 30)*/
              ),
        ),
      ),
    );
  }

  /*@override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 30,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => Navigator.of(context).pushNamed(Routes.profile),
          child: Icon(Icons.account_circle_rounded,
              color: Theme.of(context).primaryTextTheme.caption.color,
              size: 30)),
    );
  }*/

  @override
  Widget body(BuildContext context) => DashboardPageBody(key: _bodyKey);

  void _presentWalletMenu(BuildContext bodyContext) {
    final walletMenu = WalletMenu(bodyContext);

    showDialog<void>(
        builder: (_) => Picker(
            items: walletMenu.items,
            selectedAtIndex: -1,
            title: S.of(bodyContext).wallet_menu,
            pickerHeight: 250,
            onItemSelected: (String item) =>
                walletMenu.action(walletMenu.items.indexOf(item))),
        context: bodyContext);
  }
}

class DashboardPageBody extends StatefulWidget {
  DashboardPageBody({Key key}) : super(key: key);

  @override
  DashboardPageBodyState createState() => DashboardPageBodyState();
}

class DashboardPageBodyState extends State<DashboardPageBody> {
  final _connectionStatusObserverKey = GlobalKey();
  final _balanceObserverKey = GlobalKey();
  final _balanceTitleObserverKey = GlobalKey();
  final _syncingObserverKey = GlobalKey();
  final _listObserverKey = GlobalKey();
  final _listKey = GlobalKey();
  final _sendbuttonEnableKey = GlobalKey();
  String syncStatus;

  //
  List<Item> transactions = [
    Item(
        id: 'send',
        icon: Icons.arrow_upward,
        text: '01.02.2021',
        amount: '-\$ 99.00',
        color: Colors.red),
    Item(
        id: 'receive',
        icon: Icons.arrow_downward,
        text: '25.01.2021',
        amount: '+\$ 105.00',
        color: Colors.green),
    Item(
        id: 'send',
        icon: Icons.arrow_upward,
        text: '01.02.2021',
        amount: '-\$ 105.00',
        color: Colors.red),
    Item(
        id: 'send',
        icon: Icons.arrow_upward,
        text: '01.02.2021',
        amount: '-\$ 105.00',
        color: Colors.red),
    Item(
        id: 'receive',
        icon: Icons.arrow_downward,
        text: '20.01.2021',
        amount: '+\$ 60.00',
        color: Colors.green),
    Item(
        id: 'send',
        icon: Icons.arrow_upward,
        text: '01.02.2021',
        amount: '-\$ 105.00',
        color: Colors.red),
    Item(
        id: 'receive',
        icon: Icons.arrow_downward,
        text: '20.01.2021',
        amount: '+\$ 60.00',
        color: Colors.green),
    Item(
        id: 'send',
        icon: Icons.arrow_upward,
        text: '01.02.2021',
        amount: '-\$ 105.00',
        color: Colors.red),
    Item(
        id: 'receive',
        icon: Icons.arrow_downward,
        text: '20.01.2021',
        amount: '+\$ 60.00',
        color: Colors.green),
    Item(
        id: 'send',
        icon: Icons.arrow_upward,
        text: '01.02.2021',
        amount: '-\$ 105.00',
        color: Colors.red)
  ];

  IconData iconDataVal = Icons.arrow_upward_outlined;


Future<void> _presentQRScanner(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  String qrValue;
    try {
      final code = await presentQRScanner();
      final uri = Uri.parse(code);
      var address = '';

      if (uri == null) {
        controller.text = code;
        qrValue = code;
        return;
      }

      address = uri.path;
      controller.text = address;
      qrValue = address;

   SharedPreferences prefs = await SharedPreferences.getInstance();
  // final myValue = '9vMwdHFQyV3aJc9XqHYzhy2pi8C8xcXXzaJq1PDQAQVJU2r8PP1ofv9b1HUcpwZZNyjYLTXBdYguRbXztwbRwXNfD51ddox';
   await prefs.setString('qrValue', qrValue);
   await prefs.setBool('isFlashTransaction',true);
   setState(() {
        //SendPage().controller = '9vMwdHFQyV3aJc9XqHYzhy2pi8C8xcXXzaJq1PDQAQVJU2r8PP1ofv9b1HUcpwZZNyjYLTXBdYguRbXztwbRwXNfD51ddox';
      });
    await Navigator.of(context).pushNamed(Routes.send);




      // if (onURIScanned != null) {
      //   onURIScanned(uri);
      // }
    } catch (e) {
     /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid BDX address'),
      ));*/
      print('Error $e');
    }
  }
















  @override
  Widget build(BuildContext context) {
    //
    final walletStore = Provider.of<WalletStore>(context);

    final balanceStore = Provider.of<BalanceStore>(context);
    final actionListStore = Provider.of<ActionListStore>(context);
    final syncStore = Provider.of<SyncStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final transactionDateFormat = settingsStore.getCurrentDateFormat(
        formatUSA: 'MMMM d, yyyy, HH:mm', formatDefault: 'd MMMM yyyy, HH:mm');
    print('Called');
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Observer(
          key: _listObserverKey,
          builder: (_) {
            final items = actionListStore.items ?? <String>[];
            final itemsCount = items.length + 2;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        key: _listKey,
                        padding: EdgeInsets.only(bottom: 15),
                        itemCount:2, //itemsCount,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Container(
                             // margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.transparent, //Theme.of(context).backgroundColor,
                                /*boxShadow: [
                                  BoxShadow(
                                      color: Palette.shadowGreyWithOpacity,
                                      blurRadius: 10,
                                      offset: Offset(0, 12))
                                ]*/
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Progress bar
                                  Observer(
                                    key: _syncingObserverKey,
                                    builder: (_) {
                                      final status = syncStore.status;
                                      final statusText = status.title();
                                      final progress = syncStore.status.progress();
                                      final isFailure = status is FailedSyncStatus;
                                       //syncStatus = status.title();                        
                                   
                                      
                                      print('dashboard page status --> $status');
                                      print('dashboard page progress --> $progress');

                                      var descriptionText = '';
                                      print('dashboard page status is SyncingSyncStatus ${status is SyncingSyncStatus}');
                                      if (status is SyncingSyncStatus) {
                                        /*descriptionText = S
                                            .of(context)
                                            .Blocks_remaining(
                                                syncStore.status.toString());*/
                                        descriptionText = '';
                                        print('dashboard page syncStore.status.toString() ${syncStore.status.toString()}');
                                        print('dashboard page descriptionText $descriptionText');
                                      }

                                      if (status is FailedSyncStatus) {
                                        descriptionText = S
                                            .of(context)
                                            .please_try_to_connect_to_another_node;
                                      }

                                      return Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 1.5,
                                              child: LinearProgressIndicator(
                                                backgroundColor: Palette.separator,
                                                valueColor:
                                                    AlwaysStoppedAnimation<Color>(
                                                        BeldexPalette.belgreen//teal
                                                        ),
                                                value: progress,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(statusText.toLowerCase()  ,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: isFailure
                                                        ? BeldexPalette.red
                                                        : BeldexPalette.belgreen //teal
                                                        )),
                                            Text(descriptionText   ,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Theme.of(context).primaryTextTheme.caption.color,//Palette.wildDarkBlue,
                                                    height: 2.0))
                                          ],
                                        ),
                                      );
                                    }),
                                  //Primary Account
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  // Row(
                                  //   // mainAxisAlignment: MainAxisAlignment.center,
                                  //   // crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     // Container(
                                  //     //   width: 23,
                                  //     //   height: 55,
                                  //     //   decoration: BoxDecoration(
                                  //     //       color: Theme.of(context)
                                  //     //           .primaryTextTheme
                                  //     //           .button
                                  //     //           .backgroundColor,
                                  //     //       borderRadius:
                                  //     //           BorderRadius.circular(10)),
                                  //     //   child: Column(
                                  //     //     mainAxisAlignment:
                                  //     //         MainAxisAlignment.spaceEvenly,
                                  //     //     children: [
                                  //     //       Container(
                                  //     //         width: 7,
                                  //     //         height: 7,
                                  //     //         decoration: BoxDecoration(
                                  //     //             color: Colors.white60,
                                  //     //             borderRadius:
                                  //     //                 BorderRadius.circular(10)),
                                  //     //       ),
                                  //     //       Container(
                                  //     //         width: 7,
                                  //     //         height: 7,
                                  //     //         decoration: BoxDecoration(
                                  //     //             color: Colors.white60,
                                  //     //             borderRadius:
                                  //     //                 BorderRadius.circular(10)),
                                  //     //       ),
                                  //     //       Container(
                                  //     //         width: 7,
                                  //     //         height: 7,
                                  //     //         decoration: BoxDecoration(
                                  //     //             color: Colors.white60,
                                  //     //             borderRadius:
                                  //     //                 BorderRadius.circular(10)),
                                  //     //       )
                                  //     //     ],
                                  //     //   ),
                                  //     // ),
                                  //     Card(
                                  //       elevation: 0, //5,
                                  //       color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED), //Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                  //       margin: EdgeInsets.only(left: 15),
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius:
                                  //               BorderRadius.circular(10)),
                                  //       child: Container(
                                  //         color: Colors.transparent,
                                  //         width: MediaQuery.of(context).size.width*2.7/3, //300,
                                  //         padding: EdgeInsets.all(15),
                                  //         child: Column(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.start,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: <Widget>[
                                  //               Text(
                                  //                 walletStore.name,
                                  //                 style: TextStyle(
                                  //                     fontSize: 25,
                                  //                     fontWeight: FontWeight.bold,
                                  //                     color: Theme.of(context)
                                  //                         .primaryTextTheme
                                  //                         .headline6
                                  //                         .color),
                                  //               ),
                                  //               SizedBox(height: 10),
                                  //               Text(
                                  //                 walletStore.account != null
                                  //                     ? '${walletStore.account.label}'
                                  //                     : '',
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.w400,
                                  //                     fontSize: 14,
                                  //                     color: Theme.of(context).hintColor,//Colors.grey //Theme.of(context).primaryTextTheme.headline6.color
                                  //                     ),
                                  //               ),
                                  //             ]),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Row(
                                   // mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Container(
                                      //   width: 23,
                                      //   height: 55,
                                      //   decoration: BoxDecoration(
                                      //       color: Theme.of(context)
                                      //           .accentTextTheme
                                      //           .caption
                                      //           .decorationColor,
                                      //       borderRadius:
                                      //           BorderRadius.circular(10)),
                                      //   child: Column(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceEvenly,
                                      //     children: [
                                      //       Container(
                                      //         width: 7,
                                      //         height: 7,
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.white60,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10)),
                                      //       ),
                                      //       Container(
                                      //         width: 7,
                                      //         height: 7,
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.white60,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10)),
                                      //       ),
                                      //       Container(
                                      //         width: 7,
                                      //         height: 7,
                                      //         decoration: BoxDecoration(
                                      //             color: Colors.white60,
                                      //             borderRadius:
                                      //                 BorderRadius.circular(10)),
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      Card(
                                        elevation: 0,
                                        color:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED),//Color.fromARGB(255, 40, 42, 51),
                                        margin: EdgeInsets.only(left: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: GestureDetector(
                                          onTapUp: (_) =>
                                              balanceStore.isReversing = false,
                                          onTapDown: (_) =>
                                              balanceStore.isReversing = true,
                                          child: Container(
                                            color: Colors.transparent,
                                            width:MediaQuery.of(context).size.width*2.7/3, //300,
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Observer(
                                                        key:
                                                            _connectionStatusObserverKey,
                                                        builder: (_) {
                                                          final savedDisplayMode =
                                                              settingsStore
                                                                  .balanceDisplayMode;
                                                          var balance = '---';
                                                          final displayMode = balanceStore
                                                                  .isReversing
                                                              ? (savedDisplayMode ==
                                                                      BalanceDisplayMode
                                                                          .availableBalance
                                                                  ? BalanceDisplayMode
                                                                      .fullBalance
                                                                  : BalanceDisplayMode
                                                                      .availableBalance)
                                                              : savedDisplayMode;

                                                          if (displayMode ==
                                                              BalanceDisplayMode
                                                                  .availableBalance) {
                                                            balance = balanceStore
                                                                    .unlockedBalanceString ??
                                                                '00.000000000';
                                                            print('Dashboard availableBalance --> $balance');
                                                          }
                            
                                                          if (displayMode ==
                                                              BalanceDisplayMode
                                                                  .fullBalance) {
                                                            balance = balanceStore
                                                                    .fullBalanceString ??
                                                                '00.000000000';
                                                            print('Dashboard fullBalance --> $balance');
                                                          }

                                                          return Row(
                                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                                            textBaseline: TextBaseline.alphabetic,
                                                            children: [
                                                              Text(
                                                               '$balance ',
                                                                style: TextStyle(
                                                                  color: Theme.of(context)
                                                                      .primaryTextTheme
                                                                      .caption
                                                                      .color,
                                                                  fontSize: 23,
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                ),
                                                              ),
                                                              Text('BDX', style: TextStyle(
                                                                  color: Theme.of(context)
                                                                      .primaryTextTheme
                                                                      .caption
                                                                      .color,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight.w600,
                                                                ),),
                                                                //SizedBox(width:40),
                                                                // Container(
                                                                //   child:SvgPicture.asset('assets/images/new-images/scanners.svg')
                                                                // )
                                                            ],
                                                          
                                                          );
                                                        }),
                                                    //  GestureDetector(
                                                    //   onTap: () async => _presentQRScanner(context),
                                                    //    child: Container(
                                                    //                 child:SvgPicture.asset('assets/images/new-images/scanners.svg',color: settingsStore.isDarkTheme? Color(0xffFFFFFF): Color(0xff16161D),)
                                                    //               ),
                                                    //  )
                                                  ],
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 7),
                                                    child: Observer(
                                                        key: _balanceObserverKey,
                                                        builder: (_) {
                                                          final savedDisplayMode =
                                                              settingsStore
                                                                  .balanceDisplayMode;
                                                          final displayMode = settingsStore.enableFiatCurrency
                                                              ? (balanceStore.isReversing
                                                                  ? (savedDisplayMode == BalanceDisplayMode.availableBalance
                                                                      ? BalanceDisplayMode.fullBalance
                                                                      : BalanceDisplayMode.availableBalance)
                                                                  : savedDisplayMode)
                                                              : BalanceDisplayMode.hiddenBalance;
                                                          final symbol =
                                                              settingsStore
                                                                  .fiatCurrency
                                                                  .toString();
                                                          var balance = '---';

                                                          if (displayMode == BalanceDisplayMode.availableBalance) {
                                                            balance = '${balanceStore.fiatUnlockedBalance} $symbol';
                                                          }

                                                          if (displayMode == BalanceDisplayMode.fullBalance) {
                                                            balance ='${balanceStore.fiatFullBalance} $symbol';
                                                          }

                                                          return Text(balance,
                                                              style: TextStyle(
                                                                  color:Color(0xff0BA70F), //Theme.of(context).hintColor,//Colors.grey,
                                                                  //Palette.wildDarkBlue,
                                                                  fontSize: 14));
                                                        })),
                                                       
                                                        Padding(
                                                          padding:  EdgeInsets.only(top:30.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Observer(
                                                                key: _sendbuttonEnableKey,
                                                                builder: (_){
                                                                    final status = syncStore.status;
                                                                 syncStatus = status.title();
                                                               return  GestureDetector(
                                                                onTap: syncStatus == 'SYNCHRONIZED' ? (){
                                                                   Navigator.of(context,
                                                                 rootNavigator: true).pushNamed(Routes.send);
                                                                }: null,
                                                                child: Container(
                                                                  width:142,
                                                                  height:46,
                                                                  decoration: BoxDecoration(
                                                                     borderRadius: BorderRadius.circular(8),
                                                                    color:syncStatus == 'SYNCHRONIZED' ? Color(0xff0BA70F): settingsStore.isDarkTheme ? Color(0xff333343): Color(0xffE8E8E8),

                                                                  ),
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Container( 
                                                                        height:20,width:20,
                                                                        child: SvgPicture.asset('assets/images/new-images/send.svg',color: syncStatus == 'SYNCHRONIZED' ? Colors.white: settingsStore.isDarkTheme ? Color(0xff6C6C78): Color(0xffB2B2B6),)),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left:8.0),
                                                                        child: Text(S.of(context).send,
                                                                         style: TextStyle(
                                                                          color:syncStatus == 'SYNCHRONIZED' ? Colors.white: settingsStore.isDarkTheme ? Color(0xff6C6C78): Color(0xffB2B2B6),
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: 16),
                                                                        ),
                                                                      )

                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                              },),
                                                             
                                                               GestureDetector(
                                                                 onTap: () {
                                                      Navigator.of(context,
                                                    rootNavigator: true).pushNamed(Routes.receive);
                                                              },
                                                                 child: Container(
                                                                  width:142,
                                                                  height:46,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                    color:Color(0xff2979FB),
                                                              
                                                                  ),
                                                                  child: Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Container( 
                                                                          height:20,width:20,
                                                                          child: SvgPicture.asset('assets/images/new-images/receive.svg')),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(left:8.0),
                                                                          child: Text(S.of(context).receive,
                                                                           style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16),
                                                                          ),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                 ),
                                                               ),
                                                            ],
                                                          ),
                                                        )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  /*GestureDetector(
                                  onTapUp: (_) => balanceStore.isReversing = false,
                                  onTapDown: (_) => balanceStore.isReversing = true,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 40, bottom: 40),
                                    color: Colors.transparent,
                                    child: Column(
                                      children: <Widget>[
                                        Container(width: double.infinity),
                                        //Beldex Available Balance
                                        Observer(
                                            key: _balanceTitleObserverKey,
                                            builder: (_) {
                                              final savedDisplayMode =
                                                  settingsStore.balanceDisplayMode;
                                              final displayMode = balanceStore
                                                  .isReversing
                                                  ? (savedDisplayMode ==
                                                  BalanceDisplayMode
                                                      .availableBalance
                                                  ? BalanceDisplayMode.fullBalance
                                                  : BalanceDisplayMode
                                                  .availableBalance)
                                                  : savedDisplayMode;

                                              return Text(displayMode.toString(),
                                                  style: TextStyle(
                                                      color: BeldexPalette.teal,
                                                      fontSize: 16));
                                            }),
                                        Observer(
                                            key: _connectionStatusObserverKey,
                                            builder: (_) {
                                              final savedDisplayMode =
                                                  settingsStore.balanceDisplayMode;
                                              var balance = '---';
                                              final displayMode = balanceStore
                                                  .isReversing
                                                  ? (savedDisplayMode ==
                                                  BalanceDisplayMode
                                                      .availableBalance
                                                  ? BalanceDisplayMode.fullBalance
                                                  : BalanceDisplayMode
                                                  .availableBalance)
                                                  : savedDisplayMode;

                                              if (displayMode ==
                                                  BalanceDisplayMode.availableBalance) {
                                                balance = balanceStore
                                                    .unlockedBalanceString ??
                                                    '0.0';
                                              }

                                              if (displayMode ==
                                                  BalanceDisplayMode.fullBalance) {
                                                balance =
                                                    balanceStore.fullBalanceString ??
                                                        '0.0';
                                              }

                                              return Text(
                                                balance,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryTextTheme
                                                        .caption
                                                        .color,
                                                    fontSize: 42),
                                              );
                                            }),
                                        Padding(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Observer(
                                                key: _balanceObserverKey,
                                                builder: (_) {
                                                  final savedDisplayMode =
                                                      settingsStore.balanceDisplayMode;
                                                  final displayMode = settingsStore
                                                      .enableFiatCurrency
                                                      ? (balanceStore.isReversing
                                                      ? (savedDisplayMode ==
                                                      BalanceDisplayMode
                                                          .availableBalance
                                                      ? BalanceDisplayMode
                                                      .fullBalance
                                                      : BalanceDisplayMode
                                                      .availableBalance)
                                                      : savedDisplayMode)
                                                      : BalanceDisplayMode
                                                      .hiddenBalance;
                                                  final symbol = settingsStore
                                                      .fiatCurrency
                                                      .toString();
                                                  var balance = '---';

                                                  if (displayMode ==
                                                      BalanceDisplayMode
                                                          .availableBalance) {
                                                    balance =
                                                    '${balanceStore.fiatUnlockedBalance} $symbol';
                                                  }

                                                  if (displayMode ==
                                                      BalanceDisplayMode.fullBalance) {
                                                    balance =
                                                    '${balanceStore.fiatFullBalance} $symbol';
                                                  }

                                                  return Text(balance,
                                                      style: TextStyle(
                                                          color: Palette.wildDarkBlue,
                                                          fontSize: 16));
                                                }))
                                      ],
                                    ),
                                  ),
                                ),*/
                                  /*Observer(
                                    key: _syncingObserverKey,
                                    builder: (_) {
                                      final status = syncStore.status;
                                      final statusText = status.title();
                                      final progress = syncStore.status.progress();
                                      final isFailure = status is FailedSyncStatus;

                                      var descriptionText = '';

                                      if (status is SyncingSyncStatus) {
                                        descriptionText = S
                                            .of(context)
                                            .Blocks_remaining(
                                                syncStore.status.toString());
                                      }

                                      if (status is FailedSyncStatus) {
                                        descriptionText = S
                                            .of(context)
                                            .please_try_to_connect_to_another_node;
                                      }

                                      return Container(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 3,
                                              child: LinearProgressIndicator(
                                                backgroundColor: Palette.separator,
                                                valueColor:
                                                    AlwaysStoppedAnimation<Color>(
                                                        BeldexPalette.teal),
                                                value: progress,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(statusText,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: isFailure
                                                        ? BeldexPalette.red
                                                        : BeldexPalette.teal)),
                                            Text(descriptionText,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Palette.wildDarkBlue,
                                                    height: 2.0))
                                          ],
                                        ),
                                      );
                                    }),*/
                                  /*GestureDetector(
                                  onTapUp: (_) => balanceStore.isReversing = false,
                                  onTapDown: (_) => balanceStore.isReversing = true,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 40, bottom: 40),
                                    color: Colors.transparent,
                                    child: Column(
                                      children: <Widget>[
                                        Container(width: double.infinity),
                                        //Beldex Available Balance
                                        Observer(
                                            key: _balanceTitleObserverKey,
                                            builder: (_) {
                                              final savedDisplayMode =
                                                  settingsStore.balanceDisplayMode;
                                              final displayMode = balanceStore
                                                      .isReversing
                                                  ? (savedDisplayMode ==
                                                          BalanceDisplayMode
                                                              .availableBalance
                                                      ? BalanceDisplayMode.fullBalance
                                                      : BalanceDisplayMode
                                                          .availableBalance)
                                                  : savedDisplayMode;

                                              return Text(displayMode.toString(),
                                                  style: TextStyle(
                                                      color: BeldexPalette.teal,
                                                      fontSize: 16));
                                            }),
                                        Observer(
                                            key: _connectionStatusObserverKey,
                                            builder: (_) {
                                              final savedDisplayMode =
                                                  settingsStore.balanceDisplayMode;
                                              var balance = '---';
                                              final displayMode = balanceStore
                                                      .isReversing
                                                  ? (savedDisplayMode ==
                                                          BalanceDisplayMode
                                                              .availableBalance
                                                      ? BalanceDisplayMode.fullBalance
                                                      : BalanceDisplayMode
                                                          .availableBalance)
                                                  : savedDisplayMode;

                                              if (displayMode ==
                                                  BalanceDisplayMode.availableBalance) {
                                                balance = balanceStore
                                                        .unlockedBalanceString ??
                                                    '0.0';
                                              }

                                              if (displayMode ==
                                                  BalanceDisplayMode.fullBalance) {
                                                balance =
                                                    balanceStore.fullBalanceString ??
                                                        '0.0';
                                              }

                                              return Text(
                                                balance,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryTextTheme
                                                        .caption
                                                        .color,
                                                    fontSize: 42),
                                              );
                                            }),
                                        Padding(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Observer(
                                                key: _balanceObserverKey,
                                                builder: (_) {
                                                  final savedDisplayMode =
                                                      settingsStore.balanceDisplayMode;
                                                  final displayMode = settingsStore
                                                          .enableFiatCurrency
                                                      ? (balanceStore.isReversing
                                                          ? (savedDisplayMode ==
                                                                  BalanceDisplayMode
                                                                      .availableBalance
                                                              ? BalanceDisplayMode
                                                                  .fullBalance
                                                              : BalanceDisplayMode
                                                                  .availableBalance)
                                                          : savedDisplayMode)
                                                      : BalanceDisplayMode
                                                          .hiddenBalance;
                                                  final symbol = settingsStore
                                                      .fiatCurrency
                                                      .toString();
                                                  var balance = '---';

                                                  if (displayMode ==
                                                      BalanceDisplayMode
                                                          .availableBalance) {
                                                    balance =
                                                        '${balanceStore.fiatUnlockedBalance} $symbol';
                                                  }

                                                  if (displayMode ==
                                                      BalanceDisplayMode.fullBalance) {
                                                    balance =
                                                        '${balanceStore.fiatFullBalance} $symbol';
                                                  }

                                                  return Text(balance,
                                                      style: TextStyle(
                                                          color: Palette.wildDarkBlue,
                                                          fontSize: 16));
                                                }))
                                      ],
                                    ),
                                  ),
                                ),*/
                                
                                
                                  // Container(
                                  //   margin: EdgeInsets.only(
                                  //       left: 10, right: 10, top: 50.0),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     children: <Widget>[
                                  //       InkWell(
                                  //         onTap: () {
                                  //           Navigator.of(context,
                                  //                   rootNavigator: true)
                                  //               .pushNamed(Routes.send);
                                  //         },
                                  //         child: Container(
                                  //           width: 160,
                                  //           height: 50,
                                  //           decoration: BoxDecoration(
                                  //             color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //             boxShadow: [
                                  //               BoxShadow(
                                  //                 color: Colors.black38,
                                  //                 offset: Offset(2, 2),
                                  //                 blurRadius: 1,
                                  //               )
                                  //             ],
                                  //           ),
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceEvenly,
                                  //             children: <Widget>[
                                  //               SvgPicture.asset(
                                  //                 'assets/images/send_svg.svg',
                                  //                 width: 25,
                                  //                 height: 25,
                                  //                 color: Colors.red,
                                  //               ),
                                  //               Text(
                                  //                 S.of(context).send,
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.bold,
                                  //                     fontSize: 16),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {
                                  //           Navigator.of(context,
                                  //                   rootNavigator: true)
                                  //               .pushNamed(Routes.receive);
                                  //         },
                                  //         child: Container(
                                  //           width: 160,
                                  //           height: 50,
                                  //           decoration: BoxDecoration(
                                  //             color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                  //             borderRadius:
                                  //                 BorderRadius.circular(10),
                                  //             boxShadow: [
                                  //               BoxShadow(
                                  //                 color: Colors.black38,
                                  //                 offset: Offset(2, 2),
                                  //                 blurRadius: 1,
                                  //               )
                                  //             ],
                                  //           ),
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.spaceEvenly,
                                  //             children: <Widget>[
                                  //               SvgPicture.asset(
                                  //                 'assets/images/receive_svg.svg',
                                  //                 width: 25,
                                  //                 height: 25,
                                  //                 color: Colors.green,
                                  //               ),
                                  //               Text(
                                  //                 S.of(context).receive,
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.bold,
                                  //                     fontSize: 16),
                                  //               )
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          }



                        return Container(
                          height: MediaQuery.of(context).size.height*1.25/3,
                          margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color:settingsStore.isDarkTheme ? Color(0xff24242F) : Color(0xffEDEDED),
                              borderRadius: BorderRadius.circular(10)
                            ), 
                         child:Observer(
                           
                          builder: (_){
                             final status = syncStore.status;
                            final syncStat = status.title();
                             return  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:10.0),
                                child: Text('Flash Transaction',style: TextStyle(fontSize:23,fontWeight:FontWeight.w800),),
                              ),
                                GestureDetector(
                                  onTap:syncStat == 'SYNCHRONIZED' ? (){
                                      //scannerAction();
                                      _presentQRScanner(context);
                                  }:null,
                                  child: Container(
                                    height:MediaQuery.of(context).size.height*0.60/3,
                                    width:MediaQuery.of(context).size.height*0.60/3,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(color: settingsStore.isDarkTheme ? Color(0xffD9D9D9) : Color(0xffE2E2E2),
                                    borderRadius: BorderRadius.circular(10),

                                    ),
                                    child:Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset('assets/images/new-images/flashqr.svg',color: syncStat == 'SYNCHRONIZED' ? Color(0xff222222): Color(0xffD9D9D9),)
                                    ),
                                  ),
                                ),
                                 Padding(
                                   padding: const EdgeInsets.only(bottom:10.0),
                                   child: Text('Transafer your BDX more faster\n with flash transaction',textAlign:TextAlign.center ,style:TextStyle(fontSize:16)),
                                 )
                            ],
                           );
                          },
                           
                         )
                        );






                          // if (index == 1 && actionListStore.totalCount > 0) {
                          //   return Container(
                          //     margin: EdgeInsets.only(left:15,right:0,bottom: 15.0),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //       //color: Colors.yellow,
                          //     ),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         // SizedBox(
                          //         //   height: 5,
                          //         // ),
                          //         // Divider(
                          //         //   height: 10,
                          //         // ),
                          //         Padding(
                          //           padding:
                          //               EdgeInsets.only(right: 20, top: 10),
                          //           child: Row(
                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: <Widget>[
                          //                 Text(
                          //                   S.of(context).transactions_text,
                          //                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
                          //                 ),
                          //                 Theme(
                          //                   data: Theme.of(context).copyWith(
                          //                       accentColor: Colors.green,
                          //                       primaryColor: Colors.blue,
                                                
                          //                       backgroundColor: settingsStore.isDarkTheme ? Color(0xff292935):Color(0xffffffff)),
                          //                   child: Builder(
                          //                     builder: (context) => PopupMenuButton<int>(
                          //                       itemBuilder: (context) => [
                          //                         PopupMenuItem(
                          //                             enabled: false,
                          //                             value: -1,
                          //                             child: Text('Filter by',// S.of(context).transactions,
                          //                                 style: TextStyle(
                          //                                     fontWeight: FontWeight.bold,
                          //                                     color: Theme.of(context)
                          //                                         .primaryTextTheme
                          //                                         .caption
                          //                                         .color))),
                          //                         PopupMenuItem(
                          //                             value: 0,
                          //                             child: Observer(
                          //                                 builder: (_) => Row(
                          //                                     mainAxisAlignment:
                          //                                     MainAxisAlignment
                          //                                         .spaceBetween,
                          //                                     children: [
                          //                                       Text(S
                          //                                           .of(context)
                          //                                           .incoming),
                          //                                       Theme(
                          //                                         data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                          //                                         child: Checkbox(
                          //                                           value: actionListStore
                          //                                               .transactionFilterStore
                          //                                               .displayIncoming,
                          //                                           onChanged: (value) =>
                          //                                               actionListStore
                          //                                                   .transactionFilterStore
                          //                                                   .toggleIncoming(),
                          //                                         ),
                          //                                       )
                          //                                     ]))),
                          //                         PopupMenuItem(
                          //                             value: 1,
                          //                             child: Observer(
                          //                                 builder: (_) => Row(
                          //                                     mainAxisAlignment:
                          //                                     MainAxisAlignment
                          //                                         .spaceBetween,
                          //                                     children: [
                          //                                       Text(S
                          //                                           .of(context)
                          //                                           .outgoing),
                          //                                       Theme(
                          //                                         data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                          //                                         child: Checkbox(
                          //                                           value: actionListStore
                          //                                               .transactionFilterStore
                          //                                               .displayOutgoing,
                          //                                           onChanged: (value) =>
                          //                                               actionListStore
                          //                                                   .transactionFilterStore
                          //                                                   .toggleOutgoing(),
                          //                                         ),
                          //                                       )
                          //                                     ]))),
                          //                         PopupMenuItem(
                          //                             value: 2,
                          //                             child: Text(S
                          //                                 .of(context)
                          //                                 .transactions_by_date)),
                          //                       ],
                          //                       onSelected: (item) async {
                          //                         print('item length --> $item');
                          //                         if (item == 2) {
                          //                           final picked =
                          //                           await date_rage_picker.showDatePicker(
                          //                             context: context,
                          //                             initialFirstDate: DateTime.now()
                          //                                 .subtract(Duration(days: 1)),
                          //                             initialLastDate: (DateTime.now()),
                          //                             firstDate: DateTime(2015),
                          //                             lastDate: DateTime.now()
                          //                                 .add(Duration(days: 1)),);

                          //                           print('picked length --> ${picked.length}');

                          //                           if (picked != null &&
                          //                               picked.length == 2) {
                          //                             actionListStore.transactionFilterStore
                          //                                 .changeStartDate(picked.first);
                          //                             actionListStore.transactionFilterStore
                          //                                 .changeEndDate(picked.last);
                          //                           }
                          //                         }
                          //                       },
                          //                       child: SvgPicture.asset('assets/images/new-images/filter.svg',width:18,height:18,color: Theme.of(context).primaryTextTheme.caption.color,)/*Text(S.of(context).filters,
                          //                           style: TextStyle(
                          //                               fontSize: 16.0,
                          //                               color: Theme.of(context)
                          //                                   .primaryTextTheme
                          //                                   .subtitle2
                          //                                   .color))*/,
                          //                     )
                          //                   ),
                          //                 )

                          //               ]),
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }

                      //     index -= 2;

                      //     if (index < 0 || index >= items.length) {
                      //        return  Container(
                      //   height:MediaQuery.of(context).size.height*1.38/3,
                      //   margin: EdgeInsets.only(top:8.0,bottom:10.0,right:15.0,left:15.0),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //   color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffEDEDED), //Color(0xff24242F),
                      //   ),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //      children: [
                      //       settingsStore.isDarkTheme ?
                      //       SvgPicture.asset('assets/images/new-images/notrans_black.svg'):
                      //       SvgPicture.asset('assets/images/new-images/notrans_white.svg'),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                      //         child: Text(S.of(context).no_trans_yet,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16.0),),
                      //       ),
                      //       Text('After your first transaction,\n you will be able to view it here.',textAlign: TextAlign.center,style: TextStyle(color:Color(0xff82828D)),),
                      //      ],
                      //     ),
                      // );
                           
                      //     }

                      //     final item = items[index];
                        

                      //     if (item is DateSectionItem) {
                      //       return DateSectionRow(date: item.date,index: index,);
                      //     }

                      //     if (item is TransactionListItem) {
                      //       final transaction = item.transaction;
                      //       final savedDisplayMode =
                      //           settingsStore.balanceDisplayMode;
                      //       final formattedAmount =
                      //           savedDisplayMode == BalanceDisplayMode.hiddenBalance
                      //               ? '---'
                      //               : transaction.amountFormatted();
                      //       final formattedFiatAmount =
                      //           savedDisplayMode == BalanceDisplayMode.hiddenBalance
                      //               ? '---'
                      //               : transaction.fiatAmount();

                      //       return TransactionRow(
                      //           onTap: () => Navigator.of(context).pushNamed(
                      //               Routes.transactionDetails,
                      //               arguments: transaction),
                      //           direction: transaction.direction,
                      //           formattedDate:
                      //               transactionDateFormat.format(transaction.date),
                      //           formattedAmount: formattedAmount,
                      //           formattedFiatAmount: formattedFiatAmount,
                      //           isPending: transaction.isPending,
                      //           transaction: transaction,
                      //           //isStake: transaction.isStake,
                      //           );
                      //     }

                         // return Container();
                        }),
                  ),
                ),
             
              Container(
                height:MediaQuery.of(context).size.height*0.35/3,
                width:double.infinity,
                decoration: BoxDecoration(   
                  color: settingsStore.isDarkTheme ? Color(0xff24242F) : Color(0xffEDEDED)
                ),
                padding: EdgeInsets.all(15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: ()=> Navigator.of(context).pushNamed(Routes.addressBook),
                      child: Container(
                        width:MediaQuery.of(context).size.width*1.30/3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffD4D4D4)
                        ),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/new-images/Address.svg',color: settingsStore.isDarkTheme? Colors.white:Colors.black,),
                            Padding(
                              padding: const EdgeInsets.only(left:5.0),
                              child: Text(S.of(context).address_book,style: TextStyle( fontWeight: FontWeight.bold,
                                                                              fontSize: 16)),
                            )
                          ],
                        )
                      ),
                    ),
                    // Container(
                    //   width:MediaQuery.of(context).size.width*1.30/3,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffD4D4D4)
                    //   ),
                    //   padding: EdgeInsets.all(15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SvgPicture.asset('assets/images/new-images/Address.svg'),
                    //       Padding(
                    //         padding: EdgeInsets.only(left:8.0),
                    //         child: Text(S.of(context).address_book,style: TextStyle( fontWeight: FontWeight.bold,
                    //                                                       fontSize: 16),),
                    //       )
                    //     ],
                    //   )
                    // ),
                     GestureDetector(
                      onTap: (){
                       Navigator.of(context).pushNamed(Routes.transactionlist);
                      },
                       child: Container(
                        width:MediaQuery.of(context).size.width*1.30/3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff0BA70F)
                        ),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           SvgPicture.asset('assets/images/new-images/transactions.svg'),
                            Padding(
                              padding: const EdgeInsets.only(left:5.0),
                              child: Text(S.of(context).transactions,style: TextStyle( fontWeight: FontWeight.bold,
                                                                         color:Colors.white,fontSize: 16)),
                            ),
                          ],















                          
                        )
                    ),
                     )
                  ],
                )
              )
             
             
             
             
              ],
            );
          }),
    );
  }

















  Future<bool> onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final settingsStore = Provider.of<SettingsStore>(context);
          return Dialog(
            elevation: 0,
            backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffffffff), //Theme.of(context).cardTheme.color,//Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).are_you_sure,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      S.of(context).do_you_want_to_exit_an_app,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffDADADA) //Theme.of(context).cardTheme.shadowColor,
                                //Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).primaryTextTheme.caption.color,),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor:Color(0xff0BA70F),// Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle
                                (fontWeight: FontWeight.w800,
                                  color: Colors.white,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Item {
  Item({this.id, this.icon, this.text, this.amount, this.color});

  String id;
  IconData icon;
  String text;
  String amount;
  Color color;
}









Future showMenuForRescan(BuildContext context, String title, String body,String fee,String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => ShowMenuForRescan(title, body,fee,address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}




class ShowMenuForRescan extends StatelessWidget {
  const ShowMenuForRescan(this.title, this.body, this.fee,this.address,
      {this.buttonText, this.onPressed, this.onDismiss,});// : super(key: key);

      final String title;
  final String body;
  final String fee;
  final String address;
  final String buttonText;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  Widget build(BuildContext context) {
      final settingsStore = Provider.of<SettingsStore>(context);
   return  GestureDetector(
     // onTap: () => _onDismiss(context),
      child: Container(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.all(15),
           // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme ? Color(0xff272733) : Colors.white, //Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: MediaQuery.of(context).size.height*1.4/3,
                      padding: EdgeInsets.only(top: 15.0,left:20,right: 20),
                      child: Column(
                        children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom:10.0),
                               child: Text(title,style:TextStyle(fontSize:18,fontWeight: FontWeight.w800)),
                             ),
                             Container(
                              height:50,
                              //padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED)
                              ),
                              child:Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Amount',style: TextStyle(fontSize:16,fontWeight:FontWeight.w700),),
                                  ),
                                  VerticalDivider(

                                  ),
                                  Expanded(child: Container(
                                     padding: const EdgeInsets.all(10.0),
                                    child: Text('body',style: TextStyle(fontSize:18,fontWeight:FontWeight.bold,fontFamily: 'Poppinsbold'),),
                                  )),
                                  Container(
                                    width:70,
                                    padding: EdgeInsets.all(10),
                                    child: Container(  
                                      height:40,width:40,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(  
                                        color: Color(0xff00B116),
                                        shape: BoxShape.circle,
                                      ),
                                      child:SvgPicture.asset('assets/images/new-images/beldex.svg')
                                    ),
                                  )
                                ],
                              )
                             ),
                             Container(
                              margin:EdgeInsets.only(top:10),
                              padding: EdgeInsets.all(10),
                              height:MediaQuery.of(context).size.height*0.60/3,
                              decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Address'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(  
                                      color:settingsStore.isDarkTheme ? Color(0xff47475E): Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(address)),
                                    Text('Fee: fee'),

                                ],
                              )
                             ),
                             Container(
                              margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.10/3),
                               child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:settingsStore.isDarkTheme ? Color(0xff383848) :Color(0xffEDEDED),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                         if (onDismiss!= null) onDismiss(context);
                                      },
                                      child: Center(child:Text('Cancel',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800)))),
                                  ),
                                  SizedBox(width:20 ),
                                  Container(
                                    height:45,width:120,
                                    decoration: BoxDecoration(
                                      color:Color(0xff0BA70F),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: GestureDetector(
                                       onTap: (){
                                    if (onPressed != null) onPressed(context);
                                  },
                                      child: Center(child:Text('OK',style: TextStyle(fontSize:15,fontWeight: FontWeight.w800,color: Colors.white),))),
                                  )
                               ],),
                             )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

