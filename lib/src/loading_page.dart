import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget{
  final WalletDescription wallet;
  final WalletListStore walletListStore;
  LoadingPage({ Key key, this.wallet,this.walletListStore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    Future.delayed(
        const Duration(milliseconds: 250), () {
      walletListStore.loadWallet(wallet);
      Navigator.of(context).pop();
    });
    return WillPopScope(
      onWillPop:() async =>false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff) ,
        body: Container(
          width: double.infinity,
          color:settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffE8E8E8),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height:150,width:270,
                margin: EdgeInsets.only(left:15,right:15),
                
                decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
              child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),),
              ),
              Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text('Changing Wallet...',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w700)),
              )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }


}