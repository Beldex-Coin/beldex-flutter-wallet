import 'dart:async';
import 'package:beldex_wallet/src/domain/common/qr_scanner.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/dashboard/dashboard_rescan_dialog.dart';
import 'package:beldex_wallet/src/swap/util/utils.dart';
import 'package:beldex_wallet/src/util/screen_sizer.dart';
import 'package:beldex_wallet/src/widgets/standard_switch.dart';
import 'package:beldex_wallet/theme_changer.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/balance/balance_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:provider/provider.dart';

import '../../../palette.dart';
import '../../util/network_provider.dart';

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
              color: Theme.of(context).primaryTextTheme.bodySmall?.color,
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
              backgroundColor: Colors.transparent,
              fontSize: 24.0 - (12 - 8) * 2.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryTextTheme.titleLarge?.color),
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
            child: StandardSwitch(
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
            colorFilter: ColorFilter.mode(settingsStore.isDarkTheme ? Colors.white : Colors.black, BlendMode.srcIn),
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
                ? Color(0xff171720)
                : Color(0xffffffff)),
        child: Container(
            margin:EdgeInsets.only(left:15,right:15),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: SvgPicture.asset(
                      'assets/images/new-images/address_book.svg',
                      colorFilter: ColorFilter.mode(Color(0xFF1BB71F), BlendMode.srcIn),
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.addressBook),
                    label: Text(tr(context).address_book,
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
                            fontWeight: FontWeight.w800,
                            color: settingsStore.isDarkTheme
                                ? Colors.white
                                : Colors.black)),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size.fromHeight(ScreenSize.screenHeight025),
                      backgroundColor: settingsStore.isDarkTheme
                          ? Color(0xff24242F)
                          : Color(0xffEDEDED),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: SvgPicture.asset(
                        'assets/images/new-images/transactions.svg',
                      colorFilter: ColorFilter.mode(Color(0xFF2979FB), BlendMode.srcIn),),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.transactionlist),
                    label: Text(tr(context).transactions,
                        style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontWeight: FontWeight.w800,
                          color: settingsStore.isDarkTheme
                              ? Colors.white
                              : Colors.black,)),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size.fromHeight(ScreenSize.screenHeight025),
                      backgroundColor: settingsStore.isDarkTheme
                          ? Color(0xff24242F)
                          : Color(0xffEDEDED),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
  DashboardPageBody({Key? key}) : super(key: key);

  @override
  DashboardPageBodyState createState() => DashboardPageBodyState();
}

class DashboardPageBodyState extends State<DashboardPageBody> {
  final _connectionStatusObserverKey = GlobalKey();
  final _balanceObserverKey = GlobalKey();
  final _syncingObserverKey = GlobalKey();
  final _listKey = GlobalKey();
  //var reconnect = false;


