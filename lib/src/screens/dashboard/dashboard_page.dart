import 'dart:async';
import 'dart:ui';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/dashboard/dashboard_rescan_dialog.dart';
import 'package:beldex_wallet/src/util/network_service.dart';
import 'package:beldex_wallet/src/widgets/standart_switch.dart';
import 'package:beldex_wallet/theme_changer.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/action_list/action_list_store.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../palette.dart';

class DashboardPage extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget leading(BuildContext context) {
    return InkWell(
      onTap: () {
        // _presentWalletMenu(context);
        showDialog<void>(
            context: context,
            builder: (_) {
              return DashBoardAlertDialog();
            });
      },
      child: Container(
          height: 18,
          padding: EdgeInsets.only(top: 12.0, bottom: 10),
          decoration: BoxDecoration(),
          child: SvgPicture.asset(
            'assets/images/new-images/refresh.svg',
            color: Theme.of(context).primaryTextTheme.caption.color,
            width: 23,
            height: 23,
          )),
    );
  }

  @override
  Widget middle(BuildContext context) {
    final walletStore = Provider.of<WalletStore>(context);
    return Observer(
      builder: (_) {
        return Text(
          walletStore.name,
          style: TextStyle(
              fontSize: 24.0 - (12 - 8) * 2.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryTextTheme.headline6.color),
        );
      },
    );
  }

  @override
  Widget trailing(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final _themeChanger = Provider.of<ThemeChanger>(context);
    return Row(
      children: [
        Container(
            height: 25,
            width: 50,
            child:
                //  Observer(builder: (_){
                //   return
                //  })

                StandartSwitch(
                    value: settingsStore.isDarkTheme,
                    icon: true,
                    //activeThumbImage: ,
                    onTaped: () {
                      final _currentValue = !settingsStore.isDarkTheme;
                      settingsStore.saveDarkTheme(isDarkTheme: _currentValue);
                      _themeChanger.setTheme(
                          _currentValue ? Themes.darkTheme : Themes.lightTheme);
                    })),
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 55, //55
            width: 55, //37
            child: ButtonTheme(
              minWidth: double.minPositive,
              child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.profile),
                  child: SvgPicture.asset(
                    'assets/images/new-images/setting.svg',
                    fit: BoxFit.cover,
                    color:
                        settingsStore.isDarkTheme ? Colors.white : Colors.black,
                    width: 23,
                    height: 23,
                  )),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget bottomNavigationBar(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
        height: MediaQuery.of(context).size.height * 0.35 / 3,
        width: double.infinity,
        decoration: BoxDecoration(
            color: settingsStore.isDarkTheme
                ? Color(0xff24242F)
                : Color(0xffEDEDED)),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Routes.addressBook),
              child: Container(
                  width: MediaQuery.of(context).size.width * 1.30 / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: settingsStore.isDarkTheme
                          ? Color(0xff333343)
                          : Color(0xffD4D4D4)),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/new-images/Address.svg',
                        color: settingsStore.isDarkTheme
                            ? Colors.white
                            : Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(S.of(context).address_book,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      )
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.transactionlist);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 1.30 / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff0BA70F)),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/new-images/transactions.svg'),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(S.of(context).transactions,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16)),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }

  @override
  Widget body(BuildContext context) => DashboardPageBody(key: _bodyKey);

//   void _presentWalletMenu(BuildContext bodyContext) {
//     final walletMenu = WalletMenu(bodyContext);

//     showDialog<void>(
//         builder: (_) => Picker(
//             items: walletMenu.items,
//             selectedAtIndex: -1,
//             title: S.of(bodyContext).wallet_menu,
//             pickerHeight: 250,
//             onItemSelected: (String item) =>
//                 walletMenu.action(walletMenu.items.indexOf(item))),
//         context: bodyContext);
//   }
}

class DashboardPageBody extends StatefulWidget {
  DashboardPageBody({Key key}) : super(key: key);

  @override
  DashboardPageBodyState createState() => DashboardPageBodyState();
}

