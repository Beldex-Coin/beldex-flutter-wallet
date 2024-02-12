import 'dart:async';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/dashboard/dashboard_rescan_dialog.dart';
import 'package:beldex_wallet/src/util/network_service.dart';
import 'package:beldex_wallet/src/util/screen_sizer.dart';
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

import '../../../palette.dart';

class DashboardPage extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget leading(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/images/new-images/refresh.svg',
              color: Theme.of(context).primaryTextTheme.caption.color,
              width: 23,
              height: 23,
            ),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (_) {
                    return DashBoardAlertDialog();
                  });
            },
          ),
        ),
      ],
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
            child: StandartSwitch(
                value: settingsStore.isDarkTheme,
                icon: true,
                onTaped: () {
                  final _currentValue = !settingsStore.isDarkTheme;
                  settingsStore.saveDarkTheme(isDarkTheme: _currentValue);
                  _themeChanger.setTheme(
                      _currentValue ? Themes.darkTheme : Themes.lightTheme);
                })),
        IconButton(
          icon: SvgPicture.asset(
            'assets/images/new-images/setting.svg',
            fit: BoxFit.cover,
            color: settingsStore.isDarkTheme ? Colors.white : Colors.black,
            width: 23,
            height: 23,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.profile);
          },
        ),
      ],
    );
  }

  @override
  Widget bottomNavigationBar(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    ScreenSize.init(context);
    return Container(
        height:ScreenSize.screenHeight035, //MediaQuery.of(context).size.height * 0.35 / 3,
        width:ScreenSize.screenWidth, //MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: settingsStore.isDarkTheme
                ? Color(0xff24242F)
                : Color(0xffEDEDED)),
        child: Container(
            margin:EdgeInsets.only(left:15,right:15),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height:ScreenSize.screenHeight025, // MediaQuery.of(context).size.height*0.25/3,
                    child: ElevatedButton.icon(
                      icon: SvgPicture.asset(
                        'assets/images/new-images/address_book.svg',
                        color:
                        settingsStore.isDarkTheme ? Colors.white : Colors.black,
                      ),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(Routes.addressBook),
                      label: Flexible(
                        child: Text(S.of(context).address_book,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: settingsStore.isDarkTheme
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: settingsStore.isDarkTheme
                            ? Color(0xff333343)
                            : Color(0xffD4D4D4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height:ScreenSize.screenHeight025, //MediaQuery.of(context).size.height*0.25/3,
                    child: ElevatedButton.icon(
                      icon: SvgPicture.asset(
                          'assets/images/new-images/transactions.svg'),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(Routes.transactionlist),
                      label: Flexible(
                        child: Text(S.of(context).transactions,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff0BA70F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  @override
  Widget body(BuildContext context) => DashboardPageBody(key: _bodyKey);
}

class DashboardPageBody extends StatefulWidget {
  DashboardPageBody({Key key}) : super(key: key);

  @override
  DashboardPageBodyState createState() => DashboardPageBodyState();
}

class DashboardPageBodyState extends State<DashboardPageBody> {
  final _connectionStatusObserverKey = GlobalKey();
  final _balanceObserverKey = GlobalKey();
  final _syncingObserverKey = GlobalKey();
  final _listObserverKey = GlobalKey();
  final _listKey = GlobalKey();

  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;
  var reconnect = false;


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
        await Navigator.pushNamed(context, Routes.send,
            arguments: {'flash': true, 'address': address, 'amount': amount});
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
    final actionListStore = Provider.of<ActionListStore>(context);
    final syncStore = Provider.of<SyncStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final networkStatus = Provider.of<NetworkStatus>(context);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    if (networkStatus == NetworkStatus.offline) {
      walletStore.reconnect();
    }
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Observer(
          key: _listObserverKey,
          builder: (_) {
            final items = actionListStore.items ?? <String>[];
            final itemsCount = 2; //items.length + 2;
            return ListView.builder(
                key: _listKey,
                //padding: EdgeInsets.only(bottom: 15),
                itemCount: itemsCount,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      child: Column(
                        children: [
                          Observer(
                              key: _syncingObserverKey,
                              builder: (_) {
                                final status = syncStore.status;
                                final statusText = status.title();
                                final progress = syncStore.status.progress();
                                final isFailure = status is FailedSyncStatus;
                                print('dashboard ----->');
                                print('dashboard page status --> $status');
                                print('dashboard page progress --> $progress');

                                var descriptionText = '';
                                print(
                                    'dashboard page status is SyncingSyncStatus ${status is SyncingSyncStatus}');
                                if (status is SyncingSyncStatus) {
                                  descriptionText = '';
                                  print(
                                      'dashboard page syncStore.status.toString() ${syncStore.status.toString()}');
                                  print(
                                      'dashboard page descriptionText $descriptionText');
                                }
                                if (status is FailedSyncStatus) {
                                  descriptionText = S
                                      .of(context)
                                      .please_try_to_connect_to_another_node;
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
                                              isFailure
                                                  ? BeldexPalette.red
                                                  : BeldexPalette.belgreen
                                          ),
                                          value: progress,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${statusText[0].toUpperCase() + statusText.substring(1).toLowerCase()}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: isFailure
                                                      ? BeldexPalette.red
                                                      : BeldexPalette.belgreen
                                              )),
                                          /*syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                             ? GestureDetector(
                                                 onTap: () async {
                                                   await showDialog<void>(
                                                       context: context,
                                                       builder: (_) {
                                                         return SyncInfoAlertDialog();
                                                       });
                                                 },
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(
                                                       left: 5.0),
                                                   child: Icon(Icons.info_outline,
                                                       size: 15),
                                                 ),
                                               )
                                             : Container()*/
                                        ],
                                      ),
                                    descriptionText.isNotEmpty ? Text(descriptionText,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Theme.of(context)
                                                  .primaryTextTheme
                                                  .caption
                                                  .color,
                                              height: 2.0)): Container(height: 10)
                                    ],
                                  ),
                                );
                              }),
                          // SizedBox(height:10),
                          Container(
                            height:_height * 0.71 / 3,
                            width:_width,
                            margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff272733)
                                    : Color(0xffEDEDED),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 15, bottom: 8),
                                  child: Observer(
                                      key: _connectionStatusObserverKey,
                                      builder: (_) {
                                        final savedDisplayMode =
                                            settingsStore.balanceDisplayMode;
                                        var balance = '---';
                                        final displayMode = balanceStore.isReversing
                                            ? (savedDisplayMode ==
                                            BalanceDisplayMode.availableBalance
                                            ? BalanceDisplayMode.fullBalance
                                            : BalanceDisplayMode.availableBalance)
                                            : savedDisplayMode;

                                        if (displayMode ==
                                            BalanceDisplayMode.availableBalance) {
                                          balance =
                                              balanceStore.unlockedBalanceString ??
                                                  '00.000000000';
                                          print(
                                              'Dashboard availableBalance --> $balance');
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
                                            mainAxisAlignment: MainAxisAlignment.start,
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
                                                S.of(context).bdx,
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
                                ),
                                Container(
                                  margin:
                                  EdgeInsets.only(left: 15, right: 15),
                                  child: Observer(
                                      key: _balanceObserverKey,
                                      builder: (_) {
                                        final savedDisplayMode =
                                            settingsStore.balanceDisplayMode;
                                        final displayMode =
                                        settingsStore.enableFiatCurrency
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
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    0.07 /
                                                    3));
                                      }),
                                ),
                                Flexible(child:Container()),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Observer(builder: (_) {
                                          return SizedBox(
                                            height: MediaQuery.of(context).size.height*0.20/3,
                                            child: ElevatedButton.icon(
                                              icon: SvgPicture.asset(
                                                'assets/images/new-images/send.svg',
                                                color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                                    ? Colors.white
                                                    : settingsStore.isDarkTheme
                                                    ? Color(0xff6C6C78)
                                                    : Color(0xffB2B2B6),
                                              ),
                                              onPressed: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                                  ? () {
                                                Navigator.of(context,
                                                    rootNavigator: true)
                                                    .pushNamed(Routes.send);
                                              }
                                                  : null,
                                              label: Flexible(
                                                child: Text(
                                                  S.of(context).send,
                                                  style: TextStyle(
                                                    color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                                        ? Colors.white
                                                        : settingsStore.isDarkTheme
                                                        ? Color(0xff6C6C78)
                                                        : Color(0xffB2B2B6),
                                                    fontWeight: FontWeight.bold,),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                                    ? Color(0xff0BA70F)
                                                    : settingsStore.isDarkTheme
                                                    ? Color(0xff333343)
                                                    : Color(0xffE8E8E8),
                                                padding: EdgeInsets.all(12),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height*0.20/3,
                                          child: ElevatedButton.icon(
                                            icon: SvgPicture.asset(
                                                'assets/images/new-images/receive.svg'),
                                            onPressed: () =>
                                                Navigator.of(context, rootNavigator: true)
                                                    .pushNamed(Routes.receive),
                                            label: Flexible(
                                              child: Text(
                                                S.of(context).receive,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xff2979FB),
                                              padding: EdgeInsets.all(12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: _width,
                            margin: EdgeInsets.only(left:15.0,right: 15.0),
                            child: Observer(builder: (_) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height*0.20/3,
                                child: ElevatedButton.icon(
                                  icon: SvgPicture.asset(
                                    settingsStore.isDarkTheme?'assets/images/new-images/ic_bns_dark.svg':'assets/images/new-images/ic_bns_light.svg',
                                  ),
                                  onPressed: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                      ? () {
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .pushNamed(Routes.bns);
                                  }
                                      : null,
                                  label: Flexible(
                                    child: Text(
                                      S.of(context).buyBns,
                                      style: TextStyle(
                                        color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                            ? settingsStore.isDarkTheme
                                            ? Colors.white
                                            : Colors.black
                                            : settingsStore.isDarkTheme
                                            ? Color(0xff6C6C78)
                                            : Color(0xffB2B2B6),
                                        fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                        ? settingsStore.isDarkTheme
                                        ? Color(0xff272733)
                                        : Color(0xffFFFFFF)
                                        : settingsStore.isDarkTheme
                                        ? Color(0xff333343)
                                        : Color(0xffE8E8E8),
                                    padding: EdgeInsets.all(12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Color(0xff2979FB))
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10,top:10,),
                    height: MediaQuery.of(context).size.height * 0.73 / 2,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
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
                            return GestureDetector(
                              onTap: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                  ? () {
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
                                      color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0
                                          ? Color(0xff222222)
                                          : Color(0xffD9D9D9),
                                    )),
                              ),
                            );
                          },
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                              S.of(context)
                                  .transferYourBdxMoreFasternWithFlashTransaction,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                  );
                });
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
                : Color(0xffffffff),
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
                                      : Color(0xffE8E8E8)),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff93939B)
                                        : Color(0xff222222),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Color(0xff0BA70F)),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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