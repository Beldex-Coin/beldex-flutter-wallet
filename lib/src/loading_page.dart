import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/util/screen_sizer.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
class LoadingPage extends StatelessWidget{
  final WalletDescription wallet;
  final WalletListStore walletListStore;
  LoadingPage({ Key key, this.wallet,this.walletListStore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    ScreenSize.init(context);
   // final height = MediaQuery.of(context).size.height;
    Future.delayed(const Duration(seconds: 1), () {
      walletListStore.loadWallet(wallet);
      Navigator.of(context).pop();
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
          child: Scaffold(
            body: Container(
              color: settingsStore.isDarkTheme ?
                        Color(0xff171720) : Color(0xffffffff),
                  width: double.infinity,
                child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Container(
                height: ScreenSize.screenHeight035, //height * 0.35 / 3,
                width: ScreenSize.screenHeight035, //height * 0.35 / 3,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme
                        ? Color(0xff272733)
                        : Color(0xffEDEDED),
                    shape: BoxShape.circle),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xff0BA70F),
                  ),
                  strokeWidth: 6,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                S.of(context).loadingTheWallet,
                style: TextStyle(
                    fontSize:ScreenSize.screenHeight07, //height * 0.07 / 3, 
                  fontWeight: FontWeight.w700,color: settingsStore.isDarkTheme? Colors.white:Colors.black),
              ),
            )
            // loadingProvider.setLoadingString != '' ? Text('${loadingProvider.setLoadingString}') : Container()
        ],
      )),
          )),
    );

  }


}