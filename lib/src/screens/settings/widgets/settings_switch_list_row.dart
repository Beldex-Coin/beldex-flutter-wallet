import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../l10n.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/standard_switch.dart';
import 'package:beldex_wallet/theme_changer.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:provider/provider.dart';

class SettingsSwitchListRow extends StatelessWidget {
  SettingsSwitchListRow({required this.title});

  final String title;

  Widget? _getSwitch(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final themeChanger = Provider.of<ThemeChanger>(context);

    if (title == tr(context).settings_save_recipient_address) {
      return Observer(
          builder: (_) => StandardSwitch(
              value: settingsStore.shouldSaveRecipientAddress,
              icon: false,
              onTaped: () {
                final currentValue = !settingsStore.shouldSaveRecipientAddress;
                settingsStore.setSaveRecipientAddress(
                    shouldSaveRecipientAddress: currentValue);
              }));
    }

    if (title == tr(context).settings_allow_biometric_authentication ||
        title == tr(context).allowFaceIdAuthentication) {
      return Observer(
          builder: (_) => StandardSwitch(
              value: settingsStore.allowBiometricAuthentication,
              icon: false,
              onTaped: () {
                final currentValue0 =
                    !settingsStore.allowBiometricAuthentication;
                settingsStore.setAllowBiometricAuthentication(
                    allowBiometricAuthentication: currentValue0);
              }));
    }

    if (title == tr(context).settings_dark_mode) {
      return Observer(
          builder: (_) => StandardSwitch(
              value: settingsStore.isDarkTheme,
              icon: false,
              onTaped: () {
                final currentValue1 = !settingsStore.isDarkTheme;
                settingsStore.saveDarkTheme(isDarkTheme: currentValue1);
                themeChanger.setTheme(
                    currentValue1 ? Themes.darkTheme : Themes.lightTheme);
              }));
    }

    if (title == tr(context).settings_enable_fiat_currency) {
      return Observer(
          builder: (_) => StandardSwitch(
              value: settingsStore.enableFiatCurrency,
              icon: false,
              onTaped: () {
                final currentValue2 = !settingsStore.enableFiatCurrency;
                settingsStore.setEnableFiatCurrency(
                    enableFiatCurrency: currentValue2);
              }));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
          contentPadding: EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
          title: Text(title,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryTextTheme.titleLarge?.color)),
          trailing: _getSwitch(context)),
    );
  }
}
