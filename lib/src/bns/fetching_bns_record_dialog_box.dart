import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';

class FetchingBnsRecordDialogBox {
  void showFetchingBnsRecordDialog(BuildContext context, SettingsStore settingsStore) {
    showDialog<Dialog>(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
              backgroundColor: settingsStore.isDarkTheme
                  ? Color(0xff272733)
                  : Colors.white,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: 15.0, left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme
                        ? Color(0xff272733)
                        : Colors.white, //Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(child: Text('Fetching BNS records from the network...',style: TextStyle(
                      backgroundColor: Colors.transparent,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'
                    ),))
                  ],
                ),
              ));
        });
  }
}
