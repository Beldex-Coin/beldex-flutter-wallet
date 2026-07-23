import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

void displaySnackBar(BuildContext context, String text) {
  final settingsStore = Provider.of<SettingsStore>(context);

  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    // Toast duration (short or long)
    gravity: ToastGravity.BOTTOM,
    // Toast gravity (top, center, or bottom)
    textColor: settingsStore.isDarkTheme ? Colors.black : Colors.white,
    // Text color
    backgroundColor: settingsStore.isDarkTheme
        ? Colors.grey.shade50
        : Colors.grey.shade900, // Background color
  );
}
