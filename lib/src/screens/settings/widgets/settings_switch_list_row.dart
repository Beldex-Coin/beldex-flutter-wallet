import 'package:beldex_wallet/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/widgets/standart_switch.dart';
import 'package:beldex_wallet/theme_changer.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:provider/provider.dart';

class SettingsSwitchListRow extends StatelessWidget {
  SettingsSwitchListRow(
      {required this.title, required this.balanceVisibility,required this.decimalVisibility,required this.currencyVisibility,required this.feePriorityVisibility});

  final String title;
  bool balanceVisibility = false;
  bool decimalVisibility = false;
  bool currencyVisibility = false;
  bool feePriorityVisibility = false;

  Widget? _getSwitch(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final _themeChanger = Provider.of<ThemeChanger>(context);

    if (title == tr(context).settings_save_recipient_address) {
      return Observer(
          builder: (_) => StandartSwitch(
              value: settingsStore.shouldSaveRecipientAddress,
              icon: false,
              onTaped: () {
                if (balanceVisibility == false &&
                    decimalVisibility == false &&
                    currencyVisibility == false &&
                    feePriorityVisibility == false) {
                  final _currentValue = !settingsStore.shouldSaveRecipientAddress;
                  settingsStore.setSaveRecipientAddress(
                      shouldSaveRecipientAddress: _currentValue);
                }
              }));
    }

    if (title == tr(context).settings_allow_biometric_authentication) {
      return Observer(
          builder: (_) => StandartSwitch(
              value: settingsStore.allowBiometricAuthentication,
              icon: false,
              onTaped: () {
                if (balanceVisibility == false &&
                    decimalVisibility == false &&
                    currencyVisibility == false &&
                    feePriorityVisibility == false) {
                  final _currentValue =
                  !settingsStore.allowBiometricAuthentication;
                  settingsStore.setAllowBiometricAuthentication(
                      allowBiometricAuthentication: _currentValue);
                }
              }));
    }
    if (title == 'Allow face id authentication') {
      return Observer(
          builder: (_) => StandartSwitch(
              value: settingsStore.allowBiometricAuthentication,
              icon: false,
              onTaped: () {
                if (balanceVisibility == false &&
                    decimalVisibility == false &&
                    currencyVisibility == false &&
                    feePriorityVisibility == false) {
                  final _currentValue =
                  !settingsStore.allowBiometricAuthentication;
                  settingsStore.setAllowBiometricAuthentication(
                      allowBiometricAuthentication: _currentValue);
                }
              }));
    }

    if (title == tr(context).settings_dark_mode) {
      return Observer(
          builder: (_) => StandartSwitch(
              value: settingsStore.isDarkTheme,
              icon: false,
              onTaped: () {
                if (balanceVisibility == false &&
                    decimalVisibility == false &&
                    currencyVisibility == false &&
                    feePriorityVisibility == false) {
                  final _currentValue = !settingsStore.isDarkTheme;
                  settingsStore.saveDarkTheme(isDarkTheme: _currentValue);
                  _themeChanger.setTheme(
                      _currentValue ? Themes.darkTheme : Themes.lightTheme);
                }
              }));
    }

    if (title == tr(context).settings_enable_fiat_currency) {
      return Observer(
          builder: (_) => StandartSwitch(
              value: settingsStore.enableFiatCurrency,
              icon: false,
              onTaped: () {
                if (balanceVisibility == false &&
                    decimalVisibility == false &&
                    currencyVisibility == false &&
                    feePriorityVisibility == false) {
                  final _currentValue = !settingsStore.enableFiatCurrency;
                  settingsStore.setEnableFiatCurrency(
                      enableFiatCurrency: _currentValue);
                }
              }));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Theme.of(context).accentTextTheme.headline5.backgroundColor,
      child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
          title: Text(title,
              style: TextStyle(
                  fontSize:MediaQuery.of(context).size.height*0.06/3, //14.0,
                  fontWeight: FontWeight.w500,
                  //fontFamily: 'Poppins',
                  color: Theme.of(context).primaryTextTheme.headline6!.color)),
          trailing: _getSwitch(context)),
    );
  }
}
