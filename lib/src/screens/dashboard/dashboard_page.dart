import 'package:beldex_wallet/src/node/sync_status.dart';
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
          padding: EdgeInsets.only(top: 12.0,),
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(10),
              //color: Colors.black,
              ),
          child: Icon(Icons.autorenew_outlined,color: Theme.of(context).primaryTextTheme.caption.color,)),
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

    return Image.asset('assets/images/title_with_logo.png', height: 134, width: 160); /*Observer(builder: (_) {
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
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).accentTextTheme.headline6.color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentTextTheme.headline6.color,
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
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
              child: SvgPicture.asset(
                'assets/images/profile_icon_svg.svg',
                fit: BoxFit.cover,
                color: Colors.white,
                width: 30,
                height: 30,
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
            return Stack(
              children: [
                ListView.builder(
                    key: _listKey,
                    padding: EdgeInsets.only(bottom: 15),
                    itemCount: itemsCount,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 23,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .button
                                            .backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Card(
                                    elevation: 5,
                                    color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                    margin: EdgeInsets.only(left: 15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      color: Colors.transparent,
                                      width: 300,
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
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
                                            SizedBox(height: 10),
                                            Text(
                                              walletStore.account != null
                                                  ? '${walletStore.account.label}'
                                                  : '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Theme.of(context).hintColor,//Colors.grey //Theme.of(context).primaryTextTheme.headline6.color
                                                  ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 23,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .caption
                                            .decorationColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Card(
                                    elevation: 5,
                                    color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
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
                                        width: 300,
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
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

                                                  return Text(
                                                    balance,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryTextTheme
                                                          .caption
                                                          .color,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                }),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 7),
                                                child: Observer(
                                                    key: _balanceObserverKey,
                                                    builder: (_) {
                                                      final savedDisplayMode =
                                                          settingsStore
                                                              .balanceDisplayMode;
                                                      final displayMode = settingsStore
                                                              .enableFiatCurrency
                                                          ? (balanceStore
                                                                  .isReversing
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
                                                      final symbol =
                                                          settingsStore
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
                                                          BalanceDisplayMode
                                                              .fullBalance) {
                                                        balance =
                                                            '${balanceStore.fiatFullBalance} $symbol';
                                                      }

                                                      return Text(balance,
                                                          style: TextStyle(
                                                              color: Theme.of(context).hintColor,//Colors.grey,
                                                              //Palette.wildDarkBlue,
                                                              fontSize: 14));
                                                    }))
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
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 50.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(Routes.send);
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(2, 2),
                                              blurRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/images/send_svg.svg',
                                              width: 25,
                                              height: 25,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              S.of(context).send,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(Routes.receive);
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(2, 2),
                                              blurRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/images/receive_svg.svg',
                                              width: 25,
                                              height: 25,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              S.of(context).receive,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (index == 1 && actionListStore.totalCount > 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: 20, top: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                          accentColor: Colors.green,
                                          primaryColor: Colors.blue,),
                                      child: Builder(
                                        builder: (context) => PopupMenuButton<int>(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                                enabled: false,
                                                value: -1,
                                                child: Text(S.of(context).transactions,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryTextTheme
                                                            .caption
                                                            .color))),
                                            PopupMenuItem(
                                                value: 0,
                                                child: Observer(
                                                    builder: (_) => Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(S
                                                              .of(context)
                                                              .incoming),
                                                          Theme(
                                                            data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                                                            child: Checkbox(
                                                              value: actionListStore
                                                                  .transactionFilterStore
                                                                  .displayIncoming,
                                                              onChanged: (value) =>
                                                                  actionListStore
                                                                      .transactionFilterStore
                                                                      .toggleIncoming(),
                                                            ),
                                                          )
                                                        ]))),
                                            PopupMenuItem(
                                                value: 1,
                                                child: Observer(
                                                    builder: (_) => Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(S
                                                              .of(context)
                                                              .outgoing),
                                                          Theme(
                                                            data: Theme.of(context).copyWith(accentColor: Colors.green,checkboxTheme: CheckboxThemeData(fillColor:MaterialStateProperty.all(Colors.green),checkColor: MaterialStateProperty.all(Colors.white),)),
                                                            child: Checkbox(
                                                              value: actionListStore
                                                                  .transactionFilterStore
                                                                  .displayOutgoing,
                                                              onChanged: (value) =>
                                                                  actionListStore
                                                                      .transactionFilterStore
                                                                      .toggleOutgoing(),
                                                            ),
                                                          )
                                                        ]))),
                                            PopupMenuItem(
                                                value: 2,
                                                child: Text(S
                                                    .of(context)
                                                    .transactions_by_date)),
                                          ],
                                          onSelected: (item) async {
                                            print('item length --> $item');
                                            if (item == 2) {
                                              final picked =
                                              await date_rage_picker.showDatePicker(
                                                context: context,
                                                initialFirstDate: DateTime.now()
                                                    .subtract(Duration(days: 1)),
                                                initialLastDate: (DateTime.now()),
                                                firstDate: DateTime(2015),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 1)),);

                                              print('picked length --> ${picked.length}');

                                              if (picked != null &&
                                                  picked.length == 2) {
                                                actionListStore.transactionFilterStore
                                                    .changeStartDate(picked.first);
                                                actionListStore.transactionFilterStore
                                                    .changeEndDate(picked.last);
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset('assets/images/filter.svg',width:18,height:18,color: Theme.of(context).primaryTextTheme.caption.color,)/*Text(S.of(context).filters,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      .primaryTextTheme
                                                      .subtitle2
                                                      .color))*/,
                                        )
                                      ),
                                    )

                                  ]),
                            ),
                          ],
                        );
                      }

                      index -= 2;

                      if (index < 0 || index >= items.length) {
                        return Column(
                          children: [
                            SizedBox(height: 50,),
                            Text('No transactions yet',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                            SizedBox(height: 25,),
                            Text('After you first transaction, you will\nbe able to view it here.',textAlign: TextAlign.center,),
                            SizedBox(height: 40,),
                            SvgPicture.asset('assets/images/no_transaction.svg')
                          ],
                        );
                      }

                      final item = items[index];

                      if (item is DateSectionItem) {
                        return DateSectionRow(date: item.date);
                      }

                      if (item is TransactionListItem) {
                        final transaction = item.transaction;
                        final savedDisplayMode =
                            settingsStore.balanceDisplayMode;
                        final formattedAmount =
                            savedDisplayMode == BalanceDisplayMode.hiddenBalance
                                ? '---'
                                : transaction.amountFormatted();
                        final formattedFiatAmount =
                            savedDisplayMode == BalanceDisplayMode.hiddenBalance
                                ? '---'
                                : transaction.fiatAmount();

                        return TransactionRow(
                            onTap: () => Navigator.of(context).pushNamed(
                                Routes.transactionDetails,
                                arguments: transaction),
                            direction: transaction.direction,
                            formattedDate:
                                transactionDateFormat.format(transaction.date),
                            formattedAmount: formattedAmount,
                            formattedFiatAmount: formattedFiatAmount,
                            isPending: transaction.isPending);
                      }

                      return Container();
                    }),
               /* SizedBox.expand(
                  child: DraggableScrollableSheet(
                    minChildSize: 0.43,
                    initialChildSize: 0.43,
                    maxChildSize: 0.98,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 40, 42, 51),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Column(
                          children: [
                            Container(
                              width: 90,
                              height: 7,
                              margin: EdgeInsets.only(top: 25, bottom: 15),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 23, 23, 26),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            Text(
                              'Transactions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            *//*Container(
                              margin: EdgeInsets.only(left: 65,right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Transactions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: SvgPicture.asset('assets/images/filter_svg.svg',color: Colors.white,),
                                  ),
                                ],
                              ),
                            ),*//*
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  *//*   Text(
                                    'Transactions',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),*//*
                                  InkWell(
                                    onTap: () {
                                      if (iconDataVal ==
                                          Icons.arrow_downward_outlined) {
                                        transactions.sort(
                                            (a, b) => b.text.compareTo(a.text));
                                        //transactions.reversed;
                                        setState(() {
                                          iconDataVal =
                                              Icons.arrow_upward_outlined;
                                        });
                                      } else {
                                        transactions.sort(
                                            (a, b) => a.text.compareTo(b.text));
                                        setState(() {
                                          iconDataVal =
                                              Icons.arrow_downward_outlined;
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Icon(iconDataVal),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      transactions = [
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
                                      transactions.removeWhere(
                                          (item) => item.id == 'receive');
                                      //transactions.where((item) => item.id.contains('send'));
                                      //transactions.sort((a, b) => a.id.compareTo(Colors.red));
                                      print(transactions);
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: SvgPicture.asset(
                                        'assets/images/send_icon_svg.svg',
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      transactions = [
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
                                      transactions.removeWhere(
                                          (item) => item.id == 'send');
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: SvgPicture.asset(
                                        'assets/images/receive_icon_svg.svg',
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      transactions = [
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
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: SvgPicture.asset(
                                        'assets/images/send_receive_icon_svg.svg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.separated(
                                controller: scrollController,
                                itemCount: transactions.length,
                                separatorBuilder: (context, i) {
                                  return Divider(
                                    color: Theme.of(context).backgroundColor,
                                    //Theme.of(context).dividerTheme.color,
                                    height: 5.0,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 25, right: 25),
                                      leading: Icon(
                                        transactions[index].icon,
                                        color: transactions[index].color,
                                      ),
                                      title: Text(
                                        transactions[index].text,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      trailing: Text(
                                        transactions[index].amount,
                                        style: TextStyle(
                                            color: transactions[index].color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )*/
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
          return Dialog(
            elevation: 0,
            backgroundColor: Theme.of(context).cardTheme.color,//Colors.black,
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
                            width: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color,),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color,),
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
