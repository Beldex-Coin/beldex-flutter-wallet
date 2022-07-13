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
  Widget leading(BuildContext context) {
    final accountListStore = Provider.of<AccountListStore>(context);

    return Padding(
      padding: const EdgeInsets.only(top:20.0,left: 10,bottom: 5),
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).pushNamed(Routes.accountCreation);
          accountListStore.updateAccountList();
        },
        child: Container(
          width: 25,
          height: 25,
          //padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.shadowColor,//Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ButtonTheme(
            minWidth: double.minPositive,
            child: TextButton(
                style: ButtonStyle(
                  //foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.transparent),
                ),
                onPressed: () async {
                  await Navigator.of(context).pushNamed(Routes.accountCreation);
                  accountListStore.updateAccountList();
                },
                child: SvgPicture.asset('assets/images/add.svg',color: Theme.of(context).accentTextTheme.caption.decorationColor,)),
          ),
        ),
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

                return Slidable(
                  key: Key(account.id.toString()),
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: S.of(context).edit,
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () async {
                        await Navigator.of(context).pushNamed(
                            Routes.accountCreation,
                            arguments: account);
                        // await accountListStore.updateAccountList().then((_) {
                        //   if (isCurrent) walletStore.setAccount(accountListStore.accounts[index]);
                        // });
                      },
                    )
                  ],
                  child: InkWell(
                    onTap: () {
                      onConfirmation(context,walletStore,account,isCurrent);
                   /*   if (isCurrent) return;

                      walletStore.setAccount(account);
                      Navigator.of(context).pop();*/
                    },
                    child: Card(
                      elevation: 5,
                      color: Theme.of(context).cardColor,//Color.fromARGB(255, 40, 42, 51),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(top:3.0,right: 20.0,left: 20.0,bottom: 3.0),
                        child: ListTile(
                            title: Text(
                              account.label,
                              style: TextStyle(
                                  color: isCurrent
                                      ? Theme.of(context).primaryTextTheme.caption.color
                                      : Colors.grey.withOpacity(0.6),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: isCurrent
                                ? Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .button
                                        .backgroundColor,
                                    size: 23.0,
                                  )
                                : null),
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
          return Dialog(
            elevation: 0,
            backgroundColor: Theme.of(context).cardTheme.color,//Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
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
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Do you want to change your primary account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15,color: Theme.of(context).primaryTextTheme.caption.color),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                S.of(context).no,
                                style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Theme.of(context).cardTheme.shadowColor,//Color.fromRGBO(38, 38, 38, 1.0),
                              ),
                              onPressed: () {
                                if (isCurrent) return;

                                walletStore.setAccount(account);
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                S.of(context).yes,
                                style: TextStyle(color: Theme.of(context).primaryTextTheme.caption.color),
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
