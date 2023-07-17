
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/screens/wallet_list/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
class WalletAlertDialog extends StatefulWidget {
  final WalletDescription wallet;
  List<String> items;
  WalletAlertDialog({ Key key, this.wallet,this.items }) : super(key: key);

  @override
  State<WalletAlertDialog> createState() => _WalletAlertDialogState();
}

class _WalletAlertDialogState extends State<WalletAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final walletMenu = WalletMenu(context);
    final walletListService = Provider.of<WalletListService>(context);
    final walletService = Provider.of<WalletService>(context);
    //final _walletListStore = context.read<WalletListStore>();
    return Provider(
      create: (_)=>  WalletListStore(walletListService:walletListService,walletService: walletService ),
       builder:(context,child){
        final _walletListStore = Provider.of<WalletListStore>(context);
         return AlertDialog(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Change wallet',style: TextStyle(fontWeight:FontWeight.w800))),
       backgroundColor:settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
       content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(onPressed: (){
              //  walletMenu.action(0, widget.wallet, false);



  setState(() {
       Navigator.of(context).pushNamed(Routes.auth, arguments:
            (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
          if (!isAuthenticatedSuccessfully) {
            return;
          }

          try {
            auth.changeProcessText(
                S.of(context).wallet_list_loading_wallet(widget.wallet.name));
            await _walletListStore.loadWallet(widget.wallet);
            auth.close();
            Navigator.of(context)..pop()..pop();
          } catch (e) {
            auth.changeProcessText(S
                .of(context)
                .wallet_list_failed_to_load(widget.wallet.name, e.toString()));
          }
        });

    });
    












        //      Navigator.of(context).pushNamed(Routes.auth, arguments:
        //     (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
        //   if (!isAuthenticatedSuccessfully) {
        //     return;
        //   }

        //   try {
        //     auth.changeProcessText(
        //       //'Loading ${widget.wallet.name} wallet',
        //         S.of(context).wallet_list_loading_wallet(widget.wallet.name)
        //         );
        //     await _walletListStore.loadWallet(widget.wallet);
        //     auth.close();
        //     Navigator.of(context).pop();
        //   } catch (e) {
        //     auth.changeProcessText(
        //       'Failed to load ${widget.wallet.name} wallet. ${e.toString()}'
        //       // S
        //       //   .of(context)
        //       //   .wallet_list_failed_to_load(wallet.name, e.toString())
        //         );
        //   }
        // });
          },
             elevation: 0,
              color: Color(0xff0BA70F),
              height: MediaQuery.of(context).size.height*0.20/3,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
             child: Text('Load wallet',style: TextStyle(fontSize:17,color:Colors.white,fontWeight:FontWeight.w800),),
           ),
           SizedBox(
            height: 10,
           ),
           MaterialButton(onPressed: (){
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
                          child: Text(S.of(context).remove_wallets,
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
                                    Navigator.of(context1)..pop()..pop();
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
                               
                            // Observer(builder: (_){
                            //   return 
                            // }),
                              GestureDetector(
                               onTap: (){
                                      Navigator.of(context1).pop();
                                     // Navigator.of(context1).pop();
                                      Navigator.of(context).pushNamed(Routes.auth, arguments:
                                          (bool isAuthenticatedSuccessfully, AuthPageState auth) async {
                                        print('status -->$isAuthenticatedSuccessfully');
                                        if (!isAuthenticatedSuccessfully) {
                                          return;
                                        }
                                        try {
                                          auth.changeProcessText(
                                              S.of(context).wallet_list_removing_wallet(widget.wallet.name));
                                          await _walletListStore.remove(widget.wallet);
                                         await _walletListStore.updateWalletList();
                                          auth.close();
                                        } catch (e) {
                                          auth.changeProcessText(S
                                              .of(context)
                                              .wallet_list_failed_to_remove(widget.wallet.name, e.toString()));
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
           },
             elevation: 0,
              color: settingsStore.isDarkTheme ? Color(0xff383848) : Color(0xffE8E8E8),
              height: MediaQuery.of(context).size.height*0.20/3,
              minWidth: double.infinity, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              child:Text('Remove wallet',style: TextStyle(fontSize:17,color:settingsStore.isDarkTheme ? Colors.white : Colors.black,fontWeight:FontWeight.w800),),
           ),
           
           
        ],
       ),
    );
       },
    );
    
     
  }
}