import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/screens/dashboard/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/util/network_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';

class DashBoardAlertDialog extends StatefulWidget {
  const DashBoardAlertDialog({Key? key}) : super(key: key);

  @override
  State<DashBoardAlertDialog> createState() => _DashBoardAlertDialogState();
}

class _DashBoardAlertDialogState extends State<DashBoardAlertDialog> {
  bool canRescan = true;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final walletMenu = WalletMenu(context);
    final syncStore = Provider.of<SyncStore>(context);
    final networkStatus = Provider.of<NetworkProvider>(context);
    if (!networkStatus.isConnected) {
      setState(() {
        canRescan = false;
      });
    }
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: settingsStore.isDarkTheme
          ? const Color(0xff272733)
          : const Color(0xffFFFFFF),
      surfaceTintColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsetsDirectional.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr(context).rescan,
              textAlign: TextAlign.center,
              style: const TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Reconnect Wallet button
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () => walletMenu.action(0),
                elevation: 0,
                color: const Color(0xff2979FB),
                padding: const EdgeInsetsDirectional.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  tr(context).reconnectWallet,
                  textAlign: TextAlign.center,
                  textDirection: Directionality.of(context),
                  softWrap: true,
                  style: const TextStyle(
                    backgroundColor: Colors.transparent,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Rescan Wallet button
            Observer(
              builder: (_) {
                canRescan = syncStore.status is SyncedSyncStatus ||
                    syncStore.status.blocksLeft == 0;

                return SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: canRescan
                        ? () async {
                      await Navigator.of(context)
                          .pushNamed(Routes.rescan);
                      Navigator.pop(context);
                    }
                        : null,
                    elevation: 0,
                    color: const Color(0xff0BA70F),
                    disabledColor: settingsStore.isDarkTheme
                        ? const Color(0xff333343)
                        : const Color(0xffE8E8E8),
                    padding: const EdgeInsetsDirectional.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      tr(context).rescanWallet,
                      textAlign: TextAlign.center,
                      textDirection: Directionality.of(context),
                      softWrap: true,
                      style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: 16,
                        color: canRescan
                            ? Colors.white
                            : settingsStore.isDarkTheme
                            ? const Color(0xff6C6C78)
                            : const Color(0xffB2B2B6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
