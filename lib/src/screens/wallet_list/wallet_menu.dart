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

  final List<String> listItems = [
    S.current.wallet_list_load_wallet,
    S.current.show_seed,
    S.current.remove,
    S.current.rescan
  ];

  List<String> generateItemsForWalletMenu(bool isCurrentWallet) {
    final items = <String>[];

    if (!isCurrentWallet) items.add(listItems[0]);
    if (isCurrentWallet) items.add(listItems[1]);
    if (!isCurrentWallet) items.add(listItems[2]);
    if (isCurrentWallet) items.add(listItems[3]);

    return items;
  }

  void action(int index, WalletDescription wallet, bool isCurrentWallet) {
    final _walletListStore = context.read<WalletListStore>();

    switch (index) {
      case 0:
        Navigator.of(context).pushNamed(Routes.auth, arguments:
            (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
          if (!isAuthenticatedSuccessfully) {
            return;
          }

          try {
            auth.changeProcessText(
                S.of(context).wallet_list_loading_wallet(wallet.name));
            await _walletListStore.loadWallet(wallet);
            auth.close();
            Navigator.of(context).pop();
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
                          'You are about to delete your wallet!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15,color: Theme.of(context).primaryTextTheme.caption.color,),
                        ),
                        Text(
                          'Make sure to take a backup of your Mnemonic seed, wallet address and private keys',
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
                                    Navigator.of(context1).pop();
                                  },
                                  child: Text(
                                    S.of(context1).no,
                                    style: TextStyle(color:Theme.of(context).primaryTextTheme.caption.color),
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
                                      } catch (e) {
                                        auth.changeProcessText(S
                                            .of(context)
                                            .wallet_list_failed_to_remove(wallet.name, e.toString()));
                                      }
                                    });
                                  },
                                  child: Text(
                                    S.of(context1).yes,
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
        break;
      case 3:
        Navigator.of(context).pushNamed(Routes.rescan);
        break;
      default:
        break;
    }
  }
}
