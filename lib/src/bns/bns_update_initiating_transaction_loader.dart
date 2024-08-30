import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class BnsUpdateInitiatingTransactionLoader extends StatelessWidget {
  BnsUpdateInitiatingTransactionLoader(
      {Key? key, required this.owner, required this.backUpOwner, required this.bchatId, required this.walletAddress, required this.belnetId, required this.ethAddress, required this.bnsName, required this.sendStore})
      : super(key: key);

  final String owner;
  final String backUpOwner;
  final String bchatId;
  final String walletAddress;
  final String belnetId;
  final String ethAddress;
  final String bnsName;
  final SendStore sendStore;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.of(context).size.height;
    WakelockPlus.enable();
    Future.delayed(const Duration(seconds: 1), () {
      sendStore.createBnsUpdateTransaction(owner:owner, backUpOwner:backUpOwner, walletAddress:walletAddress, bchatId:bchatId,  belnetId:belnetId, ethAddress:ethAddress, bnsName:bnsName, tPriority: BeldexTransactionPriority.slow);
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
                      tr(context).initiatingTransactionTitle,
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
                        tr(context).initiatingTransactionDescription,
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
