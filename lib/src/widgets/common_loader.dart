import 'dart:async';

import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:wakelock/wakelock.dart';
class CommonLoader extends StatelessWidget {
  CommonLoader({Key key, this.address, this.sendStore,this.isFlashTransaction}) : super(key: key);

  final String address;
  final SendStore sendStore;
  final bool isFlashTransaction;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.of(context).size.height;
 Wakelock.enable();
    Future.delayed(const Duration(seconds: 1), (){
      if(isFlashTransaction) {
        sendStore.createTransaction(address: address,tPriority:BeldexTransactionPriority.flash);
      }else{
        sendStore.createTransaction(address: address);
      }
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
          child: Scaffold(
            body: Container(
              color: settingsStore.isDarkTheme
                        ? Color(0xff171720) : Color(0xffffffff),
                  width: double.infinity,
                child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            /*Container(
                height: height * 0.35 / 3,
                width: height * 0.35 / 3,
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
                      S.of(context).initiatingTransactionTitle,
                      style: TextStyle(
                          fontSize: height * 0.07 / 3,fontWeight: FontWeight.w800,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,left:8,right:8),
                      child: Text(
                      S.of(context).initiatingTransactionDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height * 0.07 / 3,fontWeight: FontWeight.w700,color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222)),
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
