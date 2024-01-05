import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/util/screen_sizer.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

import '../l10n.dart';

class LoadingPage extends StatelessWidget{
  LoadingPage({ Key? key, required this.wallet,required this.walletListStore }) : super(key: key);

  final WalletDescription wallet;
  final WalletListStore walletListStore;


  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    ScreenSize.init(context);
    final height = MediaQuery.of(context).size.height;
    Wakelock.enable();
    Future.delayed(const Duration(seconds: 1), () async {
      await walletListStore.loadWallet(wallet);
      Wakelock.disable();
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
           /* Container(
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
                )),*/
            Text(
              tr(context).loadingTheWallet,
              style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontSize: height * 0.07 / 3,fontWeight: FontWeight.w800,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222)),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0,left:8,right:8),
            child: Text(
              tr(context).loadingTheWalletDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontSize: height * 0.07 / 3,fontWeight: FontWeight.w700,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222)),
            ),
          )
            // loadingProvider.setLoadingString != '' ? Text('${loadingProvider.setLoadingString}') : Container()
        ],
      )),
          )),
    );

  }


}