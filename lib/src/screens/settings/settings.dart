import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';

// Settings widgets
import 'package:beldex_wallet/src/screens/settings/widgets/settings_switch_list_row.dart';
import 'package:beldex_wallet/src/screens/settings/widgets/settings_text_list_row.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/crypto_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/widgets/nav/new_nav_list_header.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.walletSettings;

  @override
  Color get backgroundColor => Palette.lightGrey2;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    return SettingsForm();
  }
}

class SettingsForm extends StatefulWidget {
  @override
  SettingsFormState createState() => SettingsFormState();
}

class SettingsFormState extends State<SettingsForm> {

  final _emailUrl = 'mailto:support@beldex.io';
  final _telegramUrl = 'https:t.me/beldexcoin';
  final _twitterUrl = 'https:twitter.com/BeldexCoin';
  final _githubUrl = 'https:github.com/Beldex-Coin';


  void _launchUrl(String url) async {
    print('call _launchURL');
    if (await canLaunch(url)) await launch(url);
  }

  TextEditingController searchDecimalController = TextEditingController();
  TextEditingController searchCurrencyController = TextEditingController();

  String? decimalFilter;
  String? currencyFilter;

  LocalAuthentication auth  = LocalAuthentication();
  List<BiometricType> _availableBiometrics = <BiometricType>[];
  StateSetter? _searchCurrencySetState;

  @override
  void initState() {
    //-->
    _getAvailableBiometrics();
    super.initState();
    searchDecimalController.addListener(() {
      setState(() {
        decimalFilter = searchDecimalController.text;
      });
    });
    searchCurrencyController.addListener(() {
      _searchCurrencySetState!(() {
        currencyFilter = searchCurrencyController.text;
      });
    });
  }

  //-->
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  @override
  void dispose() {
    searchDecimalController.dispose();
    searchCurrencyController.dispose();
    super.dispose();
  }

