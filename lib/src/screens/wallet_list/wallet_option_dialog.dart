import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n.dart';

class WalletAlertDialog<Item extends int> extends StatefulWidget {
  WalletAlertDialog({Key? key, required this.onItemSelected}) : super(key: key);
  final Function(Item) onItemSelected;

  @override
  State<WalletAlertDialog> createState() => _WalletAlertDialogState();
}

class _WalletAlertDialogState extends State<WalletAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Dialog(
      surfaceTintColor: Colors.transparent,
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
              tr(context).changeWallet,
              style: TextStyle(backgroundColor:Colors.transparent,fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                widget.onItemSelected(0);
              },
              elevation: 0,
              color: Color(0xff0BA70F),
              height: MediaQuery.of(context).size.height * 0.20 / 3,
              minWidth: MediaQuery.of(context).size.width * 1.3 / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                tr(context).wallet_list_load_wallet,
                style: TextStyle(
                    backgroundColor:Colors.transparent,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                widget.onItemSelected(2);
              },
              elevation: 0,
              color: settingsStore.isDarkTheme
                  ? Color(0xff383848)
                  : Color(0xffE8E8E8),
              height: MediaQuery.of(context).size.height * 0.20 / 3,
              minWidth: MediaQuery.of(context).size.width * 1.3 / 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                tr(context).removeWallet,
                style: TextStyle(
                    backgroundColor:Colors.transparent,
                    fontSize: 16,
                    color:
                        settingsStore.isDarkTheme ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}