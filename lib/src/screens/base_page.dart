import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beldex_wallet/src/widgets/nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/themes.dart';
import 'package:beldex_wallet/theme_changer.dart';

enum AppBarStyle { regular, withShadow }

abstract class BasePage extends StatelessWidget {
  String get title => null;

  Color get textColor => Colors.white;

  bool get isModalBackButton => false;

  Color get backgroundColor => Colors.white;

  bool get resizeToAvoidBottomInset => true;

  AppBarStyle get appBarStyle => AppBarStyle.regular;

  void onClose(BuildContext context) => Navigator.of(context).pop();

  Widget leading(BuildContext context) {
    if (ModalRoute.of(context).isFirst) {
      return null;
    }
 final settingsStore = Provider.of<SettingsStore>(context);
 final _backButton = Icon(Icons.arrow_back_sharp, size: 28, color: settingsStore.isDarkTheme ? Colors.white:Colors.black);
return InkWell(
      onTap: (){
        onClose(context);
      },
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff) , //Theme.of(context).accentTextTheme.headline6.color,
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).accentTextTheme.headline6.color,
          //     blurRadius:2.0,
          //     spreadRadius: 1.0,
          //     offset: Offset(2.0, 2.0), // shadow direction: bottom right
          //   )
          // ],
        ),
        child: SizedBox(
          height: 50,
          width: isModalBackButton ? 37 : 20,
          child: ButtonTheme(
            buttonColor: Colors.transparent,
            minWidth: double.minPositive,
            child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.transparent),
                ),
                onPressed: () => onClose(context),
                child: Container(
                  decoration: BoxDecoration(

                  ),
                  child: _backButton) //isModalBackButton ? _closeButton : _backButton
                ),
          ),
        ),
      ),
    );










    // return SizedBox(
    //   height: 50,
    //   width: isModalBackButton ? 37 : 20,
    //   child: ButtonTheme(
    //     minWidth: double.minPositive,
    //     child: Container(
    //       color: Theme.of(context).backgroundColor,
    //     ),
    //   ),
    // );
  }

  Widget middle(BuildContext context) {
    return title == null
        ? null
        : Text(
            title,
            style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'Poppins',
                color: Theme.of(context).primaryTextTheme.caption.color),
          );
  }

  Widget trailing(BuildContext context) {
     final settingsStore = Provider.of<SettingsStore>(context);
    if (ModalRoute.of(context).isFirst) {
      return null;
    }

    final _backButton = Icon(Icons.arrow_back_sharp, size: 28);
    final _closeButton = Icon(Icons.close_rounded, size: 25);
   /* final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.getTheme() == Themes.darkTheme;*/

    return InkWell(
      onTap: (){
        onClose(context);
      },
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff) , //Theme.of(context).accentTextTheme.headline6.color,
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).accentTextTheme.headline6.color,
          //     blurRadius:2.0,
          //     spreadRadius: 1.0,
          //     offset: Offset(2.0, 2.0), // shadow direction: bottom right
          //   )
          // ],
        ),
        child: SizedBox(
          height: 50,
          width: isModalBackButton ? 37 : 20,
          child: ButtonTheme(
            buttonColor: Colors.transparent,
            minWidth: double.minPositive,
            child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.transparent),
                ),
                onPressed: () => onClose(context),
                child: Container(
                  decoration: BoxDecoration(

                  ),
                  child: _backButton) //isModalBackButton ? _closeButton : _backButton
                ),
          ),
        ),
      ),
    );
  }

  Widget floatingActionButton(BuildContext context) => null;

  ObstructingPreferredSizeWidget appBar(BuildContext context) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.getTheme() == Themes.darkTheme;

    switch (appBarStyle) {
      case AppBarStyle.regular:
        return NavBar(
            context: context,
            leading: leading(context),
            middle: middle(context),
            trailing: trailing(context),
            backgroundColor: _isDarkTheme
                ? Theme.of(context).backgroundColor
                : Theme.of(context).backgroundColor);

      case AppBarStyle.withShadow:
        return NavBar.withShadow(
            context: context,
            leading: leading(context),
            middle: middle(context),
            trailing: trailing(context),
            backgroundColor: _isDarkTheme
                ? Theme.of(context).backgroundColor
                : Theme.of(context).backgroundColor);

      default:
        return NavBar(
            context: context,
            leading: leading(context),
            middle: middle(context),
            trailing: trailing(context),
            backgroundColor: _isDarkTheme
                ? Theme.of(context).backgroundColor
                : Theme.of(context).backgroundColor);
    }
  }

  Widget body(BuildContext context);

  Widget bottomNavigationBar(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    final _themeChanger = Provider.of<ThemeChanger>(context);
    final _isDarkTheme = _themeChanger.getTheme() == Themes.darkTheme;

    return Scaffold(
        backgroundColor:
            _isDarkTheme ? Color(0xff171720) : Color(0xffffffff), //Theme.of(context).backgroundColor : Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          centerTitle: true,
          leading:Padding(
            padding: EdgeInsets.only(top:20.0, bottom:5),
            child:leading(context)  //trailing(context),
          ), //leading(context),
          title: Padding(
            padding: const EdgeInsets.only(top:20.0,bottom: 5),
            child: middle(context),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:20.0,bottom: 5),
              child: trailing(context),
            )
          ],
            backgroundColor: Colors.transparent
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
