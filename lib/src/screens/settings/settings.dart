import 'dart:io';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/balance_display_mode.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/disclaimer/disclaimer_page.dart';
import 'package:beldex_wallet/src/screens/settings/attributes.dart';
import 'package:beldex_wallet/src/screens/settings/items/settings_item.dart';

// Settings widgets
import 'package:beldex_wallet/src/screens/settings/widgets/settings_link_list_row.dart';
import 'package:beldex_wallet/src/screens/settings/widgets/settings_raw_widget_list_row.dart';
import 'package:beldex_wallet/src/screens/settings/widgets/settings_switch_list_row.dart';
import 'package:beldex_wallet/src/screens/settings/widgets/settings_text_list_row.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/crypto_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/widgets/nav/new_nav_list_arrow.dart';
import 'package:beldex_wallet/src/widgets/nav/new_nav_list_header.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends BasePage {
  @override
  String get title => S.current.settings_title;

  @override
  Color get backgroundColor => Palette.lightGrey2;

  @override
  Widget trailing(BuildContext context) {
    return Container(
      child: Icon(
        Icons.settings,
        color: Colors.transparent,
      ),
    );
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
  final _telegramImage = Image.asset('assets/images/Telegram.png');
  final _twitterImage = Image.asset('assets/images/Twitter.png');

  final _emailText = 'support@beldex.io';
  final _telegramText = 't.me/beldexcoin';
  final _twitterText = 'twitter.com/BeldexCoin';
  final _githubText = 'github.com/Beldex-Coin';

  final _emailUrl = 'mailto:support@beldex.io';
  final _telegramUrl = 'https:t.me/beldexcoin';
  final _twitterUrl = 'https:twitter.com/BeldexCoin';
  final _githubUrl = 'https:github.com/Beldex-Coin';

  final _items = <SettingsItem>[];

  void _launchUrl(String url) async {
    print('call _launchURL');
    if (await canLaunch(url)) await launch(url);
  }

  void _setSettingsList() {
    final settingsStore = context.read<SettingsStore>();
    _items.addAll([
      SettingsItem(
          title: S.current.settings_nodes, attribute: Attributes.header),
      SettingsItem(
          onTaped: () => Navigator.of(context).pushNamed(Routes.nodeList),
          title: S.current.settings_current_node,
          widget: Observer(
              builder: (_) => Text(
                    settingsStore.node == null ? '' : settingsStore.node.uri,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color),
                  )),
          attribute: Attributes.arrow),
      SettingsItem(
          title: S.current.settings_wallets, attribute: Attributes.header),
      SettingsItem(
          onTaped: () => _setBalance(context),
          title: S.current.settings_display_balance_as,
          widget: Observer(
              builder: (_) => Text(
                    settingsStore.balanceDisplayMode.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color),
                  )),
          attribute: Attributes.link),
      SettingsItem(
          onTaped: () => _setBalanceDetail(context),
          title: S.current.settings_balance_detail,
          widget: Observer(
              builder: (_) => Text(
                    settingsStore.balanceDetail.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color),
                  )),
          attribute: Attributes.widget),
      SettingsItem(
          title: S.current.settings_enable_fiat_currency,
          attribute: Attributes.switcher),
      SettingsItem(
          onTaped: () => _setCurrency(context),
          title: S.current.settings_currency,
          widget: Observer(
              builder: (_) => Text(
                    settingsStore.fiatCurrency.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color),
                  )),
          attribute: Attributes.widget),
      SettingsItem(
          onTaped: () => _setTransactionPriority(context),
          title: S.current.settings_fee_priority,
          widget: Observer(
              builder: (_) => Text(
                    settingsStore.transactionPriority.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            Theme.of(context).primaryTextTheme.headline6.color),
                  )),
          attribute: Attributes.widget),
      SettingsItem(
          title: S.current.settings_save_recipient_address,
          attribute: Attributes.switcher),
      SettingsItem(
          title: S.current.settings_personal, attribute: Attributes.header),
      SettingsItem(
          onTaped: () {
            Navigator.of(context).pushNamed(Routes.auth,
                arguments: (bool isAuthenticatedSuccessfully,
                        AuthPageState auth) =>
                    isAuthenticatedSuccessfully
                        ? Navigator.of(context).popAndPushNamed(Routes.setupPin,
                            arguments:
                                (BuildContext setupPinContext, String _) =>
                                    Navigator.of(context).pop())
                        : null);
          },
          title: S.current.settings_change_pin,
          attribute: Attributes.arrow),
      SettingsItem(
          onTaped: () => Navigator.pushNamed(context, Routes.changeLanguage),
          title: S.current.settings_change_language,
          attribute: Attributes.arrow),
      SettingsItem(
          title: S.current.settings_allow_biometric_authentication,
          attribute: Attributes.switcher),
      SettingsItem(
          title: S.current.settings_dark_mode, attribute: Attributes.switcher),
      SettingsItem(
          title: S.current.settings_support, attribute: Attributes.header),
      SettingsItem(
          onTaped: () => _launchUrl(_emailUrl),
          title: 'Email',
          link: _emailText,
          image: null,
          attribute: Attributes.link),
      SettingsItem(
          onTaped: () => _launchUrl(_githubUrl),
          title: 'Github',
          link: _githubText,
          image: null,
          attribute: Attributes.link),
      SettingsItem(
          onTaped: () => _launchUrl(_telegramUrl),
          title: 'Telegram',
          link: _telegramText,
          image: _telegramImage,
          attribute: Attributes.link),
      SettingsItem(
          onTaped: () => _launchUrl(_twitterUrl),
          title: 'Twitter',
          link: _twitterText,
          image: _twitterImage,
          attribute: Attributes.link),
      SettingsItem(
          onTaped: () {
            Navigator.push(
                context,
                CupertinoPageRoute<void>(
                    builder: (BuildContext context) => DisclaimerPage()));
          },
          title: S.current.settings_terms_and_conditions,
          attribute: Attributes.arrow),
      SettingsItem(
          onTaped: () => Navigator.pushNamed(context, Routes.faq),
          title: S.current.faq,
          attribute: Attributes.arrow),
      SettingsItem(
          onTaped: () => Navigator.pushNamed(context, Routes.changelog),
          title: S.current.changelog,
          attribute: Attributes.arrow)
    ]);
    setState(() {});
  }

  void _afterLayout(dynamic _) => _setSettingsList();

  TextEditingController searchDecimalController = TextEditingController();
  TextEditingController searchCurrencyController = TextEditingController();

  //TextEditingController searchFeePriorityController = TextEditingController();
  String decimalFilter;
  String currencyFilter;

  //String feePriorityFilter;

  LocalAuthentication auth;
  List<BiometricType> _availableBiometrics = <BiometricType>[];
  StateSetter _searchCurrencySetState;

  @override
  void initState() {
    auth = LocalAuthentication();
    //-->
    _getAvailableBiometrics();
    super.initState();
    searchDecimalController.addListener(() {
      setState(() {
        decimalFilter = searchDecimalController.text;
      });
    });
    searchCurrencyController.addListener(() {
      _searchCurrencySetState(() {
        currencyFilter = searchCurrencyController.text;
      });
    });
    /*searchFeePriorityController.addListener(() {
      setState(() {
        feePriorityFilter = searchFeePriorityController.text;
      });
    });*/
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
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
    //searchFeePriorityController.dispose();
    super.dispose();
  }

  Widget _getWidget(SettingsItem item) {
    switch (item.attribute) {
      case Attributes.arrow:
        return NewNavListArrow(
          onTap: item.onTaped,
          text: item.title,
        );
      case Attributes.header:
        return NewNavListHeader(title: item.title);
      case Attributes.link:
        return SettingsLinktListRow(
          onTaped: item.onTaped,
          title: item.title,
          link: item.link,
          image: item.image,
        );
      case Attributes.switcher:
        return SettingsSwitchListRow(
          title: item.title,
          balanceVisibility: balanceVisibility,
          decimalVisibility: decimalVisibility,
          currencyVisibility: currencyVisibility,
          feePriorityVisibility: feePriorityVisibility,
        );
      case Attributes.widget:
        return SettingsTextListRow(
          onTaped: item.onTaped,
          title: item.title,
          widget: item.widget,
        );
      case Attributes.rawWidget:
        return SettingRawWidgetListRow(widgetBuilder: item.widgetBuilder);
      default:
        return Offstage();
    }
  }

  var language = 'english';

  bool balanceVisibility = false;
  bool decimalVisibility = false;
  bool currencyVisibility = false;
  bool feePriorityVisibility = false;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final _scrollController = ScrollController(keepScrollOffset: true);
    return SingleChildScrollView(
        child: Stack(
      children: [
        Column(
          children: <Widget>[
            //Nodes Header
            NewNavListHeader(
              title: S.current.settings_nodes,
            ),
            //Current Node
            GestureDetector(
              onTap: () {
                if (balanceVisibility == false &&
                    decimalVisibility == false &&
                    currencyVisibility == false &&
                    feePriorityVisibility == false) {
                  Navigator.of(context).pushNamed(Routes.nodeList);
                }
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(S.current.settings_current_node,
                            style: TextStyle(
                                //fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.06 /
                                    3)),
                        settingsStore.node == null
                            ? Container()
                            : Observer(builder: (_) {
                                return Text(settingsStore.node.uri,
                                    style: TextStyle(
                                        color: Color(0xff1BB71F),
                                        fontSize: 13));
                              })
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 30,
                      color: Color(0xff3F3F4D),
                    ),
                  ],
                ),
              ),
            ),

            // NewNavListArrow(
            //  // leading: SizedBox.shrink(),
            //   balanceVisibility: balanceVisibility,
            //   decimalVisibility: decimalVisibility,
            //   currencyVisibility: currencyVisibility,
            //   feePriorityVisibility: feePriorityVisibility,
            //   onTap: () {
            //     if (balanceVisibility == false &&
            //         decimalVisibility == false &&
            //         currencyVisibility == false &&
            //         feePriorityVisibility == false) {
            //       Navigator.of(context).pushNamed(Routes.nodeList);
            //     }
            //   },
            //   text: S.current.settings_current_node,
            //   size: 15,
            // ),
            //Wallets Header
            NewNavListHeader(title: S.current.settings_wallets),
            Card(
              //  margin: EdgeInsets.only(left: constants.leftPx, right: constants.rightPx, top: 20),
              elevation: 0, //2,
              color: Colors
                  .transparent, //Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Column(
                    children: [
                      //Display Balance as
                      SettingsTextListRow(
                        balanceVisibility: balanceVisibility,
                        decimalVisibility: decimalVisibility,
                        currencyVisibility: currencyVisibility,
                        feePriorityVisibility: feePriorityVisibility,
                        onTaped: () async {
                          await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.90 /
                                        3, // 210,
                                    //margin: EdgeInsets.only(top: 50,left:15,right:15),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       blurRadius: 1,
                                        //       spreadRadius: 1,
                                        //       offset: Offset(0.0, 2.0))
                                        // ],
                                        //border: Border.all(color:Colors.white),
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff272733)
                                            : Color(
                                                0xffFFFFFF), //Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
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
                                                'Display balance as',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    // fontFamily: 'Poppinsbold',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            // Divider(
                                            //   height: 1,
                                            //   color:Theme.of(context).dividerColor,
                                            // ),
                                            // Padding(
                                            //   padding: EdgeInsets.all(8.0),
                                            //   child: TextField(
                                            //     controller: searchDecimalController,
                                            //     decoration: InputDecoration(
                                            //       hintText: 'Search Decimals',
                                            //       contentPadding:
                                            //           EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                            //       border: OutlineInputBorder(
                                            //           borderRadius: BorderRadius.circular(10.0)),
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: BalanceDisplayMode
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
                                                        // if (balanceVisibility == false) {
                                                        //   setState(() {
                                                        //     balanceVisibility = true;
                                                        //   });
                                                        // } else {
                                                        //   setState(() {
                                                        //     balanceVisibility = false;
                                                        //   });
                                                        // }
                                                        if (BalanceDisplayMode
                                                                .all[index] !=
                                                            null) {
                                                          await settingsStore
                                                              .setCurrentBalanceDisplayMode(
                                                                  balanceDisplayMode:
                                                                      BalanceDisplayMode
                                                                              .all[
                                                                          index]);
                                                        }
                                                        Navigator.pop(context);
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
                                                                    .all[index]
                                                            ? Color(
                                                                0xff2979FB) //Theme.of(context).backgroundColor
                                                            : Colors
                                                                .transparent,
                                                        child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15,
                                                                    bottom: 15),
                                                            child: Observer(
                                                              builder: (_) =>
                                                                  Text(
                                                                BalanceDisplayMode
                                                                    .all[index]
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: settingsStore.balanceDisplayMode !=
                                                                            BalanceDisplayMode.all[
                                                                                index]
                                                                        ? Colors
                                                                            .grey
                                                                            .withOpacity(
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
                                                // if (decimalVisibility == false) {
                                                //   setState(() {
                                                //     decimalVisibility = true;
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     decimalVisibility = false;
                                                //   });
                                                // }
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      //color: Theme.of(context).accentTextTheme.caption.decorationColor,
                                                      shape: BoxShape.circle),
                                                  child: Icon(Icons.close)),
                                            ))
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   height:MediaQuery.of(context).size.height*1/3,
                                  //   width:MediaQuery.of(context).size.width*2/3,
                                  //   child:Column(
                                  //     children: [
                                  //       Padding(
                                  //         padding: const EdgeInsets.all(8.0),
                                  //         child: Container(
                                  //          child:Row(children: [
                                  //          Text('Display balance as',style: TextStyle(
                                  //                                 fontSize: 18,
                                  //                                 fontWeight: FontWeight.bold,
                                  //                             ),),
                                  //           Icon(Icons.close),
                                  //          ],)
                                  //         ),
                                  //       ),
                                  //       DraggableScrollbar.rrect(
                                  //                              // padding:
                                  //                                 //  EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                                  //                               controller: _scrollController,
                                  //                               heightScrollThumb: 25,
                                  //                               //alwaysVisibleScrollThumb: true,
                                  //                               backgroundColor: Theme.of(context)
                                  //                                   .primaryTextTheme
                                  //                                   .button
                                  //                                   .backgroundColor,
                                  //                               child: ListView.builder(
                                  //                                   itemCount: BalanceDisplayMode.all.length,
                                  //                                   shrinkWrap: true,
                                  //                                   controller: _scrollController,
                                  //                                   itemBuilder: (BuildContext context, int index) {
                                  //                                     return InkWell(
                                  //                                       onTap: () async {
                                  //                                         final settingsStore =
                                  //                                             context.read<SettingsStore>();
                                  //                                         // if (balanceVisibility == false) {
                                  //                                         //   setState(() {
                                  //                                         //     balanceVisibility = true;
                                  //                                         //   });
                                  //                                         // } else {
                                  //                                         //   setState(() {
                                  //                                         //     balanceVisibility = false;
                                  //                                         //   });
                                  //                                         // }
                                  //                                         Navigator.pop(context);
                                  //                                         if (BalanceDisplayMode.all[index] != null) {
                                  //                                           await settingsStore
                                  //                                               .setCurrentBalanceDisplayMode(
                                  //                                                   balanceDisplayMode:
                                  //                                                       BalanceDisplayMode.all[index]);
                                  //                                         }
                                  //                                       },
                                  //                                       child: Padding(
                                  //                                         padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                  //                                         child: Card(
                                  //                                           shape: RoundedRectangleBorder(
                                  //                                               borderRadius: BorderRadius.circular(10)),
                                  //                                           elevation: settingsStore.balanceDisplayMode ==
                                  //                                                   BalanceDisplayMode.all[index]
                                  //                                               ? 2.0
                                  //                                               : 0.0,
                                  //                                           color: settingsStore.balanceDisplayMode ==
                                  //                                                   BalanceDisplayMode.all[index]
                                  //                                               ? Theme.of(context).backgroundColor
                                  //                                               : Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
                                  //                                           child: Container(
                                  //                                               width: MediaQuery.of(context).size.width,
                                  //                                               padding:
                                  //                                                   EdgeInsets.only(top: 15, bottom: 15),
                                  //                                               child: Observer(
                                  //                                                 builder: (_) => Text(
                                  //                                                   BalanceDisplayMode.all[index]
                                  //                                                       .toString(),
                                  //                                                   textAlign: TextAlign.center,
                                  //                                                   style: TextStyle(
                                  //                                                       fontSize: 14,
                                  //                                                       color: settingsStore
                                  //                                                                   .balanceDisplayMode !=
                                  //                                                               BalanceDisplayMode
                                  //                                                                   .all[index]
                                  //                                                           ? Colors.grey.withOpacity(0.6)
                                  //                                                           : Theme.of(context)
                                  //                                                               .primaryTextTheme
                                  //                                                               .headline6
                                  //                                                               .color,
                                  //                                                       fontWeight: FontWeight.bold),
                                  //                                                 ),
                                  //                                               )),
                                  //                                         ),
                                  //                                       ),
                                  //                                     );
                                  //                                   }),
                                  //                             ),
                                  //     ],
                                  //   ),
                                  // ),
                                );
                              });

                          // if (balanceVisibility == false &&
                          //     decimalVisibility == false &&
                          //     currencyVisibility == false &&
                          //     feePriorityVisibility == false) {
                          //   _setBalance(context);
                          // }
                        },
                        title: S.current.settings_display_balance_as,
                        widget: Observer(
                            builder: (_) => Text(
                                  settingsStore.balanceDisplayMode.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06 /
                                              3, //14.0,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color),
                                )),
                      ),
                      //Decimals
                      SettingsTextListRow(
                        balanceVisibility: balanceVisibility,
                        decimalVisibility: decimalVisibility,
                        currencyVisibility: currencyVisibility,
                        feePriorityVisibility: feePriorityVisibility,
                        onTaped: () async {
                          // if (balanceVisibility == false &&
                          //     decimalVisibility == false &&
                          //     currencyVisibility == false &&
                          //     feePriorityVisibility == false) {
                          //   _setBalanceDetail(context);
                          // }
                          await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        3, // 210,
                                    // margin: EdgeInsets.only(top: 50,left:15,right:15),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       blurRadius: 1,
                                        //       spreadRadius: 1,
                                        //       offset: Offset(0.0, 2.0))
                                        // ],
                                        //border: Border.all(color:Colors.white),
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff272733)
                                            : Color(
                                                0xffFFFFFF), //Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
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
                                                    fontSize: 18,
                                                    fontFamily: 'Poppinsbold',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: DraggableScrollbar.rrect(
                                                padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                    top: 10,
                                                    bottom: 10),
                                                controller: _scrollController,
                                                heightScrollThumb: 25,
                                                alwaysVisibleScrollThumb: false,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryTextTheme
                                                        .button
                                                        .backgroundColor,
                                                child: ListView.builder(
                                                    itemCount:
                                                        AmountDetail.all.length,
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
                                                                      decimalFilter
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
                                                // if (decimalVisibility == false) {
                                                //   setState(() {
                                                //     decimalVisibility = true;
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     decimalVisibility = false;
                                                //   });
                                                // }
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      //color: Theme.of(context).accentTextTheme.caption.decorationColor,
                                                      shape: BoxShape.circle),
                                                  child: Icon(Icons.close)),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        title: S.current.settings_balance_detail,
                        widget: Observer(
                            builder: (_) => Text(
                                  settingsStore.balanceDetail.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06 /
                                              3, //14.0,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color),
                                )),
                      ),
                      //Enable fiat currency conversation
                      SettingsSwitchListRow(
                        title: S.current.settings_enable_fiat_currency,
                        balanceVisibility: balanceVisibility,
                        decimalVisibility: decimalVisibility,
                        currencyVisibility: currencyVisibility,
                        feePriorityVisibility: feePriorityVisibility,
                      ),
                      //Currency
                      SettingsTextListRow(
                        balanceVisibility: balanceVisibility,
                        decimalVisibility: decimalVisibility,
                        currencyVisibility: currencyVisibility,
                        feePriorityVisibility: feePriorityVisibility,
                        onTaped: () async {
                          // if (balanceVisibility == false &&
                          //     decimalVisibility == false &&
                          //     currencyVisibility == false &&
                          //     feePriorityVisibility == false) {
                          //   _setCurrency(context);
                          // }

                          await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                _searchCurrencySetState = setState;
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        3,
                                    // margin: EdgeInsets.only(top: 190),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       blurRadius: 1,
                                      //       spreadRadius: 1,
                                      //       offset: Offset(0.0, 2.0))
                                      // ],
                                      // border: Border.all(color:Colors.white),
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff272733)
                                            : Color(
                                            0xffFFFFFF), //Color.fromARGB(255, 31, 32, 39),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Currency',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppinsbold'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller:
                                                searchCurrencyController,
                                                decoration: InputDecoration(
                                                  hintText: 'Search Currency',
                                                  suffixIcon: IconButton(icon: Icon(Icons.close,color: settingsStore.isDarkTheme
                                                      ? Color(0xffffffff):Color(0xff171720),), onPressed: (){
                                                    searchCurrencyController.clear();
                                                  }),
                                                  contentPadding:
                                                  EdgeInsets.fromLTRB(20.0,
                                                      15.0, 20.0, 15.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    borderSide: BorderSide(
                                                      color: Color(0xff2979FB),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  padding:
                                                  EdgeInsets.only(right: 10),
                                                  child: Observer(builder: (_){
                                                    return  RawScrollbar(
                                                      controller: _scrollController,
                                                      thickness: 8,
                                                      thumbColor:
                                                      settingsStore.isDarkTheme
                                                          ? Color(0xff3A3A45)
                                                          : Color(0xffC2C2C2),
                                                      radius: Radius.circular(10.0),
                                                      isAlwaysShown: true,
                                                      child: ListView.builder(
                                                          itemCount: FiatCurrency
                                                              .all.length,
                                                          //shrinkWrap: true,
                                                          controller:
                                                          _scrollController,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                              int index) {
                                                            return currencyFilter ==
                                                                null ||
                                                                currencyFilter ==
                                                                    ''
                                                                ? currencyDropDownListItem(
                                                                settingsStore,
                                                                index)
                                                                : '${FiatCurrency.all[index]}'
                                                                .toLowerCase()
                                                                .contains(
                                                                currencyFilter
                                                                    .toLowerCase())
                                                                ? currencyDropDownListItem(
                                                                settingsStore,
                                                                index)
                                                                : Container();
                                                          }),
                                                    );
                                                  },)

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
                                                // if (currencyVisibility == false) {
                                                //   setState(() {
                                                //     currencyVisibility = true;
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     currencyVisibility = false;
                                                //   });
                                                // }
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                //decoration: BoxDecoration(
                                                // color: Theme.of(context).accentTextTheme.caption.decorationColor,
                                                //shape: BoxShape.circle
                                                //  ),
                                                  child: Icon(Icons.close)),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              }));
                        },
                        title: S.current.settings_currency,
                        widget: Observer(
                            builder: (_) => Text(
                                  settingsStore.fiatCurrency.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06 /
                                              3, //14.0,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color),
                                )),
                      ),
                      //Fee priority
                      SettingsTextListRow(
                        balanceVisibility: balanceVisibility,
                        decimalVisibility: decimalVisibility,
                        currencyVisibility: currencyVisibility,
                        feePriorityVisibility: feePriorityVisibility,
                        onTaped: () async {
                          // if (balanceVisibility == false &&
                          //     decimalVisibility == false &&
                          //     currencyVisibility == false &&
                          //     feePriorityVisibility == false) {
                          //   _setTransactionPriority(context);
                          // }

                          await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.all(15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.70 /
                                        3,
                                    // margin: EdgeInsets.only(top: 190),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //       blurRadius: 1,
                                        //       spreadRadius: 1,
                                        //       offset: Offset(0.0, 2.0))
                                        // ],
                                        // border: Border.all(color:Colors.white),
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff272733)
                                            : Color(
                                                0xffFFFFFF), //Color.fromARGB(255, 31, 32, 39),
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
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppinsbold'),
                                              ),
                                            ),
                                            // Divider(
                                            //   height: 1,
                                            //   color: Theme.of(context).dividerColor,
                                            // ),
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
                                                      // if (feePriorityVisibility == false) {
                                                      //   setState(() {
                                                      //     feePriorityVisibility = true;
                                                      //   });
                                                      // } else {
                                                      //   setState(() {
                                                      //     feePriorityVisibility = false;
                                                      //   });
                                                      // }

                                                      if (BeldexTransactionPriority
                                                              .all[index] !=
                                                          null) {
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
                                                      padding: EdgeInsets.only(
                                                          left: 20.0,
                                                          right: 20.0),
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        elevation:
                                                            //  settingsStore
                                                            //             .transactionPriority ==
                                                            //         BeldexTransactionPriority.all[index]
                                                            //     ? 2.0
                                                            //     :
                                                            0.0,
                                                        color: settingsStore
                                                                    .transactionPriority ==
                                                                BeldexTransactionPriority
                                                                    .all[index]
                                                            ? Color(
                                                                0xff2979FB) //Theme.of(context).backgroundColor
                                                            : Colors
                                                                .transparent, //Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
                                                        child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15,
                                                                    bottom: 15),
                                                            child: Observer(
                                                              builder: (_) =>
                                                                  Text(
                                                                BeldexTransactionPriority
                                                                    .all[index]
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: settingsStore.transactionPriority !=
                                                                            BeldexTransactionPriority.all[
                                                                                index]
                                                                        ? Colors
                                                                            .grey
                                                                            .withOpacity(
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
                                                // if (feePriorityVisibility == false) {
                                                //   setState(() {
                                                //     feePriorityVisibility = true;
                                                //   });
                                                // } else {
                                                //   setState(() {
                                                //     feePriorityVisibility = false;
                                                //   });
                                                // }
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.close),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        title: S.current.settings_fee_priority,
                        widget: Observer(
                            builder: (_) => Text(
                                  settingsStore.transactionPriority.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.06 /
                                              3, //14.0,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .color),
                                )),
                      ),
                      //Save recipient address
                      SettingsSwitchListRow(
                        title: S.current.settings_save_recipient_address,
                        balanceVisibility: balanceVisibility,
                        decimalVisibility: decimalVisibility,
                        currencyVisibility: currencyVisibility,
                        feePriorityVisibility: feePriorityVisibility,
                      ),
                    ],
                  ),
                  //Display Balance as DropDown List
                  Visibility(
                    visible: false, //balanceVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2.0))
                          ],
                          border: Border.all(color: Colors.white),
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline6
                              .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Display balance as',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              DraggableScrollbar.rrect(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 10),
                                controller: _scrollController,
                                heightScrollThumb: 25,
                                //alwaysVisibleScrollThumb: true,
                                backgroundColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button
                                    .backgroundColor,
                                child: ListView.builder(
                                    itemCount: BalanceDisplayMode.all.length,
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () async {
                                          final settingsStore =
                                              context.read<SettingsStore>();
                                          if (balanceVisibility == false) {
                                            setState(() {
                                              balanceVisibility = true;
                                            });
                                          } else {
                                            setState(() {
                                              balanceVisibility = false;
                                            });
                                          }

                                          if (BalanceDisplayMode.all[index] !=
                                              null) {
                                            await settingsStore
                                                .setCurrentBalanceDisplayMode(
                                                    balanceDisplayMode:
                                                        BalanceDisplayMode
                                                            .all[index]);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: settingsStore
                                                        .balanceDisplayMode ==
                                                    BalanceDisplayMode
                                                        .all[index]
                                                ? 2.0
                                                : 0.0,
                                            color: settingsStore
                                                        .balanceDisplayMode ==
                                                    BalanceDisplayMode
                                                        .all[index]
                                                ? Theme.of(context)
                                                    .backgroundColor
                                                : Theme.of(context)
                                                    .accentTextTheme
                                                    .headline6
                                                    .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.only(
                                                    top: 15, bottom: 15),
                                                child: Observer(
                                                  builder: (_) => Text(
                                                    BalanceDisplayMode
                                                        .all[index]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: settingsStore
                                                                    .balanceDisplayMode !=
                                                                BalanceDisplayMode
                                                                    .all[index]
                                                            ? Colors.grey
                                                                .withOpacity(
                                                                    0.6)
                                                            : Theme.of(context)
                                                                .primaryTextTheme
                                                                .headline6
                                                                .color,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 7, right: 10),
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  if (balanceVisibility == false) {
                                    setState(() {
                                      balanceVisibility = true;
                                    });
                                  } else {
                                    setState(() {
                                      balanceVisibility = false;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .caption
                                            .decorationColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.close,
                                    )),
                              ))
                        ],
                      ),
                    ),
                  ),
                  //Decimals DropDown List
                  /*Visibility(
                    visible: decimalVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2.0))
                          ],
                          color: Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child: DraggableScrollbar.rrect(
                        padding:
                            EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                        controller: _scrollController,
                        heightScrollThumb: 25,
                        alwaysVisibleScrollThumb: true,
                        backgroundColor: Theme.of(context)
                            .primaryTextTheme
                            .button
                            .backgroundColor,
                        child: ListView.builder(
                            itemCount: AmountDetail.all.length,
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  final settingsStore =
                                      context.read<SettingsStore>();
                                  if (decimalVisibility == false) {
                                    setState(() {
                                      decimalVisibility = true;
                                    });
                                  } else {
                                    setState(() {
                                      decimalVisibility = false;
                                    });
                                  }

                                  if (AmountDetail.all[index] != null) {
                                    await settingsStore.setCurrentBalanceDetail(
                                        balanceDetail: AmountDetail.all[index]);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    elevation: settingsStore.balanceDetail ==
                                            AmountDetail.all[index]
                                        ? 2.0
                                        : 0.0,
                                    color: settingsStore.balanceDetail ==
                                            AmountDetail.all[index]
                                        ? Theme.of(context).backgroundColor
                                        : Color.fromARGB(255, 31, 32, 39),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding:
                                            EdgeInsets.only(top: 15, bottom: 15),
                                        child: Observer(
                                          builder: (_) => Text(
                                            AmountDetail.all[index].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: settingsStore
                                                            .balanceDetail !=
                                                        AmountDetail.all[index]
                                                    ? Colors.grey.withOpacity(0.6)
                                                    : Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline6
                                                        .color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),*/
                  Visibility(
                    visible: decimalVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height:
                          MediaQuery.of(context).size.height * 1 / 3, // 210,
                      margin: EdgeInsets.only(top: 50, left: 15, right: 15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //       blurRadius: 1,
                          //       spreadRadius: 1,
                          //       offset: Offset(0.0, 2.0))
                          // ],
                          //border: Border.all(color:Colors.white),
                          color: settingsStore.isDarkTheme
                              ? Color(0xff272733)
                              : Color(
                                  0xffFFFFFF), //Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Decimals',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppinsbold',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Divider(
                              //   height: 1,
                              //   color:Theme.of(context).dividerColor,
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: TextField(
                              //     controller: searchDecimalController,
                              //     decoration: InputDecoration(
                              //       hintText: 'Search Decimals',
                              //       contentPadding:
                              //           EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              //       border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(10.0)),
                              //     ),
                              //   ),
                              // ),
                              Expanded(
                                child: DraggableScrollbar.rrect(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 10, bottom: 10),
                                  controller: _scrollController,
                                  heightScrollThumb: 25,
                                  alwaysVisibleScrollThumb: false,
                                  backgroundColor: Theme.of(context)
                                      .primaryTextTheme
                                      .button
                                      .backgroundColor,
                                  child: ListView.builder(
                                      itemCount: AmountDetail.all.length,
                                      //shrinkWrap: true,
                                      controller: _scrollController,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return decimalFilter == null ||
                                                decimalFilter == ''
                                            ? decimalDropDownListItem(
                                                settingsStore, index)
                                            : '${AmountDetail.all[index]}'
                                                    .toLowerCase()
                                                    .contains(decimalFilter
                                                        .toLowerCase())
                                                ? decimalDropDownListItem(
                                                    settingsStore, index)
                                                : Container();
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 7, right: 10),
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  if (decimalVisibility == false) {
                                    setState(() {
                                      decimalVisibility = true;
                                    });
                                  } else {
                                    setState(() {
                                      decimalVisibility = false;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        //color: Theme.of(context).accentTextTheme.caption.decorationColor,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.close)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  //Currency DropDown List
                  /*Visibility(
                    visible: currencyVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      margin: EdgeInsets.only(top: 190),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2.0))
                          ],
                          color: Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child: DraggableScrollbar.rrect(
                        padding:
                            EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                        controller: _scrollController,
                        heightScrollThumb: 25,
                        alwaysVisibleScrollThumb: true,
                        backgroundColor: Theme.of(context)
                            .primaryTextTheme
                            .button
                            .backgroundColor,
                        child: ListView.builder(
                            itemCount: FiatCurrency.all.length,
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  final settingsStore =
                                      context.read<SettingsStore>();
                                  if (currencyVisibility == false) {
                                    setState(() {
                                      currencyVisibility = true;
                                    });
                                  } else {
                                    setState(() {
                                      currencyVisibility = false;
                                    });
                                  }

                                  if (FiatCurrency.all[index] != null) {
                                    await settingsStore.setCurrentFiatCurrency(
                                        currency: FiatCurrency.all[index]);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    elevation: settingsStore.fiatCurrency ==
                                            FiatCurrency.all[index]
                                        ? 2.0
                                        : 0.0,
                                    color: settingsStore.fiatCurrency ==
                                            FiatCurrency.all[index]
                                        ? Theme.of(context).backgroundColor
                                        : Color.fromARGB(255, 31, 32, 39),
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding:
                                            EdgeInsets.only(top: 15, bottom: 15),
                                        child: Observer(
                                          builder: (_) => Text(
                                            FiatCurrency.all[index].toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: settingsStore.fiatCurrency !=
                                                        FiatCurrency.all[index]
                                                    ? Colors.grey.withOpacity(0.6)
                                                    : Theme.of(context)
                                                        .primaryTextTheme
                                                        .headline6
                                                        .color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),*/

                  Visibility(
                    visible: currencyVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 210,
                      margin: EdgeInsets.only(top: 190),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2.0))
                          ],
                          border: Border.all(color: Colors.white),
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline6
                              .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Currency',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: searchCurrencyController,
                                  decoration: InputDecoration(
                                    hintText: 'Search Currency',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: DraggableScrollbar.rrect(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 10, bottom: 10),
                                  controller: _scrollController,
                                  heightScrollThumb: 25,
                                  alwaysVisibleScrollThumb: true,
                                  backgroundColor: Theme.of(context)
                                      .primaryTextTheme
                                      .button
                                      .backgroundColor,
                                  child: ListView.builder(
                                      itemCount: FiatCurrency.all.length,
                                      //shrinkWrap: true,
                                      controller: _scrollController,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return currencyFilter == null ||
                                                currencyFilter == ''
                                            ? currencyDropDownListItem(
                                                settingsStore, index)
                                            : '${FiatCurrency.all[index]}'
                                                    .toLowerCase()
                                                    .contains(currencyFilter
                                                        .toLowerCase())
                                                ? currencyDropDownListItem(
                                                    settingsStore, index)
                                                : Container();
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 7, right: 10),
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  if (currencyVisibility == false) {
                                    setState(() {
                                      currencyVisibility = true;
                                    });
                                  } else {
                                    setState(() {
                                      currencyVisibility = false;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .caption
                                            .decorationColor,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.close)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  //Fee Priority DropDown List
                  Visibility(
                    visible: feePriorityVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      margin: EdgeInsets.only(top: 240),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2.0))
                          ],
                          border: Border.all(color: Colors.white),
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline6
                              .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Fee Priority',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppinsbold'),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Theme.of(context).dividerColor,
                              ),
                              DraggableScrollbar.rrect(
                                padding: EdgeInsets.only(
                                    left: 5, right: 5, top: 10, bottom: 10),
                                controller: _scrollController,
                                heightScrollThumb: 25,
                                //alwaysVisibleScrollThumb: true,
                                backgroundColor: Theme.of(context)
                                    .accentTextTheme
                                    .headline6
                                    .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                                child: ListView.builder(
                                    itemCount:
                                        BeldexTransactionPriority.all.length,
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () async {
                                          final settingsStore =
                                              context.read<SettingsStore>();
                                          if (feePriorityVisibility == false) {
                                            setState(() {
                                              feePriorityVisibility = true;
                                            });
                                          } else {
                                            setState(() {
                                              feePriorityVisibility = false;
                                            });
                                          }

                                          if (BeldexTransactionPriority
                                                  .all[index] !=
                                              null) {
                                            await settingsStore
                                                .setCurrentTransactionPriority(
                                                    priority:
                                                        BeldexTransactionPriority
                                                            .all[index]);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: settingsStore
                                                        .transactionPriority ==
                                                    BeldexTransactionPriority
                                                        .all[index]
                                                ? 2.0
                                                : 0.0,
                                            color: settingsStore
                                                        .transactionPriority ==
                                                    BeldexTransactionPriority
                                                        .all[index]
                                                ? Theme.of(context)
                                                    .backgroundColor
                                                : Theme.of(context)
                                                    .accentTextTheme
                                                    .headline6
                                                    .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.only(
                                                    top: 15, bottom: 15),
                                                child: Observer(
                                                  builder: (_) => Text(
                                                    BeldexTransactionPriority
                                                        .all[index]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: settingsStore
                                                                    .transactionPriority !=
                                                                BeldexTransactionPriority
                                                                    .all[index]
                                                            ? Colors.grey
                                                                .withOpacity(
                                                                    0.6)
                                                            : Theme.of(context)
                                                                .primaryTextTheme
                                                                .headline6
                                                                .color,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 7, right: 10),
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  if (feePriorityVisibility == false) {
                                    setState(() {
                                      feePriorityVisibility = true;
                                    });
                                  } else {
                                    setState(() {
                                      feePriorityVisibility = false;
                                    });
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .caption
                                            .decorationColor,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.close)),
                              ))
                        ],
                      ),
                    ),
                  )
                  /*Visibility(
                    visible: feePriorityVisibility,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 175,
                      margin: EdgeInsets.only(top: 240),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2.0))
                          ],
                          color: Color.fromARGB(255, 31, 32, 39),
                          borderRadius: BorderRadius.circular(10)),
                      child:Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchFeePriorityController,
                              decoration: InputDecoration(
                                hintText: 'Search Fee Priority',
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: DraggableScrollbar.rrect(
                              padding:
                              EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                              controller: _scrollController,
                              heightScrollThumb: 25,
                              alwaysVisibleScrollThumb: true,
                              backgroundColor: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .backgroundColor,
                              child: ListView.builder(
                                  itemCount: BeldexTransactionPriority.all.length,
                                  //shrinkWrap: true,
                                  controller: _scrollController,
                                  itemBuilder: (BuildContext context, int index) {
                                    return feePriorityFilter == null || feePriorityFilter == ''?InkWell(
                                      onTap: () async {
                                        searchFeePriorityController.text='';
                                        final settingsStore =
                                        context.read<SettingsStore>();
                                        if (feePriorityVisibility == false) {
                                          setState(() {
                                            feePriorityVisibility = true;
                                          });
                                        } else {
                                          setState(() {
                                            feePriorityVisibility = false;
                                          });
                                        }

                                        if (BeldexTransactionPriority.all[index] != null) {
                                          await settingsStore
                                              .setCurrentTransactionPriority(
                                              priority:
                                              BeldexTransactionPriority.all[index]);
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          elevation: settingsStore.transactionPriority ==
                                              BeldexTransactionPriority.all[index]
                                              ? 2.0
                                              : 0.0,
                                          color: settingsStore.transactionPriority ==
                                              BeldexTransactionPriority.all[index]
                                              ? Theme.of(context).backgroundColor
                                              : Color.fromARGB(255, 31, 32, 39),
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding:
                                              EdgeInsets.only(top: 15, bottom: 15),
                                              child: Observer(
                                                builder: (_) => Text(
                                                  BeldexTransactionPriority.all[index]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: settingsStore
                                                          .transactionPriority !=
                                                          BeldexTransactionPriority
                                                              .all[index]
                                                          ? Colors.grey.withOpacity(0.6)
                                                          : Theme.of(context)
                                                          .primaryTextTheme
                                                          .headline6
                                                          .color,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ):'${BeldexTransactionPriority.all[index]}'                              .toLowerCase()
                                        .contains(feePriorityFilter.toLowerCase())?InkWell(
                                      onTap: () async {
                                        searchFeePriorityController.text='';
                                        final settingsStore =
                                        context.read<SettingsStore>();
                                        if (feePriorityVisibility == false) {
                                          setState(() {
                                            feePriorityVisibility = true;
                                          });
                                        } else {
                                          setState(() {
                                            feePriorityVisibility = false;
                                          });
                                        }

                                        if (BeldexTransactionPriority.all[index] != null) {
                                          await settingsStore
                                              .setCurrentTransactionPriority(
                                              priority:
                                              BeldexTransactionPriority.all[index]);
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)),
                                          elevation: settingsStore.transactionPriority ==
                                              BeldexTransactionPriority.all[index]
                                              ? 2.0
                                              : 0.0,
                                          color: settingsStore.transactionPriority ==
                                              BeldexTransactionPriority.all[index]
                                              ? Theme.of(context).backgroundColor
                                              : Color.fromARGB(255, 31, 32, 39),
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding:
                                              EdgeInsets.only(top: 15, bottom: 15),
                                              child: Observer(
                                                builder: (_) => Text(
                                                  BeldexTransactionPriority.all[index]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: settingsStore
                                                          .transactionPriority !=
                                                          BeldexTransactionPriority
                                                              .all[index]
                                                          ? Colors.grey.withOpacity(0.6)
                                                          : Theme.of(context)
                                                          .primaryTextTheme
                                                          .headline6
                                                          .color,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ):Container();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )*/
                ],
              ),
            ),
            //Personal Header
            NewNavListHeader(title: S.current.settings_personal),
            Card(
              // margin: EdgeInsets.only(left: constants.leftPx, right: constants.rightPx, top: 20),
              elevation: 0, //2,
              color: Colors
                  .transparent, // Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  //Change PIN
                  Theme(
                    data: ThemeData(
                      splashColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                      highlightColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      title: Text(S.current.settings_change_pin,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  0.06 /
                                  3, //14.0,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color)),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Color(0xff3F3F4D),
                      ),
                      onTap: () {
                        if (balanceVisibility == false &&
                            decimalVisibility == false &&
                            currencyVisibility == false &&
                            feePriorityVisibility == false) {
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
                        }
                      },
                    ),
                  ),
                  //Change Language
                  Theme(
                    data: ThemeData(
                      splashColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                      highlightColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      title: Text(S.current.change_language,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  0.06 /
                                  3, //14.0,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color)),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Color(0xff3F3F4D),
                      ),
                      onTap: () {
                        if (balanceVisibility == false &&
                            decimalVisibility == false &&
                            currencyVisibility == false &&
                            feePriorityVisibility == false) {
                          Navigator.pushNamed(context, Routes.changeLanguage);
                        }
                      },
                    ),
                  ),
                  //Allow biometric authentication
                  SettingsSwitchListRow(
                    title: Platform.isAndroid
                        ? S.current.settings_allow_biometric_authentication
                        : _availableBiometrics.contains(BiometricType.face)
                            ? 'Allow face id authentication'
                            : S.current.settings_allow_biometric_authentication,
                    balanceVisibility: balanceVisibility,
                    decimalVisibility: decimalVisibility,
                    currencyVisibility: currencyVisibility,
                    feePriorityVisibility: feePriorityVisibility,
                  ),
                  //Dark mode
                  SettingsSwitchListRow(
                    title: S.current.settings_dark_mode,
                    balanceVisibility: balanceVisibility,
                    decimalVisibility: decimalVisibility,
                    currencyVisibility: currencyVisibility,
                    feePriorityVisibility: feePriorityVisibility,
                  ),
                ],
              ),
            ),
            //Support Header
            NewNavListHeader(title: S.current.settings_support),
            Card(
              //margin: EdgeInsets.only(left: constants.leftPx, right: constants.rightPx, top: 20),
              elevation: 0, //2,
              color: Colors
                  .transparent, // Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  //Email
                  // SettingsLinktListRow(
                  //   balanceVisibility: balanceVisibility,
                  //   decimalVisibility: decimalVisibility,
                  //   currencyVisibility: currencyVisibility,
                  //   feePriorityVisibility: feePriorityVisibility,
                  //   onTaped: () {
                  //     if (balanceVisibility == false &&
                  //         decimalVisibility == false &&
                  //         currencyVisibility == false &&
                  //         feePriorityVisibility == false) {
                  //       _launchUrl(_emailUrl);
                  //     }
                  //   },
                  //   title: 'Email',
                  // ),
                  //Github
                  // SettingsLinktListRow(
                  //   balanceVisibility: balanceVisibility,
                  //   decimalVisibility: decimalVisibility,
                  //   currencyVisibility: currencyVisibility,
                  //   feePriorityVisibility: feePriorityVisibility,
                  //   onTaped: () {
                  //     if (balanceVisibility == false &&
                  //         decimalVisibility == false &&
                  //         currencyVisibility == false &&
                  //         feePriorityVisibility == false) {
                  //       _launchUrl(_githubUrl);
                  //     }
                  //   },
                  //   title: 'Github',
                  // ),
                  //Telegram
                  // SettingsLinktListRow(
                  //   balanceVisibility: balanceVisibility,
                  //   decimalVisibility: decimalVisibility,
                  //   currencyVisibility: currencyVisibility,
                  //   feePriorityVisibility: feePriorityVisibility,
                  //   onTaped: () {
                  //     if (balanceVisibility == false &&
                  //         decimalVisibility == false &&
                  //         currencyVisibility == false &&
                  //         feePriorityVisibility == false) {
                  //       _launchUrl(_telegramUrl);
                  //     }
                  //   },
                  //   title: 'Telegram',
                  // ),
                  //Twitter
                  // SettingsLinktListRow(
                  //   balanceVisibility: balanceVisibility,
                  //   decimalVisibility: decimalVisibility,
                  //   currencyVisibility: currencyVisibility,
                  //   feePriorityVisibility: feePriorityVisibility,
                  //   onTaped: () {
                  //     if (balanceVisibility == false &&
                  //         decimalVisibility == false &&
                  //         currencyVisibility == false &&
                  //         feePriorityVisibility == false) {
                  //       _launchUrl(_twitterUrl);
                  //     }
                  //   },
                  //   title: 'Twitter',
                  // ),
                  //Terms and conditions
                  Theme(
                    data: ThemeData(
                      splashColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                      highlightColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      title: Text(S.current.settings_terms_and_conditions,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  0.06 /
                                  3, //14.0,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color)),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Color(0xff3F3F4D),
                      ),
                      onTap: () {
                        if (balanceVisibility == false &&
                            decimalVisibility == false &&
                            currencyVisibility == false &&
                            feePriorityVisibility == false) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      DisclaimerPage()));
                        }
                      },
                    ),
                  ),
                  //FAQ
                  Theme(
                    data: ThemeData(
                      splashColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                      highlightColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      title: Text(S.current.faq,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  0.06 /
                                  3, //14.0,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color)),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Color(0xff3F3F4D),
                      ),
                      onTap: () {
                        if (balanceVisibility == false &&
                            decimalVisibility == false &&
                            currencyVisibility == false &&
                            feePriorityVisibility == false) {
                          Navigator.pushNamed(context, Routes.faq);
                        }
                      },
                    ),
                  ),
                  //Channel log
                  Theme(
                    data: ThemeData(
                      splashColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                      highlightColor: balanceVisibility == false &&
                              decimalVisibility == false &&
                              currencyVisibility == false &&
                              feePriorityVisibility == false
                          ? Colors.grey
                          : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                      title: Text(S.current.changelog,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  0.06 /
                                  3, //14.0,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .color)),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Color(0xff3F3F4D),
                      ),
                      onTap: () {
                        if (balanceVisibility == false &&
                            decimalVisibility == false &&
                            currencyVisibility == false &&
                            feePriorityVisibility == false) {
                          Navigator.pushNamed(context, Routes.changelog);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            /*ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  var _isDrawDivider = true;

                  if (item.attribute == Attributes.header || item == _items.last) {
                    _isDrawDivider = false;
                  } else {
                    if (_items[index + 1].attribute == Attributes.header) {
                      _isDrawDivider = false;
                    }
                  }

                  return Column(
                    children: <Widget>[
                      _getWidget(item),
                      _isDrawDivider
                          ? Container(
                              color: Theme.of(context)
                                  .accentTextTheme
                                  .headline5
                                  .backgroundColor,
                              padding: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Divider(
                                color: Theme.of(context).dividerColor,
                                height: 1.0,
                              ),
                            )
                          : Offstage()
                    ],
                  );
                }),*/

            Container(
              width: double.infinity,
              height: 40,
              //color: Colors.yellow,
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
                splashColor: balanceVisibility == false &&
                        decimalVisibility == false &&
                        currencyVisibility == false &&
                        feePriorityVisibility == false
                    ? Colors.grey
                    : Colors.transparent,
                highlightColor: balanceVisibility == false &&
                        decimalVisibility == false &&
                        currencyVisibility == false &&
                        feePriorityVisibility == false
                    ? Colors.grey
                    : Colors.transparent,
              ),
              child: ListTile(
                //contentPadding: EdgeInsets.only(left: 60.0),
                title: Center(
                  child: Text(S.current.version(settingsStore.currentVersion),
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff9292A7))),
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: false,
          child: Positioned(
            left: 0,
            right: 0,
            bottom: 575,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 210,
              margin: EdgeInsets.only(left: 40, right: 40),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0.0, 2.0))
                  ],
                  border: Border.all(color: Colors.white),
                  color: Theme.of(context)
                      .accentTextTheme
                      .headline6
                      .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Display balance as',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor,
                  ),
                  DraggableScrollbar.rrect(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                    controller: _scrollController,
                    heightScrollThumb: 25,
                    //alwaysVisibleScrollThumb: true,
                    backgroundColor: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .backgroundColor,
                    child: ListView.builder(
                        itemCount: BalanceDisplayMode.all.length,
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              final settingsStore =
                                  context.read<SettingsStore>();
                              if (balanceVisibility == false) {
                                setState(() {
                                  balanceVisibility = true;
                                });
                              } else {
                                setState(() {
                                  balanceVisibility = false;
                                });
                              }

                              if (BalanceDisplayMode.all[index] != null) {
                                await settingsStore
                                    .setCurrentBalanceDisplayMode(
                                        balanceDisplayMode:
                                            BalanceDisplayMode.all[index]);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: settingsStore.balanceDisplayMode ==
                                        BalanceDisplayMode.all[index]
                                    ? 2.0
                                    : 0.0,
                                color: settingsStore.balanceDisplayMode ==
                                        BalanceDisplayMode.all[index]
                                    ? Theme.of(context).backgroundColor
                                    : Theme.of(context)
                                        .accentTextTheme
                                        .headline6
                                        .backgroundColor, //Color.fromARGB(255, 31, 32, 39),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: Observer(
                                      builder: (_) => Text(
                                        BalanceDisplayMode.all[index]
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: settingsStore
                                                        .balanceDisplayMode !=
                                                    BalanceDisplayMode
                                                        .all[index]
                                                ? Colors.grey.withOpacity(0.6)
                                                : Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline6
                                                    .color,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> _setBalance(BuildContext context) async {
    /*final settingsStore = context.read<SettingsStore>();
    final selectedDisplayMode =
        await presentPicker(context, BalanceDisplayMode.all);

    if (selectedDisplayMode != null) {
      await settingsStore.setCurrentBalanceDisplayMode(
          balanceDisplayMode: selectedDisplayMode);
    }*/
    if (balanceVisibility == false) {
      setState(() {
        balanceVisibility = true;
      });
    }
  }

  Future<void> _setBalanceDetail(BuildContext context) async {
    /* final settingsStore = context.read<SettingsStore>();
    final balanceDetail = await presentPicker(context, AmountDetail.all);

    if (balanceDetail != null) {
      await settingsStore.setCurrentBalanceDetail(balanceDetail: balanceDetail);
    }*/
    if (decimalVisibility == false) {
      setState(() {
        decimalVisibility = true;
      });
    }
  }

  Future<void> _setCurrency(BuildContext context) async {
    /*final settingsStore = context.read<SettingsStore>();
    final selectedCurrency = await presentPicker(context, FiatCurrency.all);

    if (selectedCurrency != null) {
      await settingsStore.setCurrentFiatCurrency(currency: selectedCurrency);
    }*/
    if (currencyVisibility == false) {
      setState(() {
        currencyVisibility = true;
      });
    }
  }

  Future<void> _setTransactionPriority(BuildContext context) async {
    /*final settingsStore = context.read<SettingsStore>();
    final selectedPriority =
        await presentPicker(context, BeldexTransactionPriority.all);

    if (selectedPriority != null) {
      await settingsStore.setCurrentTransactionPriority(
          priority: selectedPriority);
    }*/
    if (feePriorityVisibility == false) {
      setState(() {
        feePriorityVisibility = true;
      });
    }
  }

  InkWell decimalDropDownListItem(SettingsStore settingsStore, int index) {
    return InkWell(
      onTap: () async {
        searchDecimalController.text = '';
        final settingsStore = context.read<SettingsStore>();
        // if (decimalVisibility == false) {
        //   setState(() {
        //     decimalVisibility = true;
        //   });
        // } else {
        //   setState(() {
        //     decimalVisibility = false;
        //   });
        // }

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
          // settingsStore.balanceDetail == AmountDetail.all[index]
          //     ? 2.0
          //     : 0.0,
          color: settingsStore.balanceDetail != AmountDetail.all[index]
              ? Colors.transparent
              : Color(0xff2979FB), //Color.fromARGB(255, 31, 32, 39),
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Observer(
                builder: (_) => Text(
                  AmountDetail.all[index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: settingsStore.balanceDetail !=
                              AmountDetail.all[index]
                          ? Colors.grey.withOpacity(0.6)
                          : Color(
                              0xffffffff), //Theme.of(context).primaryTextTheme.headline6.color,
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
        // if (currencyVisibility == false) {
        //   setState(() {
        //     currencyVisibility = true;
        //   });
        // } else {
        //   setState(() {
        //     currencyVisibility = false;
        //   });
        // }

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
              : Colors.transparent, //Theme.of(context).backgroundColor
          //Theme.of(context).accentTextTheme.headline6.backgroundColor,//Color.fromARGB(255, 31, 32, 39),
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Observer(
                builder: (_) => Text(
                  FiatCurrency.all[index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: settingsStore.fiatCurrency !=
                              FiatCurrency.all[index]
                          ? Colors.grey.withOpacity(0.6)
                          : Color(
                              0xffffffff), //Theme.of(context).primaryTextTheme.headline6.color,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
}
