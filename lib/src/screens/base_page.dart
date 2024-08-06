import 'package:beldex_wallet/src/screens/root/internet_connection.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/src/widgets/nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:beldex_wallet/theme_changer.dart';
import 'package:beldex_wallet/l10n.dart';

import '../../l10n.dart';

enum AppBarStyle { regular, withShadow }

abstract class BasePage extends StatelessWidget {
  String? getTitle(AppLocalizations t) { return null;}

  Color get textColor => Colors.white;

  bool get isModalBackButton => false;

  Color get backgroundColor => Colors.white;

  bool get resizeToAvoidBottomInset => true;

  AppBarStyle get appBarStyle => AppBarStyle.regular;

  void onClose(BuildContext context) => Navigator.of(context).pop();

  Widget? leading(BuildContext context) {
    if (ModalRoute.of(context)?.isFirst ?? false) {
      return null;
    }
    final settingsStore = Provider.of<SettingsStore>(context);
    final _backButton = Container(
        height: 48,
        width: 48,
        child: SvgPicture.asset(
          'assets/images/new-images/back_arrow.svg',
          color: settingsStore.isDarkTheme ? Colors.white : Colors.black,
          height: 48,
          width: 48,
          fit: BoxFit.fill,
        ));
    return Container(
      width: 60,
      padding: EdgeInsets.only(left: 10,top: 4),
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 48,
        width: 48,
        child: ButtonTheme(
          buttonColor: Colors.transparent,
          minWidth: double.minPositive,
          child: TextButton(
              onPressed: () => onClose(context), child: _backButton),
        ),
      ),
    );
  }

  Widget? middle(BuildContext context) {
    final title = getTitle(tr(context));
    return title == null
        ? null
        : Text(
            title,
            style: TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: 23.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryTextTheme.caption?.color),
          );
  }

  Widget? trailing(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    if (ModalRoute.of(context)?.isFirst ?? false) {
      return null;
    }

    final _backButton = Icon(Icons.arrow_back_sharp, size: 28);

    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: settingsStore.isDarkTheme
            ? Color(0xff171720)
            : Color(
                0xffffffff),
      ),
      child: SizedBox(
        height: 50,
        width: isModalBackButton ? 37 : 20,
        child: ButtonTheme(
          buttonColor: Colors.transparent,
          minWidth: double.minPositive,
          child: TextButton(
              onPressed: () => onClose(context),
              child: Container(
                  decoration: BoxDecoration(),
                  child: _backButton)
              ),
        ),
      ),
    );
  }

  Widget floatingActionButton(BuildContext context) {
    return InternetConnectivityChecker();
  }

  ObstructingPreferredSizeWidget appBar(BuildContext context) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.getTheme() == Themes.darkTheme;

    switch (appBarStyle) {
      case AppBarStyle.regular:
        return NavBar(
            context: context,
            leading: leading(context)!,
            middle: middle(context)!,
            trailing: trailing(context)!,
            backgroundColor: _isDarkTheme
                ? Theme.of(context).backgroundColor
                : Theme.of(context).backgroundColor);

      case AppBarStyle.withShadow:
        return NavBar.withShadow(
            context: context,
            leading: leading(context)!,
            middle: middle(context)!,
            trailing: trailing(context)!,
            backgroundColor: _isDarkTheme
                ? Theme.of(context).backgroundColor
                : Theme.of(context).backgroundColor);

      default:
        return NavBar(
            context: context,
            leading: leading(context)!,
            middle: middle(context)!,
            trailing: trailing(context)!,
            backgroundColor: _isDarkTheme
                ? Theme.of(context).backgroundColor
                : Theme.of(context).backgroundColor);
    }
  }

  Widget body(BuildContext context);

  Widget? bottomNavigationBar(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.getTheme() == Themes.darkTheme;

    return Scaffold(
        backgroundColor: _isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        //Theme.of(context).backgroundColor : Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            centerTitle: true,
            // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: _isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
            // statusBarIconBrightness: Brightness.dark,
            // statusBarBrightness: Brightness.light
            // ),
            leading: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 5),
                child: leading(context) //trailing(context),
                ),
            title: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5),
              child: middle(context),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                child: trailing(context),
              )
            ],
            backgroundColor: _isDarkTheme
            ? Color(0xff171720)
            : Color(0xffffffff),
            //  _isDarkTheme
            //     ? Theme.of(context).backgroundColor
            //     : Theme.of(context).backgroundColor
            ),
        body: SafeArea(child: body(context)),
        floatingActionButton: floatingActionButton(context),
        bottomNavigationBar: bottomNavigationBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