  var language = 'english';

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    final t = tr(context);
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Nodes Header
            NewNavListHeader(
              title: t.settings_nodes,
            ),
            //Current Node
            Theme(
              data: ThemeData(
                splashColor: Colors.grey,
                highlightColor:  Colors.grey,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,color: Color(0xff3F3F4D),),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(t.settings_current_node,
                        style: TextStyle(
                            backgroundColor: Colors.transparent,
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.height *
                                0.06 /
                                3, color: Theme.of(context).primaryTextTheme.headline6?.color),),
                    settingsStore.node == null
                        ? Container()
                        : Observer(builder: (_) {
                      return Text(settingsStore.node?.uri ?? "",
                          style: TextStyle(
                              backgroundColor: Colors.transparent,
                              color: Color(0xff1BB71F),
                              fontSize: 13));
                    })
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.nodeList);
                },
              ),
            ),
            //Wallets Header
            NewNavListHeader(title: t.settings_wallets),
            Column(
              children: [
                //Display Balance as
                SettingsTextListRow(
                  onTaped: () async {
                    await showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () {
                              return Future.value(false);
                            },
                            child: Dialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(15),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height *
                                        0.90 /
                                        3,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff272733)
                                        : Color(0xffFFFFFF),
                                    borderRadius:
                                        BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: Text(
                                            tr(context).settings_display_balance_as,
                                            style: TextStyle(
                                                backgroundColor: Colors.transparent,
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount:
                                                  BalanceDisplayMode
                                                      .all.length,
                                              shrinkWrap: true,
                                              controller:
                                                  _scrollController,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    final settingsStore =
                                                        context.read<
                                                            SettingsStore>();
                                                    if (BalanceDisplayMode
                                                            .all[index] != null) {
                                                      await settingsStore.setCurrentBalanceDisplayMode(
                                                          balanceDisplayMode:
                                                              BalanceDisplayMode
                                                                      .all[
                                                                  index]);
                                                    }
                                                    Navigator.pop(
                                                        context);
                                                  },
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    elevation: 0.0,
                                                    color: settingsStore
                                                                .balanceDisplayMode ==
                                                            BalanceDisplayMode
                                                                    .all[
                                                                index]
                                                        ? Color(
                                                            0xff2979FB)
                                                        : Colors
                                                            .transparent,
                                                    child: Container(
                                                        width:
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                        padding: EdgeInsets
                                                            .only(
                                                                top: 15,
                                                                bottom:
                                                                    15),
                                                        child: Observer(
                                                          builder: (_) =>
                                                              Text(
                                                            BalanceDisplayMode
                                                                .all[
                                                                    index]
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: TextStyle(
                                                                backgroundColor: Colors.transparent,
                                                                fontSize:
                                                                    14,
                                                                color: settingsStore.balanceDisplayMode !=
                                                                        BalanceDisplayMode.all[
                                                                            index]
                                                                    ? Colors.grey.withOpacity(
                                                                        0.6)
                                                                    : Color(
                                                                        0xffFFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 7, right: 10),
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: Icon(Icons.close)),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  title: t.settings_display_balance_as,
                  widget: Observer(
                      builder: (_) => Text(
                            settingsStore.balanceDisplayMode.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.06 /
                                        3,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryTextTheme.headline6?.color),
                          )),
                ),
                //Decimals
                SettingsTextListRow(
                  onTaped: () async {
                    await showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () {
                              return Future.value(false);
                            },
                            child: Dialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(15),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height *
                                        1 /
                                        3,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff272733)
                                        : Color(0xffFFFFFF),
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Decimals',
                                            style: TextStyle(
                                                backgroundColor: Colors.transparent,
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: RawScrollbar(
                                            padding: EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                                top: 10,
                                                bottom: 10),
                                            controller: _scrollController,
                                            /*heightScrollThumb: 25,
                                            alwaysVisibleScrollThumb:
                                                false,
                                            backgroundColor:
                                                Theme.of(context)
                                                    .primaryTextTheme
                                                    .button
                                                    .backgroundColor,*/
                                            child: ListView.builder(
                                                itemCount: AmountDetail
                                                    .all.length,
                                                //shrinkWrap: true,
                                                controller:
                                                    _scrollController,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return decimalFilter ==
                                                              null ||
                                                          decimalFilter ==
                                                              ''
                                                      ? decimalDropDownListItem(
                                                          settingsStore,
                                                          index)
                                                      : '${AmountDetail.all[index]}'
                                                              .toLowerCase()
                                                              .contains(
                                                                  decimalFilter!
                                                                      .toLowerCase())
                                                          ? decimalDropDownListItem(
                                                              settingsStore,
                                                              index)
                                                          : Container();
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 7, right: 10),
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: Icon(Icons.close)),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  title: t.settings_balance_detail,
                  widget: Observer(
                      builder: (_) => Text(
                        settingsStore.balanceDetail.getTitle(tr(context)),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.06 /
                                        3,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryTextTheme.headline6?.color),
                          )),
                ),
                //Enable fiat currency conversation
                SettingsSwitchListRow(
                  title: t.settings_enable_fiat_currency,
                ),
                //Currency
                SettingsTextListRow(
                  onTaped: () async {
                    await showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) =>
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              _searchCurrencySetState = setState;
                              return WillPopScope(
                                onWillPop: () {
                                  return Future.value(false);
                                },
                                child: Dialog(
                                  surfaceTintColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(15),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context)
                                            .size
                                            .height *
                                        1 /
                                        3,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff272733)
                                            : Color(0xffFFFFFF),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(8.0),
                                              child: Text(
                                                'Currency',
                                                style: TextStyle(
                                                  backgroundColor: Colors.transparent,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller:
                                                    searchCurrencyController,
                                                decoration:
                                                    InputDecoration(
                                                  hintText:
                                                      'Search Currency',
                                                  hintStyle: TextStyle(backgroundColor: Colors.transparent),
                                                  suffixIcon: IconButton(
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: currencyFilter == null || currencyFilter!.isEmpty ? Colors.transparent : settingsStore
                                                                .isDarkTheme
                                                            ? Color(
                                                                0xffffffff)
                                                            : Color(
                                                                0xff171720),
                                                      ),
                                                      onPressed: currencyFilter == null || currencyFilter!.isEmpty ? null : () {
                                                        searchCurrencyController
                                                            .clear();
                                                      }),
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          20.0,
                                                          15.0,
                                                          20.0,
                                                          15.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  10.0)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                    borderSide:
                                                        BorderSide(
                                                      color: Color(
                                                          0xff2979FB),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(
                                                          right: 10),
                                                  child: Observer(
                                                    builder: (_) {
                                                      return RawScrollbar(
                                                        controller:
                                                            _scrollController,
                                                        thickness: 8,
                                                        thumbColor: settingsStore
                                                                .isDarkTheme
                                                            ? Color(
                                                                0xff3A3A45)
                                                            : Color(
                                                                0xffC2C2C2),
                                                        radius: Radius
                                                            .circular(
                                                                10.0),
                                                        thumbVisibility:
                                                            true,
                                                        child: ListView
                                                            .builder(
                                                                itemCount:
                                                                    FiatCurrency
                                                                        .all
                                                                        .length,
                                                                //shrinkWrap: true,
                                                                controller:
                                                                    _scrollController,
                                                                itemBuilder:
                                                                    (BuildContext context,
                                                                        int index) {
                                                                  return currencyFilter == null ||
                                                                          currencyFilter == ''
                                                                      ? currencyDropDownListItem(settingsStore, index)
                                                                      : '${FiatCurrency.all[index]}'.toLowerCase().contains(currencyFilter!.toLowerCase())
                                                                          ? currencyDropDownListItem(settingsStore, index)
                                                                          : Container();
                                                                }),
                                                      );
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 7, right: 10),
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                searchCurrencyController
                                                    .clear();
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  child:
                                                      Icon(Icons.close)),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }));
                  },
                  title: t.settings_currency,
                  widget: Observer(
                      builder: (_) => Text(
                            settingsStore.fiatCurrency.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.06 /
                                        3,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryTextTheme.headline6?.color),
                          )),
                ),
                //Fee priority
                SettingsTextListRow(
                  onTaped: () async {
                    await showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return WillPopScope(
                            onWillPop: () {
                              return Future.value(false);
                            },
                            child: Dialog(
                              surfaceTintColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(15),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height *
                                        0.75 /
                                        3,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: settingsStore.isDarkTheme
                                        ? Color(0xff272733)
                                        : Color(0xffFFFFFF),
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Fee Priority',
                                            style: TextStyle(
                                              backgroundColor: Colors.transparent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            itemCount:
                                                BeldexTransactionPriority
                                                    .all.length,
                                            shrinkWrap: true,
                                            controller: _scrollController,
                                            itemBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return InkWell(
                                                onTap: () async {
                                                  final settingsStore =
                                                      context.read<
                                                          SettingsStore>();
                                                  if (BeldexTransactionPriority
                                                          .all[index] != null) {
                                                    await settingsStore
                                                        .setCurrentTransactionPriority(
                                                            priority:
                                                                BeldexTransactionPriority
                                                                        .all[
                                                                    index]);
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10)),
                                                    elevation:
                                                        0.0,
                                                    color: settingsStore
                                                                .transactionPriority ==
                                                            BeldexTransactionPriority
                                                                    .all[
                                                                index]
                                                        ? Color(
                                                            0xff2979FB)
                                                        : Colors
                                                            .transparent,
                                                    child: Container(
                                                        width:
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                        padding: EdgeInsets
                                                            .only(
                                                                top: 15,
                                                                bottom:
                                                                    15),
                                                        child: Observer(
                                                          builder: (_) =>
                                                              Text(
                                                            BeldexTransactionPriority
                                                                .all[
                                                                    index]
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: TextStyle(
                                                                backgroundColor: Colors.transparent,
                                                                fontSize:
                                                                    14,
                                                                color: settingsStore.transactionPriority !=
                                                                        BeldexTransactionPriority.all[
                                                                            index]
                                                                    ? Colors.grey.withOpacity(
                                                                        0.6)
                                                                    : Color(
                                                                        0xffffffff),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 7, right: 10),
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.close),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  title: t.settings_fee_priority,
                  widget: Observer(
                      builder: (_) => Text(
                            settingsStore.transactionPriority.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.06 /
                                        3,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryTextTheme.headline6?.color),
                          )),
                ),
                //Save recipient address
                SettingsSwitchListRow(
                  title: t.settings_save_recipient_address,
                ),
              ],
            ),
            //Personal Header
            NewNavListHeader(title: t.settings_personal),
            Column(
              children: [
                //Change PIN
                Theme(
                  data: ThemeData(
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    title: Text(t.settings_change_pin,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.06 / 3,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6!
                                .color)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xff3F3F4D),
                    ),
                    onTap: () {
                        Navigator.of(context).pushNamed(Routes.auth,
                            arguments: (bool isAuthenticatedSuccessfully,
                                    AuthPageState auth) =>
                                isAuthenticatedSuccessfully
                                    ? Navigator.of(context).popAndPushNamed(
                                        Routes.setupPin,
                                        arguments:
                                            (BuildContext setupPinContext,
                                                    String _) =>
                                                Navigator.of(context).pop())
                                    : null);
                    },
                  ),
                ),
                //Change Language
                Theme(
                  data: ThemeData(
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    title: Text(t.change_language,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.06 / 3,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryTextTheme.headline6?.color)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xff3F3F4D),
                    ),
                    onTap: () {
                        Navigator.pushNamed(context, Routes.changeLanguage);
                    },
                  ),
                ),
                //Allow biometric authentication
                SettingsSwitchListRow(
                  title: Platform.isAndroid
                      ? t.settings_allow_biometric_authentication
                      : _availableBiometrics.contains(BiometricType.face)
                          ? t.allowFaceIdAuthentication
                          : t.settings_allow_biometric_authentication,
                ),
                //Dark mode
                SettingsSwitchListRow(
                  title: t.settings_dark_mode,
                ),
              ],
            ),
            //Support Header
            NewNavListHeader(title: t.settings_support),
            Column(
              children: [
                Theme(
                  data: ThemeData(
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    title: Text(t.settings_terms_and_conditions,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.06 / 3,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryTextTheme.headline6?.color)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xff3F3F4D),
                    ),
                    onTap: () {
                        Navigator.pushNamed(context, Routes.disclaimer);
                    },
                  ),
                ),
                //FAQ
                Theme(
                  data: ThemeData(
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    title: Text(t.faq,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.06 / 3,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryTextTheme.headline6?.color)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xff3F3F4D),
                    ),
                    onTap: () {
                        Navigator.pushNamed(context, Routes.faq);
                    },
                  ),
                ),
                //Channel log
                Theme(
                  data: ThemeData(
                    splashColor: Colors.grey,
                    highlightColor: Colors.grey,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                    title: Text(t.changelog,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.06 / 3,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryTextTheme.headline6?.color)),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Color(0xff3F3F4D),
                    ),
                    onTap: () {
                        Navigator.pushNamed(context, Routes.changelog);
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: GestureDetector(
                          onTap: () {
                            _launchUrl(_emailUrl);
                          },
                          child: SvgPicture.asset(
                              'assets/images/new-images/mail.svg'))),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: GestureDetector(
                        onTap: () => _launchUrl(_githubUrl),
                        child: SvgPicture.asset(
                            'assets/images/new-images/github.svg')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 10),
                    child: GestureDetector(
                        onTap: () => _launchUrl(_telegramUrl),
                        child: SvgPicture.asset(
                            'assets/images/new-images/telegram.svg')),
                  ),
                  GestureDetector(
                      onTap: () => _launchUrl(_twitterUrl),
                      child: SvgPicture.asset(
                          'assets/images/new-images/twitter.svg')),
                ],
              ),
            ),

            Theme(
              data: ThemeData(
                splashColor: Colors.grey,
                highlightColor: Colors.grey,
              ),
              child: ListTile(
                title: Center(
                  child: Text(t.version(settingsStore.currentVersion),
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff9292A7))),
                ),
              ),
            )
          ],
        ));
  }

  InkWell decimalDropDownListItem(SettingsStore settingsStore, int index) {
    return InkWell(
      onTap: () async {
        searchDecimalController.text = '';
        final settingsStore = context.read<SettingsStore>();

        if (AmountDetail.all[index] != null) {
          await settingsStore.setCurrentBalanceDetail(
              balanceDetail: AmountDetail.all[index]);
        }
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          color: settingsStore.balanceDetail != AmountDetail.all[index]
              ? Colors.transparent
              : Color(0xff2979FB),
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Observer(
                builder: (_) => Text(
                  AmountDetail.all[index].getTitle(tr(context)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          settingsStore.balanceDetail != AmountDetail.all[index]
                              ? Colors.grey.withOpacity(0.6)
                              : Color(0xffffffff),
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }

  InkWell currencyDropDownListItem(SettingsStore settingsStore, int index) {
    return InkWell(
      onTap: () async {
        searchCurrencyController.text = '';
        final settingsStore = context.read<SettingsStore>();

        if (FiatCurrency.all[index] != null) {
          await settingsStore.setCurrentFiatCurrency(
              currency: FiatCurrency.all[index]);
        }
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation:
              settingsStore.fiatCurrency == FiatCurrency.all[index] ? 2.0 : 0.0,
          color: settingsStore.fiatCurrency == FiatCurrency.all[index]
              ? Color(0xff2979FB)
              : Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Observer(
                builder: (_) => Text(
                  FiatCurrency.all[index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          settingsStore.fiatCurrency != FiatCurrency.all[index]
                              ? Colors.grey.withOpacity(0.6)
                              : Color(0xffffffff),
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}