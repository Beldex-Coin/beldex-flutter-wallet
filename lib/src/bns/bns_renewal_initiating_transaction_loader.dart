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

class BnsRenewalInitiatingTransactionLoader extends StatelessWidget {
  BnsRenewalInitiatingTransactionLoader(
      {Key key, this.mappingYears, this.bnsName, this.sendStore})
      : super(key: key);

  final String mappingYears;
  final String bnsName;
  final SendStore sendStore;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.of(context).size.height;
    Wakelock.enable();
    Future.delayed(const Duration(seconds: 1), () {
      sendStore.createBnsRenewalTransaction(bnsName:bnsName, mappingYears:mappingYears, tPriority: BeldexTransactionPriority.slow);
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
          child: Scaffold(
            body: Container(
                color: settingsStore.isDarkTheme
                    ? Color(0xff171720)
                    : Color(0xffffffff),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).initiatingTransactionTitle,
                      style: TextStyle(
                          fontSize: height * 0.07 / 3,
                          fontWeight: FontWeight.w800,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffEBEBEB)
                              : Color(0xff222222)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
                      child: Text(
                        S.of(context).initiatingTransactionDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: height * 0.07 / 3,
                            fontWeight: FontWeight.w700,
                            color: settingsStore.isDarkTheme
                                ? Color(0xffEBEBEB)
                                : Color(0xff222222)),
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
