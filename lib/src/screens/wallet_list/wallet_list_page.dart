import 'dart:ui';

import 'package:beldex_wallet/src/screens/wallet_list/wallet_option_dialog.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/screens/wallet_list/wallet_menu.dart';
import '../../loading_page.dart';

class WalletListPage extends BasePage {
  @override
  String getTitle(AppLocalizations t) => t.wallets;


  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) => WalletListBody();
}

class WalletListBody extends StatefulWidget {
  @override
  WalletListBodyState createState() => WalletListBodyState();
}

class WalletListBodyState extends State<WalletListBody> {
  WalletListStore? _walletListStore;
  var isAuthenticatedSuccessfully = false;

  Future<void> presetMenuForWallet(
      WalletDescription wallet, BuildContext bodyContext) async {
    final walletMenu = WalletMenu(bodyContext);

    await showDialog<bool>(
            context: bodyContext,
            builder: (_) => WalletAlertDialog(
                onItemSelected: (int item) => walletMenu.action(item, wallet)))
        .then((value) {
      isAuthenticatedSuccessfully = value!;
    });
  }

  void authStatus(bool value, WalletDescription wallet, BuildContext context) {
    if (value && value != null) {
      isAuthenticatedSuccessfully = false;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute<void>(
              builder: (context) => LoadingPage(
                  wallet: wallet, walletListStore: _walletListStore!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    _walletListStore = Provider.of<WalletListStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final _controller = ScrollController(keepScrollOffset: true);
    return Center(
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 1.1 / 3,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: settingsStore.isDarkTheme
                    ? Color(0xff272733)
                    : Color(0xffEDEDED)),
            child: RawScrollbar(
              controller: _controller,
              thumbVisibility: true,
              thickness: 8,
              thumbColor: settingsStore.isDarkTheme
                  ? Color(0xff3A3A45)
                  : Color(0xffC2C2C2),
              radius: Radius.circular(10.0),
              child: Container(
                margin: EdgeInsets.only(right:8.0),
                child: Observer(
                  builder: (_) => ListView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      itemCount: _walletListStore!.wallets.length,
                      itemBuilder: (__, index) {
                        final wallet = _walletListStore!.wallets[index];
                        final isCurrentWallet =
                            _walletListStore!.isCurrentWallet(wallet);
                        return InkWell(
                            onTap: () async {
                              isCurrentWallet
                                  ? null
                                  : await presetMenuForWallet(wallet, context);
                              await Future.delayed(
                                  const Duration(milliseconds: 400), () {
                                authStatus(
                                    isAuthenticatedSuccessfully, wallet, context);
                              });
                            },
                            child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color: settingsStore.isDarkTheme
                                          ? isCurrentWallet
                                              ? Color(0xff383848)
                                              : Color(0xff1B1B23)
                                          : Color(0xffFFFFFF),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    wallet.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: isCurrentWallet
                                            ? Color(0xff1AB51E)
                                            : settingsStore.isDarkTheme
                                                ? Color(0xff737382)
                                                : Color(0xff9292A7),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                )));
                      }),
                ),
              ),
            ),
          ),
          Column(children: <Widget>[
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 60.0, right: 60),
              child: PrimaryButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(Routes.restoreWalletOptions),
                  text: tr(context).wallet_list_restore_wallet,
                  color: Color(0xff2979FB),
                  borderColor: Color(0xff2979FB)),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 60.0, right: 60),
              child: PrimaryButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.newWallet),
                  text: tr(context).wallet_list_create_new_wallet,
                  color: Color(0xff0BA70F),
                  borderColor: Color(0xff0BA70F)),
            ),
          ])
        ],
      )),
    );
  }
}
