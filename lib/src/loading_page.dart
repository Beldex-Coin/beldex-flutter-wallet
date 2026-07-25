import 'dart:async';

import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/wallet_list/wallet_list_store.dart';
import 'package:beldex_wallet/src/util/screen_sizer.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key, required this.wallet, required this.walletListStore}) : super(key: key);

  final WalletDescription wallet;
  final WalletListStore walletListStore;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer? _timer;
  bool _loadingStarted = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _timer = Timer(const Duration(seconds: 1), () async {
      if (_loadingStarted || !mounted) return;
      _loadingStarted = true;
      try {
        await widget.walletListStore.loadWallet(widget.wallet);
      } finally {
        if (mounted) {
          WakelockPlus.disable();
          Navigator.of(context).pop();
        } else {
          WakelockPlus.disable();
        }
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
    ScreenSize.init(context);
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
                    tr(context).loadingTheWallet,
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: height * 0.07 / 3,
                        fontWeight: FontWeight.w800,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffEBEBEB)
                            : Color(0xff222222)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
                    child: Text(
                      tr(context).loadingTheWalletDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Colors.transparent,
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