  Future<void> _presentQRScanner(BuildContext context) async {
    try {
      final code = await presentQRScanner();
      final uri = Uri.parse(code!);
      var address = '';
      var amount = '';
      if (uri != null) {
        address = uri.path;
        if (uri.queryParameters.isNotEmpty) {
          amount = uri.queryParameters[uri.queryParameters.keys.first]!;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletStore = Provider.of<WalletStore>(context);
    final balanceStore = Provider.of<BalanceStore>(context);
    final syncStore = Provider.of<SyncStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final networkStatus = Provider.of<NetworkProvider>(context);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: ListView.builder(
          key: _listKey,
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                child: Column(
                  children: [
                    Observer(
                        key: _syncingObserverKey,
                        builder: (_) {
                          final status = syncStore.status;
                          final statusText = status.title(tr(context));
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
                            descriptionText = tr(context)
                                .please_try_to_connect_to_another_node;
                            /* reconnect = true;
                                  if (networkStatus == NetworkStatus.online && reconnect) {
                                    walletStore.reconnect();
                                    reconnect = false;
                                  }*/
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
                                            backgroundColor: Colors.transparent,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: isFailure
                                                ? BeldexPalette.red
                                                : BeldexPalette.belgreen
                                        )),
                                    /*syncStatus(syncStore.status)
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
                                        backgroundColor: Colors.transparent,
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .bodySmall!
                                            .color,
                                        height: 2.0)): Container(height: 10)
                              ],
                            ),
                          );
                        }),
                    // SizedBox(height:10),
                    Container(
                      height:_height * 0.65 / 3,
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
                                left: 15, right: 15, top: 15,),
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
                                            backgroundColor: Colors.transparent,
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .bodySmall!
                                                .color,
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.12 /
                                                3,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          tr(context).bdx,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .bodySmall!
                                                .color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
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
                                          backgroundColor: Colors.transparent,
                                          color: Color(0xff0BA70F),
                                          fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06 /
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
                                  child: Observer(builder: (_) {
                                    return ElevatedButton.icon(
                                      iconAlignment: IconAlignment.end,
                                      icon: SvgPicture.asset(
                                        'assets/images/new-images/send.svg',
                                        colorFilter: ColorFilter.mode(syncStatus(syncStore.status)
                                            ? Colors.white
                                            : settingsStore.isDarkTheme
                                            ? Color(0xff6C6C78)
                                            : Color(0xffB2B2B6), BlendMode.srcIn),
                                      ),
                                      onPressed: syncStatus(syncStore.status)
                                          ? () {
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pushNamed(Routes.send,arguments: {'flash': false, 'address': "", 'amount': ""});
                                      }
                                          : null,
                                      label: Text(
                                        tr(context).send,
                                        style: TextStyle(
                                          fontSize: 14,
                                          backgroundColor: Colors.transparent,
                                          color: syncStatus(syncStore.status)
                                              ? Colors.white
                                              : settingsStore.isDarkTheme
                                              ? Color(0xff6C6C78)
                                              : Color(0xffB2B2B6),
                                          fontWeight: FontWeight.w800,),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        fixedSize: Size.fromHeight(ScreenSize.buttonHeight020),
                                        backgroundColor: syncStatus(syncStore.status)
                                            ? Color(0xff0BA70F)
                                            : settingsStore.isDarkTheme
                                            ? Color(0xff333343)
                                            : Color(0xffE8E8E8),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    icon: SvgPicture.asset(
                                        'assets/images/new-images/receive.svg'),
                                    onPressed: () =>
                                        Navigator.of(context, rootNavigator: true)
                                            .pushNamed(Routes.receive),
                                    label: Text(
                                      tr(context).receive,
                                      style: TextStyle(
                                        fontSize: 14,
                                        backgroundColor: Colors.transparent,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      fixedSize: Size.fromHeight(ScreenSize.buttonHeight020),
                                      backgroundColor: Color(0xff2979FB),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
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
                    Consumer<NetworkProvider>(builder: (context,networkProvider,child){
                      if (!networkProvider.isConnected) {
                        walletStore.reconnect();
                      }
                        return Container(
                          margin: EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  iconAlignment: IconAlignment.end,
                                  icon: SvgPicture.asset(
                                    'assets/images/swap/ic_swap.svg',colorFilter:ColorFilter.mode(networkProvider.isConnected ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                                      ? Color(0xff6C6C78)
                                      : Color(0xffB2B2B6), BlendMode.srcIn),),
                                  onPressed: networkProvider.isConnected ? () {
                                    Navigator.of(context, rootNavigator: true).pushNamed(Routes.swapExchange);
                                  } : null,
                                  label: Text(
                                    tr(context).swap,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: networkProvider.isConnected
                                          ? settingsStore.isDarkTheme
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff333333)
                                          : settingsStore.isDarkTheme
                                          ? Color(0xff6C6C78)
                                          : Color(0xffB2B2B6),
                                      fontWeight: FontWeight.w800,),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: Size.fromHeight(ScreenSize.screenHeight025),
                                    backgroundColor:  networkProvider.isConnected
                                        ? settingsStore.isDarkTheme? Color(0xff272733) : Color(0xffEDEDED)
                                        : settingsStore.isDarkTheme
                                        ? Color(0xff333343)
                                        : Color(0xffE8E8E8),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: Observer(builder: (_) {
                                  return ElevatedButton.icon(
                                    iconAlignment: IconAlignment.end,
                                    icon: syncStatus(syncStore.status) ? SvgPicture.asset('assets/images/new-images/ic_buy_bns.svg',
                                    ) : SvgPicture.asset(
                                      'assets/images/new-images/ic_buy_bns.svg',
                                        colorFilter:ColorFilter.mode(settingsStore.isDarkTheme
                                            ? Color(0xff6C6C78)
                                            : Color(0xffB2B2B6), BlendMode.srcIn),
                                    ),
                                    onPressed: syncStatus(syncStore.status)
                                        ? () {
                                      Navigator.of(context,
                                          rootNavigator: true)
                                          .pushNamed(Routes.bns);
                                    }
                                        : null,
                                    label: Text(
                                      tr(context).buyBns,
                                      style: TextStyle(
                                        fontSize: 14,
                                        backgroundColor: Colors.transparent,
                                        color: syncStatus(syncStore.status)
                                            ? settingsStore.isDarkTheme
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff333333)
                                            : settingsStore.isDarkTheme
                                            ? Color(0xff6C6C78)
                                            : Color(0xffB2B2B6),
                                        fontWeight: FontWeight.w800,),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      fixedSize: Size.fromHeight(ScreenSize.screenHeight025),
                                      backgroundColor: syncStatus(syncStore.status)
                                          ? settingsStore.isDarkTheme
                                          ? Color(0xff24242F)
                                          : Color(0xffEDEDED)
                                          : settingsStore.isDarkTheme
                                          ? Color(0xff333343)
                                          : Color(0xffE8E8E8),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        );
                      }
                    )
                  ],
                ),
              );
            }
            return Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 10,top:10,),
              height: MediaQuery.of(context).size.height * 0.83 / 2,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff24242F)
                      : Color(0xffEDEDED),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    tr(context).flashTransaction,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: 23, fontWeight: FontWeight.w800),
                  ),
                  Observer(
                    builder: (_) {
                      return GestureDetector(
                        onTap: syncStatus(syncStore.status)
                            ? () {
                          _presentQRScanner(context);
                        }
                            : null,
                        child: Container(
                          padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: syncStatus(syncStore.status) ? settingsStore.isDarkTheme
                                ? Color(0xff24242F)
                                : Color(0xffF7F7F7) : settingsStore.isDarkTheme
                                ? Color(0xff333343)
                                : Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.fromBorderSide(BorderSide(color: syncStatus(syncStore.status) ? Color(0xff0BA70F) : settingsStore.isDarkTheme
                                ? Color(0xff6C6C78)
                                : Color(0xffB2B2B6), width: 2.67)),
                          ),
                          child: syncStatus(syncStore.status) ? SvgPicture.asset(
                            'assets/images/new-images/flashqr.svg',
                          ) : SvgPicture.asset(
                            'assets/images/new-images/flashqr.svg',
                            colorFilter:ColorFilter.mode(settingsStore.isDarkTheme
                                ? Color(0xff6C6C78)
                                : Color(0xffB2B2B6), BlendMode.srcIn),
                          ),
                        ),
                      );
                    },
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                        tr(context)
                            .transferYourBdxMoreFasternWithFlashTransaction,
                        textAlign: TextAlign.center,
                        style: TextStyle(backgroundColor: Colors.transparent, fontSize: 16)),
                  )
                ],
              ),
            );
          }),
    );
  }

  Future<bool> onBackPressed() async {
    final result = await showDialog<bool>(
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
            surfaceTintColor: Colors.transparent,
            child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tr(context).are_you_sure,
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        tr(context).doYouWantToExitTheWallet,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
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
                                tr(context).no,
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
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
                                tr(context).yes,
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
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
    return result ?? false;
  }
}

class Item {
  Item({this.id, this.icon, this.text, this.amount, this.color});

  String? id;
  IconData? icon;
  String? text;
  String? amount;
  Color? color;
}