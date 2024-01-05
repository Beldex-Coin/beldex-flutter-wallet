import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:provider/provider.dart';

import '../../../l10n.dart';

class WalletMenu {
  WalletMenu(this.context)
      : items = [
    tr(context).reconnect,
    tr(context).rescan
  ];

  final List<String> items ;

  final BuildContext context;

  void action(int index) {
    switch (index) {
      case 0:
        _presentReconnectAlert(context);
        break;
      case 1:
        Navigator.of(context).pushNamed(Routes.rescan);
        break;
    }
  }

  Future<void> _presentReconnectAlert(BuildContext context) async {
    final walletStore = context.read<WalletStore>();
    await showReconnectConfirmDialog(
        context, tr(context).reconnection, tr(context).reconnect_alert_text,
        onPressed: (context) {
      walletStore.reconnect();
      Navigator.of(context)..pop()..pop();
        },
      onDismiss:(context)=> null,
    );
  }
}

Future showReconnectConfirmDialog(
    BuildContext context, String title, String body,
    {required void Function(BuildContext context) onPressed,
    required void Function(BuildContext context) onDismiss}) {
  return showDialog<void>(
      builder: (_) => AlertReconnectConfirmDialog(title, body, onDismiss: onDismiss, onPressed: onPressed),
      context: context);
}

class AlertReconnectConfirmDialog extends StatefulWidget {
  const AlertReconnectConfirmDialog(
    this.title,
    this.body, {
    required this.onPressed,
    required this.onDismiss,
  });

  final String title;
  final String body;
  final void Function(BuildContext context) onPressed;
  final void Function(BuildContext context) onDismiss;

  @override
  State<AlertReconnectConfirmDialog> createState() =>
      _AlertReconnectConfirmDialogState();
}

class _AlertReconnectConfirmDialogState
    extends State<AlertReconnectConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Dialog(
        insetPadding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor:
            settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffFFFFFF),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text('${tr(context).reconnectWallet}?',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tr(context).doYouWantToReconnectnTheWallet,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.of(context)..pop()..pop(),
                    elevation: 0,
                    color: settingsStore.isDarkTheme
                        ? Color(0xff383848)
                        : Color(0xffE8E8E8),
                    height: MediaQuery.of(context).size.height * 0.18 / 3,
                    minWidth: MediaQuery.of(context).size.width * 0.89 / 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      tr(context).cancel,
                      style: TextStyle(
                          fontSize: 17,
                          color: settingsStore.isDarkTheme
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => widget.onPressed(context),
                    elevation: 0,
                    color: Color(0xff0BA70F),
                    height: MediaQuery.of(context).size.height * 0.18 / 3,
                    minWidth: MediaQuery.of(context).size.width * 0.89 / 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      tr(context).ok,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}