import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:provider/provider.dart';
import '../../widgets/nav/new_nav_list_arrow.dart';

class ProfilePage extends BasePage {
  final _bodyKey = GlobalKey();

  @override
  String get title => S.current.settings_title;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

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
    final syncStore = Provider.of<SyncStore>(context);
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.4 / 4),
              child: Text(
                S.of(context).wallet,
                style: TextStyle(fontSize: 20.0, color: Color(0xff737385)),
              ),
            ),
            NewNavListArrow(
                isDisable:false,
                leading: SvgPicture.asset('assets/images/new-images/wallet.svg',
                    width: 25,
                    height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.wallets,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Routes.walletList);
                }),
            NewNavListArrow(
                isDisable:false,
                leading: SvgPicture.asset(
                    'assets/images/new-images/wallet_settings.svg',
                    width: 25,
                    height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.of(context).walletSettings,
                onTap: () => Navigator.of(context).pushNamed(Routes.settings)),

            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.4 / 4,
                  top: MediaQuery.of(context).size.width * 0.3 / 3),
              child: Text(
                S.of(context).account,
                style: TextStyle(fontSize: 20.0, color: Color(0xff737385)),
              ),
            ),
            // NewNavListHeader(title: S.current.wallet_menu),
            // NewNavListArrow(
            //     balanceVisibility: false,
            //     decimalVisibility: false,
            //     currencyVisibility: false,
            //     feePriorityVisibility: false,
            //     leading: SvgPicture.asset('assets/images/stake_svg.svg',width: 25,height: 25,
            //         color: Theme.of(context).primaryTextTheme.headline6.color),
            //     text: S.current.title_stakes,
            //     onTap: () =>
            //         Navigator.of(context).pushNamed(Routes.stake)),
            NewNavListArrow(
                isDisable:false,
                leading: SvgPicture.asset(
                    'assets/images/new-images/address_book.svg',
                    width: 25,
                    height: 25,
                    color: Theme.of(context).primaryTextTheme.headline6.color),
                text: S.current.address_book,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.addressBook)),
            NewNavListArrow(
                isDisable: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus ? false : true,
                leading: SvgPicture.asset(
                    'assets/images/new-images/settings_account.svg',
                    width: 25,
                    height: 25,
                    color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus ? Theme.of(context).primaryTextTheme.headline6.color : Colors.grey ),
                text: S.current.accounts,
                onTap: (){
                  if(syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus) {
                    Navigator.of(context).pushNamed(Routes.accountList);
                  }
                }),
            //Important -->
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.4 / 4,
                  top: MediaQuery.of(context).size.width * 0.3 / 3),
              child: Text(
                S.of(context).seedKeys,
                style: TextStyle(fontSize: 20.0, color: Color(0xff737385)),
              ),
            ),
            //NewNavListHeader(title: S.current.dangerzone),
            NewNavListArrow(
                isDisable:syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus ? false : true,
                leading: SvgPicture.asset(
                    'assets/images/new-images/settings_show_keys.svg',
                    width: 25,
                    height: 25,
                    color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus ? Theme.of(context).primaryTextTheme.headline6.color : Colors.grey),
                text: S.current.show_keys,
                onTap: () {
                  if(syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus) {
                    Navigator.of(context).pushNamed(Routes.auth,
                        arguments: (bool isAuthenticatedSuccessfully,
                            AuthPageState auth) =>
                        isAuthenticatedSuccessfully
                            ? Navigator.of(auth.context)
                            .popAndPushNamed(Routes.dangerzoneKeys)
                            : null);
                  }
                }),
            NewNavListArrow(
                isDisable:syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus ? false : true,
                leading: SvgPicture.asset(
                    'assets/images/new-images/settings_show_seed.svg',
                    width: 25,
                    height: 25,
                    color: syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus ? Theme.of(context).primaryTextTheme.headline6.color : Colors.grey),
                text: S.current.show_seed,
                onTap: () {
                  if(syncStore.status is SyncedSyncStatus || syncStore.status.blocksLeft == 0 || syncStore.status is FailedSyncStatus) {
                    Navigator.of(context).pushNamed(Routes.auth,
                        arguments: (bool isAuthenticatedSuccessfully,
                            AuthPageState auth) =>
                        isAuthenticatedSuccessfully
                            ? Navigator.of(auth.context)
                            .popAndPushNamed(Routes.dangerzoneSeed)
                            : null);
                  }
                }),
          ],
        ),
      ],
    ));
  }
}
