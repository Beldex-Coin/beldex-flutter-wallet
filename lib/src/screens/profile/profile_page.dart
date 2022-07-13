import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/widgets/nav/nav_list_arrow.dart';
import 'package:beldex_wallet/src/widgets/nav/nav_list_header.dart';

import '../../widgets/nav/new_nav_list_arrow.dart';
import '../../widgets/nav/new_nav_list_header.dart';

class ProfilePage extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  Widget leading(BuildContext context) {
    return Container(padding:EdgeInsets.only(top: 12.0,left: 10.0),decoration: BoxDecoration(
      //borderRadius: BorderRadius.circular(10),
      //color: Colors.black,
    ),child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg'));
  }

  @override
  Widget middle(BuildContext context) {

    return Text(
      'Account',
      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),
    ) /*Observer(builder: (_) {
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
    ;
  }
  //Important -->
  /*@override
  Widget trailing(BuildContext context) {
    return SizedBox(
      width: 25,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () => Navigator.of(context).pushNamed(Routes.settings),
          child: Icon(Icons.settings_rounded,
              color: Theme.of(context).primaryTextTheme.caption.color,
              size: 25)),
    );
  }*/

  @override
  Widget body(BuildContext context) => ProfilePageBody(key: _bodyKey);
}

class ProfilePageBody extends StatefulWidget {
  ProfilePageBody({Key key}) : super(key: key);

  @override
  ProfilePageBodyState createState() => ProfilePageBodyState();
}

class ProfilePageBodyState extends State<ProfilePageBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(height: 30,),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            NewNavListArrow(
              balanceVisibility: false,
                decimalVisibility: false,
                currencyVisibility: false,
                feePriorityVisibility: false,
                leading: SvgPicture.asset('assets/images/wallet_svg.svg',width: 25,height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.wallets,
                onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(Routes.walletList);}),
            NewNavListArrow(
                balanceVisibility: false,
                decimalVisibility: false,
                currencyVisibility: false,
                feePriorityVisibility: false,
                leading: SvgPicture.asset('assets/images/settings_svg.svg',width: 25,height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.settings_title,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.settings)),
            NewNavListHeader(title: S.current.wallet_menu),
            /*NewNavListArrow(
                balanceVisibility: false,
                decimalVisibility: false,
                currencyVisibility: false,
                feePriorityVisibility: false,
                leading: SvgPicture.asset('assets/images/stake_svg.svg',width: 25,height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.title_stakes,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.stake)),*/
            NewNavListArrow(
                balanceVisibility: false,
                decimalVisibility: false,
                currencyVisibility: false,
                feePriorityVisibility: false,
                leading: SvgPicture.asset('assets/images/contact_book_svg.svg',width: 25,height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.address_book_menu,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.addressBook)),
            NewNavListArrow(
                balanceVisibility: false,
                decimalVisibility: false,
                currencyVisibility: false,
                feePriorityVisibility: false,
                leading: SvgPicture.asset('assets/images/accounts_svg.svg',width: 25,height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.accounts,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.accountList)),
            //Important -->
            NewNavListHeader(title: S.current.dangerzone),
            NewNavListArrow(
                leading: Icon(Icons.vpn_key_rounded,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.show_keys,
                onTap: () => Navigator.of(context).pushNamed(Routes.auth,
                    arguments: (bool isAuthenticatedSuccessfully,
                            AuthPageState auth) =>
                        isAuthenticatedSuccessfully
                            ? Navigator.of(auth.context)
                                .popAndPushNamed(Routes.dangerzoneKeys)
                            : null)),
            NewNavListArrow(
                leading: Icon(Icons.vpn_key_rounded,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.show_seed,
                onTap: () => Navigator.of(context).pushNamed(Routes.auth,
                    arguments: (bool isAuthenticatedSuccessfully,
                            AuthPageState auth) =>
                        isAuthenticatedSuccessfully
                            ? Navigator.of(auth.context)
                                .popAndPushNamed(Routes.dangerzoneSeed)
                            : null)),
          ],
        ),
      ],
    ));
  }
}
