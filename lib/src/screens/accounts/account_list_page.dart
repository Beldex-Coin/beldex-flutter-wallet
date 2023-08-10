import 'package:beldex_wallet/src/screens/accounts/create_account_dialog.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:beldex_wallet/palette.dart';
import 'package:beldex_wallet/routes.dart';
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

    return InkWell(
      onTap: () {
        //await Navigator.of(context).pushNamed(Routes.accountCreation);
        showDialog<void>(context: context, builder: (_)=>CreateAccountDialog());
        accountListStore.updateAccountList();
      },
      child: Container(
       // width: 30,
        //height: 30,
        padding: EdgeInsets.only(right:10),
        // decoration: BoxDecoration(
        //     color: Theme.of(context).cardTheme.shadowColor,//Colors.black,
        //     borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Icon(Icons.add,color:Color(0xff0BA70F),size: 35,)
        // ButtonTheme(
        //   minWidth: double.minPositive,
        //   child: TextButton(
        //       style: ButtonStyle(
        //         //foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
        //         overlayColor:
        //         MaterialStateColor.resolveWith((states) => Colors.transparent),
        //       ),
        //       onPressed: () async {
        //         await Navigator.of(context).pushNamed(Routes.accountCreation);
        //         accountListStore.updateAccountList();
        //       },
        //       child: SvgPicture.asset('assets/images/add.svg',color: Theme.of(context).accentTextTheme.caption.decorationColor,)),
        // ),
      ),
    );
    /*Container(
        width: 28.0,
        height: 28.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).selectedRowColor),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(Icons.add, color: BeldexPalette.teal, size: 22.0),
            ButtonTheme(
              minWidth: 28.0,
              height: 28.0,
              child: FlatButton(
                  shape: CircleBorder(),
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushNamed(Routes.accountCreation);
                    accountListStore.updateAccountList();
                  },
                  child: Offstage()),
            )
          ],
        ));*/
  }

  @override
  Widget body(BuildContext context) {
    final accountListStore = Provider.of<AccountListStore>(context);
    final walletStore = Provider.of<WalletStore>(context);

    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor = Theme.of(context).backgroundColor;
    final settingsStore = Provider.of<SettingsStore>(context);
    return Container(
      margin: EdgeInsets.only(top: 40, left: constants.leftPx, right: constants.rightPx),
      child: Observer(builder: (_) {
        final accounts = accountListStore.accounts;
        return ListView.separated(
            separatorBuilder: (_, index) =>
                Divider(color: Colors.transparent, height: 10.0),
            itemCount: accounts == null ? 0 : accounts.length,
            itemBuilder: (BuildContext context, int index) {
              final account = accounts[index];

              return Observer(builder: (_) {
                final isCurrent = walletStore.account.id == account.id;

                return Container(
                  margin: EdgeInsets.only(left:10,right:10,),
                  padding: EdgeInsets.all(10),
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
                            return CreateAccountDialog(account: account,);
                          });
                          // await Navigator.of(context).pushNamed(
                          //     Routes.accountCreation,
                          //     arguments: account);
                          // await accountListStore.updateAccountList().then((_) {
                          //   if (isCurrent) walletStore.setAccount(accountListStore.accounts[index]);
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
                       
                     /*   if (isCurrent) return;

                        walletStore.setAccount(account);
                        Navigator.of(context).pop();*/
                      },
                      child: Container(
                                               //Color.fromARGB(255, 40, 42, 51),
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
                    ) /*Container(
                      color: isCurrent ? currentColor : notCurrentColor,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              account.label,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline5
                                      .color),
                            ),
                            onTap: () {
                              if (isCurrent) return;

                              walletStore.setAccount(account);
                              Navigator.of(context).pop();
                            },
                          ),
                          Divider(
                            color: Theme.of(context).dividerTheme.color,
                            height: 1.0,
                          )
                        ],
                      ),
                    )*/
                    ,
                  ),
                );
              });
            });
      }),
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
              height: 180,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).are_you_sure,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text(
                        'Do you want to change your\n primary account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18,color: Theme.of(context).primaryTextTheme.caption.color),
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
                            width: 65,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: settingsStore.isDarkTheme ? Color(0xff383848): Color(0xffE8E8E8),//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(fontSize: 18,fontWeight:FontWeight.w800,color: settingsStore.isDarkTheme ?Color(0xff93939B): Color(0xff222222), ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 65,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Color(0xff0BA70F),//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                if (isCurrent) return;

                                walletStore.setAccount(account);
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle(color: Color(0xffffffff),fontSize: 18,fontWeight:FontWeight.w800),
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
