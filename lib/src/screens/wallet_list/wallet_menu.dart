import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';

class WalletMenu {
  WalletMenu(this.context);

  final BuildContext context;

  void action(int index, WalletDescription wallet) {
    final _walletListStore = context.read<WalletListStore>();

    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(Routes.auth, arguments:
            (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
          if (!isAuthenticatedSuccessfully) {
            return false;
          }

          try {
            auth.close();
            Navigator.of(context).pop(true);
          } catch (e) {
            auth.changeProcessText(S
                .of(context)
                .wallet_list_failed_to_load(wallet.name, e.toString()));
          }
        });
        break;
      case 1:
        Navigator.of(context).pushNamed(Routes.auth, arguments:
            (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
          if (!isAuthenticatedSuccessfully) {
            return;
          }
          auth.close();
          await Navigator.of(context).pushNamed(Routes.seed);
        });
        break;
      case 2:
        showDialog<Dialog>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context1) {
              final settingsStore = Provider.of<SettingsStore>(context);
              return Dialog(
                elevation: 0,
                backgroundColor: settingsStore.isDarkTheme ? Color(0xff272733):Color(0xffffffff),//Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)), //this right here
                child: Container(
                  height: MediaQuery.of(context).size.height*0.85/3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'You are about to delete\n your wallet!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19,fontWeight:FontWeight.w800 ,color: Theme.of(context).primaryTextTheme.caption.color,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text(S.of(context).makeSureToBackupOfYournrecoverySeedWalletAddressnandPrivate,
                           // 'Make sure to take a backup of your Mnemonic seed, wallet address and private keys',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16,color: Theme.of(context).primaryTextTheme.caption.color),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            GestureDetector(
                              onTap: () {
                                    Navigator.of(context1).pop();
                                  },
                              child: Container(
                                  width: 80,
                                  padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                         color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffE8E8E8),
                                       ),
                                    
                                      child:  Text(
                                    S.of(context1).no,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:settingsStore.isDarkTheme ? Color(0xff93939B) : Color(0xff16161D) ,fontWeight:FontWeight.w900),
                                  ),
                                    ),
                                    
                            ),
                               
                            
                              GestureDetector(
                               onTap: () {
                                      Navigator.of(context1).pop();
                                      Navigator.of(context).pushNamed(Routes.auth, arguments:
                                          (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
                                        print('status -->$isAuthenticatedSuccessfully');
                                        if (!isAuthenticatedSuccessfully) {
                                          return;
                                        }
                                        try {
                                          auth.changeProcessText(
                                              S.of(context).wallet_list_removing_wallet(wallet.name));
                                          await _walletListStore.remove(wallet);
                                          auth.close();
                                          Navigator.of(context).pop(false);
                                        } catch (e) {
                                          auth.changeProcessText(S
                                              .of(context)
                                              .wallet_list_failed_to_remove(wallet.name, e.toString()));
                                        }
                                      });
                                    },
                                child: Container(
                                   width: 80,
                                   padding: EdgeInsets.all(15),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff0BA70F),
                                   ),
                                  child: Text(
                                      S.of(context1).yes,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color:Color(0xffffffff),fontWeight:FontWeight.bold),
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
        break;
      case 3:
        Navigator.of(context).pushNamed(Routes.rescan);
        break;
      default:
        break;
    }
  }
}
