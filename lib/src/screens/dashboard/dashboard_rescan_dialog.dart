import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/dashboard/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/util/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardAlertDialog extends StatefulWidget {
  const DashBoardAlertDialog({Key key}) : super(key: key);

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
    final networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.offline) {
      setState(() {
        canRescan = false;
      });
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text('Rescan', style: TextStyle(fontWeight: FontWeight.w800))),
      backgroundColor:
          settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xffffffff),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            onPressed: () => walletMenu.action(0),
            elevation: 0,
            color: Color(0xff2979FB),
            height: MediaQuery.of(context).size.height * 0.20 / 3,
            minWidth: double.infinity,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Reconnect wallet',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Observer(builder: (_) {
            final status = syncStore.status;
            if (status.title() == 'SYNCHRONIZED') {
              canRescan = true;
            } else {
              canRescan = false;
            }
            return MaterialButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(Routes.rescan);
                Navigator.pop(context);
              },
              elevation: 0,
              color: canRescan
                  ? Color(0xff0BA70F)
                  : settingsStore.isDarkTheme
                      ? Color(0xff333343)
                      : Color(0xffE8E8E8),
              height: MediaQuery.of(context).size.height * 0.20 / 3,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Rescan wallet',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            );
          })
        ],
      ),
    );
  }
}