class DashboardPageBodyState extends State<DashboardPageBody> {
  final _connectionStatusObserverKey = GlobalKey();
  final _balanceObserverKey = GlobalKey();
  //final _balanceTitleObserverKey = GlobalKey();
  final _syncingObserverKey = GlobalKey();
  final _listObserverKey = GlobalKey();
  //final _listKey = GlobalKey();
  String syncStatus;
  //
  // List<Item> transactions = [
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 99.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '25.01.2021',
  //       amount: '+\$ 105.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '20.01.2021',
  //       amount: '+\$ 60.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '20.01.2021',
  //       amount: '+\$ 60.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red),
  //   Item(
  //       id: 'receive',
  //       icon: Icons.arrow_downward,
  //       text: '20.01.2021',
  //       amount: '+\$ 60.00',
  //       color: Colors.green),
  //   Item(
  //       id: 'send',
  //       icon: Icons.arrow_upward,
  //       text: '01.02.2021',
  //       amount: '-\$ 105.00',
  //       color: Colors.red)
  // ];

  IconData iconDataVal = Icons.arrow_upward_outlined;

  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  var reconnect = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _presentQRScanner(BuildContext context) async {
    try {
      final code = await presentQRScanner();
      final uri = Uri.parse(code);
      var address = '';
      var amount = '';
      if (uri != null) {
        address = uri.path;
        if (uri.queryParameters.isNotEmpty) {
          amount = uri.queryParameters[uri.queryParameters.keys.first];
        }
      } else {
        address = code;
      }
      if (address.isNotEmpty || amount.isNotEmpty) {
        await Navigator.pushNamed(context, Routes.send, arguments: {
          'flash': true,
          'address': address,
          'amount': amount
        });
      }
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  void dispose() {
    // if(subscription.)
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletStore = Provider.of<WalletStore>(context);
    final balanceStore = Provider.of<BalanceStore>(context);
    final syncStore = Provider.of<SyncStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.offline) {
      walletStore.reconnect();
    }
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Observer(
          key: _listObserverKey,
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Observer(
                      key: _syncingObserverKey,
                      builder: (_) {
                        final status = syncStore.status;
                        final statusText = status.title();
                        final progress = syncStore.status.progress();
                        final isFailure = status is FailedSyncStatus;
                        syncStatus = status.title();
                        //syncStatus = status.title();
                        print('dashboard ----->');
                        print('dashboard page status --> $status');
                        print('dashboard page progress --> $progress');

                        var descriptionText = '';
                        print(
                            'dashboard page status is SyncingSyncStatus ${status is SyncingSyncStatus}');
                        if (status is SyncingSyncStatus) {
                          /*descriptionText = S
                                              .of(context)
                                              .Blocks_remaining(
                                                  syncStore.status.toString());*/
                          descriptionText = '';
                          print(
                              'dashboard page syncStore.status.toString() ${syncStore.status.toString()}');
                          print(
                              'dashboard page descriptionText $descriptionText');
                        }
                        if (status is FailedSyncStatus) {
                          descriptionText =
                              S.of(context).please_try_to_connect_to_another_node;
                          reconnect = true;
                          if (networkStatus == NetworkStatus.online &&
                              reconnect) {
                            walletStore.reconnect();
                            reconnect = false;
                          }
                        }
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 1.5,
                                child: LinearProgressIndicator(
                                  backgroundColor: Palette.separator,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      BeldexPalette.belgreen //teal
                                      ),
                                  value: progress,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${statusText[0].toUpperCase() + statusText.substring(1).toLowerCase()}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isFailure
                                              ? BeldexPalette.red
                                              : BeldexPalette.belgreen //teal
                                          )),
                                  statusText == 'SYNCHRONIZED'
                                      ? GestureDetector(
                                          onTap: () async {
                                            await showDialog<void>(
                                                context: context,
                                                builder: (_) {
                                                  return SyncInfoAlertDialog();
                                                });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5.0),
                                            child: Icon(Icons.info_outline,
                                                size: 15),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                              Text(descriptionText,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .caption
                                          .color,
                                      height: 2.0))
                            ],
                          ),
                        );
                      }),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65 / 3,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff272733)
                            : Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 10, top: 15, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Observer(
                                  key: _connectionStatusObserverKey,
                                  builder: (_) {
                                    final savedDisplayMode =
                                        settingsStore.balanceDisplayMode;
                                    var balance = '---';
                                    final displayMode = balanceStore.isReversing
                                        ? (savedDisplayMode ==
                                                BalanceDisplayMode
                                                    .availableBalance
                                            ? BalanceDisplayMode.fullBalance
                                            : BalanceDisplayMode.availableBalance)
                                        : savedDisplayMode;

                                    if (displayMode ==
                                        BalanceDisplayMode.availableBalance) {
                                      balance =
                                          balanceStore.unlockedBalanceString ??
                                              '00.000000000';
                                      print('Dashboard availableBalance --> $balance');
                                    }
                                    if (displayMode ==
                                        BalanceDisplayMode.fullBalance) {
                                      balance = balanceStore.fullBalanceString ??
                                          '00.000000000';
                                      print('Dashboard fullBalance --> $balance');
                                    }
                                    return GestureDetector(
                                       onTapUp: (_) =>
                                            balanceStore.isReversing = false,
                                        onTapDown: (_) =>
                                            balanceStore.isReversing = true,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            '$balance ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .caption
                                                  .color,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12 /
                                                  3,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'BDX',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .caption
                                                  .color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                          child: Row(
                            children: [
                              Observer(
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
                                                ? BalanceDisplayMode.fullBalance
                                                : BalanceDisplayMode
                                                    .availableBalance)
                                            : savedDisplayMode)
                                        : BalanceDisplayMode.hiddenBalance;
                                    final symbol =
                                        settingsStore.fiatCurrency.toString();
                                    var balance = '---';

                                    if (displayMode ==
                                        BalanceDisplayMode.availableBalance) {
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
                                            color: Color(0xff0BA70F),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07 /
                                                3));
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Observer(builder: (_) {
                              final status = syncStore.status;

                              final syncS = status.title();
                              return InkWell(
                                onTap: syncS == 'SYNCHRONIZED'
                                    ? () {
                                        Navigator.of(context, rootNavigator: true)
                                            .pushNamed(Routes.send);
                                      }
                                    : null,
                                child: Container(
                                  width: 142,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: syncS == 'SYNCHRONIZED'
                                        ? Color(0xff0BA70F)
                                        : settingsStore.isDarkTheme
                                            ? Color(0xff333343)
                                            : Color(0xffE8E8E8),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 20,
                                          width: 20,
                                          child: SvgPicture.asset(
                                            'assets/images/new-images/send.svg',
                                            color: syncS == 'SYNCHRONIZED'
                                                ? Colors.white
                                                : settingsStore.isDarkTheme
                                                    ? Color(0xff6C6C78)
                                                    : Color(0xffB2B2B6),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          S.of(context).send,
                                          style: TextStyle(
                                              color: syncStatus == 'SYNCHRONIZED'
                                                  ? Colors.white
                                                  : settingsStore.isDarkTheme
                                                      ? Color(0xff6C6C78)
                                                      : Color(0xffB2B2B6),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                            InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(Routes.receive);
                              },
                              child: Container(
                                width: 142,
                                height: 46,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xff2979FB),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 20,
                                        width: 20,
                                        child: SvgPicture.asset(
                                            'assets/images/new-images/receive.svg')),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        S.of(context).receive,
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
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    height: MediaQuery.of(context).size.height * 0.87 / 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: settingsStore.isDarkTheme
                            ? Color(0xff272733)
                            : Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          S.of(context).flashTransaction,
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w800),
                        ),
                        Observer(
                          builder: (_) {
                            final status = syncStore.status;
                            final syncSt = status.title();
                            return GestureDetector(
                              onTap: syncSt == 'SYNCHRONIZED'
                                  ? (){
                                       _presentQRScanner(context);
                                    }
                                  : null,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xffD9D9D9)
                                      : Color(0xffE2E2E2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/new-images/flashqr.svg',
                                      color: syncSt == 'SYNCHRONIZED'
                                          ? Color(0xff222222)
                                          : Color(0xffD9D9D9),
                                    )),
                              ),
                            );
                          },
                        ),
                        Text(
                            S.of(context).transferYourBdxMoreFasternWithFlashTransaction,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                ],
              ),
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
            backgroundColor: settingsStore.isDarkTheme
                ? Color(0xff272733)
                : Color(
                    0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
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
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        S.of(context).doYouWantToExitTheWallet,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 80,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: settingsStore.isDarkTheme
                                      ? Color(0xff383848)
                                      : Color(
                                          0xffE8E8E8)
                                  ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff93939B)
                                        : Color(0xff222222),
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Color(
                                      0xff0BA70F)
                                  ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
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

Future showMenuForRescan(
    BuildContext context, String title, String body, String fee, String address,
    {String buttonText,
    void Function(BuildContext context) onPressed,
    void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => ShowMenuForRescan(title, body, fee, address,
          buttonText: buttonText, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}

class ShowMenuForRescan extends StatelessWidget {
  const ShowMenuForRescan(
    this.title,
    this.body,
    this.fee,
    this.address, {
    this.buttonText,
    this.onPressed,
    this.onDismiss,
  }); // : super(key: key);

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
    return GestureDetector(
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
                        color: settingsStore.isDarkTheme
                            ? Color(0xff272733)
                            : Colors.white, //Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1.4 / 3,
                      padding: EdgeInsets.only(top: 15.0, left: 20, right: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800)),
                          ),
                          Container(
                              height: 50,
                              //padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff383848)
                                      : Color(0xffEDEDED)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Amount',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  VerticalDivider(),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'body',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppinsbold'),
                                    ),
                                  )),
                                  Container(
                                    width: 70,
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xff00B116),
                                          shape: BoxShape.circle,
                                        ),
                                        child: SvgPicture.asset(
                                            'assets/images/new-images/beldex.svg')),
                                  )
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(10),
                              height:
                                  MediaQuery.of(context).size.height * 0.60 / 3,
                              decoration: BoxDecoration(
                                  color: settingsStore.isDarkTheme
                                      ? Color(0xff383848)
                                      : Color(0xffEDEDED),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Address'),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: settingsStore.isDarkTheme
                                              ? Color(0xff47475E)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(address)),
                                  Text('Fee: fee'),
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    0.10 /
                                    3),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 45,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: settingsStore.isDarkTheme
                                          ? Color(0xff383848)
                                          : Color(0xffEDEDED),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (onDismiss != null)
                                          onDismiss(context);
                                      },
                                      child: Center(
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w800)))),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: 45,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: Color(0xff0BA70F),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (onPressed != null)
                                          onPressed(context);
                                      },
                                      child: Center(
                                          child: Text(
                                        'OK',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white),
                                      ))),
                                )
                              ],
                            ),
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

class SyncInfoAlertDialog extends StatefulWidget {
  const SyncInfoAlertDialog({Key key}) : super(key: key);

  @override
  State<SyncInfoAlertDialog> createState() => _SyncInfoAlertDialogState();
}

class _SyncInfoAlertDialogState extends State<SyncInfoAlertDialog> {
  int bHeight = 0;

  @override
  void initState() {
    getHeight();
    super.initState();
  }

  void getHeight() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bHeight = prefs.getInt('currentHeight');
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xff0BA70F),
          ),
          Text('Sync info', style: TextStyle(fontWeight: FontWeight.w800)),
        ],
      )),
      backgroundColor:
          settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You have scanned from the block height',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
          Text(bHeight.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff0BA70F))),
          Text(
              'However we recommend to scan the blockchain from the block height at which you created the wallet to get all transactions and correct balance',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13)),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff0BA70F)),
                  child: Center(
                      child: Text('OK',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)))),
            ),
          )
        ],
      ),
    );
  }
}
