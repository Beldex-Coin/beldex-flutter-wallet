import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/widgets/primary_button.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/widgets/scollable_with_bottom_section.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/screens/wallet_list/wallet_menu.dart';
import 'package:beldex_wallet/src/widgets/picker.dart';

class WalletListPage extends BasePage {

  @override
  String get title => S.current.wallet_list_title;

  @override
  Widget leading(BuildContext context) {
    return Container(padding: const EdgeInsets.only(top:12.0,left: 10),decoration: BoxDecoration(
      //borderRadius: BorderRadius.circular(10),
      //color: Colors.black,
    ),child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  }

  @override
  Widget trailing(BuildContext context) {
    final _backButton = Icon(Icons.arrow_back_ios_sharp, size: 28);

    return InkWell(
      onTap: () async {
        Navigator.of(context).pop();
        await Navigator.of(context)
            .pushNamed(Routes.profile);
      },
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Theme.of(context).accentTextTheme.headline6.color,//Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).accentTextTheme.headline6.color,//Colors.black,
              blurRadius:2.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: SizedBox(
          height: 50,
          width: 20,
          child: ButtonTheme(
            minWidth: double.minPositive,
            child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.transparent),
                ),
                onPressed: () => onClose(context),
                child: _backButton),
          ),
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) => WalletListBody();
}

class WalletListBody extends StatefulWidget {
  @override
  WalletListBodyState createState() => WalletListBodyState();
}

class WalletListBodyState extends State<WalletListBody> {
  WalletListStore _walletListStore;

  void presetMenuForWallet(WalletDescription wallet, BuildContext bodyContext) {
    final isCurrentWallet = false;
    final walletMenu = WalletMenu(bodyContext);
    final items = walletMenu.generateItemsForWalletMenu(isCurrentWallet);

    showDialog<void>(
      context: bodyContext,
      builder: (_) =>
          Picker(
              items: items,
              selectedAtIndex: -1,
              title: S.of(context).wallet_menu,
              onItemSelected: (String item) =>
                  walletMenu.action(
                      walletMenu.listItems.indexOf(item), wallet,
                      isCurrentWallet)),
    );
  }

  @override
  Widget build(BuildContext context) {
    _walletListStore = Provider.of<WalletListStore>(context);

    return ScrollableWithBottomSection(
        content: Container(
          margin: EdgeInsets.only(top: 40,),
          child: Observer(
            builder: (_) =>
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, index) =>
                        Divider(color: Colors.transparent,
                            height: 10.0),
                    itemCount: _walletListStore.wallets.length,
                    itemBuilder: (__, index) {
                      final wallet = _walletListStore.wallets[index];
                      final isCurrentWallet =
                      _walletListStore.isCurrentWallet(wallet);

                      return InkWell(
                          onTap: () =>
                          isCurrentWallet
                              ? null
                              : presetMenuForWallet(wallet, context),
                          child: Card(
                            elevation: 5,
                            color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                                title: Text(
                                  wallet.name,
                                  style: TextStyle(
                                      color: isCurrentWallet
                                          ? Theme.of(context).primaryTextTheme.caption.color
                                          : Colors.grey.withOpacity(0.6),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: isCurrentWallet
                                    ? Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryTextTheme.button.backgroundColor,
                                  size: 23.0,
                                )
                                    : null),
                          ));
                    }),
          ),
        ),
        bottomSection: Column(children: <Widget>[
          SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[900],
                              offset: Offset(0.0, 2.0),
                              blurRadius: 2.0)
                        ]),
                    child: SvgPicture.asset('assets/images/create_svg.svg',color: Theme.of(context).primaryTextTheme.button.backgroundColor,width: 20,height: 20,)),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.newWallet);
                },
                label: Padding( padding: const EdgeInsets.only(left:12.0),child: Text(S
                    .of(context)
                    .wallet_list_create_new_wallet,style: TextStyle(fontSize: 16),)),
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    primary: Color.fromARGB(255, 46, 160, 33),
                    padding: EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              )
          ),
          /*PrimaryIconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.newWallet),
              iconData: Icons.add_rounded,
              color: Theme
                  .of(context)
                  .primaryTextTheme
                  .button
                  .backgroundColor,
              borderColor:
              Theme
                  .of(context)
                  .primaryTextTheme
                  .button
                  .decorationColor,
              iconColor: BeldexPalette.teal,
              iconBackgroundColor: Theme
                  .of(context)
                  .primaryIconTheme
                  .color,
              text: S
                  .of(context)
                  .wallet_list_create_new_wallet),*/
          SizedBox(height: 25.0),
          SizedBox(
            width: 250,
            child:
            TextButton.icon(
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color:Theme.of(context).accentTextTheme.caption.decorationColor,
                  ),
                  alignment: Alignment.centerLeft,
                  primary: Theme.of(context)
                      .accentTextTheme
                      .caption
                      .backgroundColor,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(13),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[900],
                            offset: Offset(0.0, 2.0),
                            blurRadius: 2.0)
                      ]),
                  child: SvgPicture.asset('assets/images/clock_svg.svg',color: Theme.of(context).accentTextTheme.caption.decorationColor,width: 20,height: 20,)),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.restoreWalletOptions);
              },
              label: Padding(
                padding: const EdgeInsets.only(left:12.0),
                child: Text(S
                    .of(context)
                    .wallet_list_restore_wallet,style: TextStyle(fontSize: 16,color: Theme.of(context).primaryTextTheme.caption.color),),
              ),
            ),
          ),
         /* PrimaryIconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.restoreWalletOptions),
              iconData: Icons.refresh_rounded,
              text: S
                  .of(context)
                  .wallet_list_restore_wallet,
              color: Theme
                  .of(context)
                  .accentTextTheme
                  .button
                  .backgroundColor,
              borderColor:
              Theme
                  .of(context)
                  .accentTextTheme
                  .button
                  .decorationColor,
              iconColor: Theme
                  .of(context)
                  .primaryTextTheme
                  .caption
                  .color,
              iconBackgroundColor: Theme
                  .of(context)
                  .accentIconTheme
                  .color)*/
        ]));
  }
}
