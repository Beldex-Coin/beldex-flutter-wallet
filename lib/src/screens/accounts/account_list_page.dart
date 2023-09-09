import 'package:beldex_wallet/src/screens/accounts/create_account_dialog.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/account_list/account_list_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/util/constants.dart' as constants;

class AccountListPage extends BasePage {
  @override
  String get title => S.current.accounts;

  @override
  Widget trailing(BuildContext context) {
    final accountListStore = Provider.of<AccountListStore>(context);
    final accounts = accountListStore.accounts;

    return Container(
      padding: EdgeInsets.only(right:15),
      child: IconButton(icon: SvgPicture.asset('assets/images/new-images/add_account.svg',width: 23,height: 23,),onPressed: () {
        showDialog<void>(context: context, builder: (_)=>CreateAccountDialog(accList: accounts,));
        accountListStore.updateAccountList();
      },)
    );
  }

  @override
  Widget body(BuildContext context) {
    final accountListStore = Provider.of<AccountListStore>(context);
    final walletStore = Provider.of<WalletStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
      final _controller = ScrollController(keepScrollOffset: true);
    return Column(
         crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
           height:MediaQuery.of(context).size.height*1/3,
        decoration: BoxDecoration(
         color: settingsStore.isDarkTheme ? Color(0xff272733): Color(0xffEDEDED),
         borderRadius: BorderRadius.circular(10)
        ),
          margin: EdgeInsets.only(top: 40, left: constants.leftPx, right: constants.rightPx),
            padding: EdgeInsets.only(bottom: 10),
          child: Observer(builder: (_) {
            final accounts = accountListStore.accounts;
            return RawScrollbar(
               controller: _controller,
              thickness: 8,
              thumbColor: settingsStore.isDarkTheme ? Color(0xff3A3A45) : Color(0xffC2C2C2),
              radius: Radius.circular(10.0),
              isAlwaysShown: true,
              child: ListView.builder(
                   controller: _controller,
                  itemCount: accounts == null ? 0 : accounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final account = accounts[index];

                    return Observer(builder: (_) {
                      final isCurrent = walletStore.account.id == account.id;

                      return Container(
                         padding: EdgeInsets.only(left:10,right:10,top:10),
                        decoration: BoxDecoration(  
                          color: settingsStore.isDarkTheme ? Color(0xff272733): Color(0xffEDEDED),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Slidable(
                          key: Key(account.id.toString()),
                          actionPane: SlidableDrawerActionPane(),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: S.of(context).edit,
                              color: Colors.blue,
                              icon: Icons.edit,
                              onTap: (){
                                showDialog<void>(context: context, builder: (_){
                                  return CreateAccountDialog(account: account,accList: accounts,);
                                });
                                // await Navigator.of(context).pushNamed(
                                //     Routes.accountCreation,
                                //     arguments: account);
                                 accountListStore.updateAccountList();//.then((_) {
                                 // if (isCurrent) walletStore.setAccount(accountListStore.accounts[index]);
                               // });
                              },
                            )
                          ],
                          child: InkWell(
                            onTap: () {
                              if(isCurrent){
                                return;
                              }else{
                                 onConfirmation(context,walletStore,account,isCurrent);
                              }
                            },
                            child: Container(
                             decoration: BoxDecoration(
                               color:  settingsStore.isDarkTheme ? isCurrent ? Color(0xff383848) : Color(0xff1B1B23) : Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:EdgeInsets.all(15),
                                child:Text(
                                      account.label,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: isCurrent
                                              ? Color(0xff1AB51E)
                                              : settingsStore.isDarkTheme ? Color(0xff737382) : Color(0xff9292A7),
                                          fontSize: 16.0,

                                          fontWeight: FontWeight.w800),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  }),
            );
          }),
        ),
      ],
    );
  }

  Future<bool> onConfirmation(BuildContext context, WalletStore walletStore, Account account, bool isCurrent) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final settingsStore = Provider.of<SettingsStore>(context);
          return Dialog(
            elevation: 0,
            backgroundColor: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),//Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).are_you_sure,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                      S.of(context).doYouWantToChangeYournPrimaryAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18,color: Theme.of(context).primaryTextTheme.caption.color),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () =>Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                          primary: settingsStore.isDarkTheme ? Color(0xff383848): Color(0xffE8E8E8),
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          S.of(context).no,
                          style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: settingsStore.isDarkTheme ?Color(0xff93939B): Color(0xff222222), ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          if (isCurrent) return;

                          walletStore.setAccount(account);
                          Navigator.of(context).pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff0BA70F),
                          padding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          S.of(context).yes,
                          style: TextStyle(color: Color(0xffffffff),fontSize: 18,fontWeight:FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
