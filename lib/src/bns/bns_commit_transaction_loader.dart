import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../l10n.dart';

class CommitTransactionLoader extends StatelessWidget {
  CommitTransactionLoader({Key? key, required this.sendStore}) : super(key: key);

  final SendStore sendStore;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.of(context).size.height;
    WakelockPlus.enable();
    Future.delayed(const Duration(seconds: 1), () {
      sendStore.commitTransaction();
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
                      padding:
                      const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
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