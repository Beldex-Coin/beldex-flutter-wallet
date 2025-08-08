
import 'package:flutter/material.dart';

import '../../../l10n.dart';
import '../../stores/settings/settings_store.dart';

void showSwapInitiatingTransactionDialog(BuildContext context, SettingsStore settingsStore) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Blurred card container
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                decoration: BoxDecoration(
                  color:  settingsStore.isDarkTheme ? Color(0xff272733) : Color(0xfff3f3f3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: settingsStore.isDarkTheme ? Color(0xff4b4b64) : Color(0xfff3f3f3), width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr(context).initiatingTransactionTitle,
                      style: TextStyle(
                        color: Color(0xff0BA70F),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.22,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      tr(context).initiatingTransactionDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: settingsStore.isDarkTheme ? Color(0xffEBEBEB) : Color(0xff222222),
                        fontWeight: FontWeight.w400,
                        fontSize: 12.44,
                      ),
                    ),
                  ],
                ),
              ),

              // Circular loader icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme ? Color(0xff30303F) : Color(0xffF3F3F3),
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0BA70F)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}