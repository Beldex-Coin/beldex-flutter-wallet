import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/dashboard/wallet_menu.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/util/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';

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
            Text(
              S.of(context).rescan,
              style: TextStyle(
                  fontSize: 18,
                  // fontFamily: 'Poppinsbold',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () => walletMenu.action(0),
              elevation: 0,
              color: Color(0xff2979FB),
              height: MediaQuery.of(context).size.height * 0.20 / 3,
              minWidth: MediaQuery.of(context).size.width * 1.3 / 2,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text(
                S.of(context).reconnectWallet,
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
                onPressed:canRescan ? () async {
                  await Navigator.of(context).pushNamed(Routes.rescan);
                  Navigator.pop(context);
                } : null,
                elevation: 0,
                color:canRescan ? Color(0xff0BA70F) : settingsStore.isDarkTheme ? Color(0xff333343) : Color(0xffE8E8E8),
                height: MediaQuery.of(context).size.height * 0.20 / 3,
                minWidth:  MediaQuery.of(context).size.width * 1.3 / 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  S.of(context).rescanWallet,
                  style: TextStyle(
                      fontSize: 17,
                      color:canRescan ? Colors.white : settingsStore.isDarkTheme
                                                    ? Color(0xff6C6C78)
                                                    : Color(0xffB2B2B6),
                      fontWeight: FontWeight.w800),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
