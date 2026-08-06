import 'dart:async';

import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/src/stores/send/send_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class BnsUpdateInitiatingTransactionLoader extends StatefulWidget {
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
  State<BnsUpdateInitiatingTransactionLoader> createState() => _BnsUpdateInitiatingTransactionLoaderState();
}

class _BnsUpdateInitiatingTransactionLoaderState extends State<BnsUpdateInitiatingTransactionLoader> {
  Timer? _timer;
  bool _transactionStarted = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _timer = Timer(const Duration(seconds: 1), () {
      if (!_transactionStarted && mounted) {
        _transactionStarted = true;
        widget.sendStore.createBnsUpdateTransaction(
            owner: widget.owner,
            backUpOwner: widget.backUpOwner,
            walletAddress: widget.walletAddress,
            bchatId: widget.bchatId,
            belnetId: widget.belnetId,
            ethAddress: widget.ethAddress,
            bnsName: widget.bnsName,
            tPriority: BeldexTransactionPriority.slow);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final height = MediaQuery.sizeOf(context).height;

    return PopScope(
      canPop: false,
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
