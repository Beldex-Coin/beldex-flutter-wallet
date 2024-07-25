import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beldex_wallet/l10n.dart';
import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:provider/provider.dart';

class WelcomePage extends BasePage {
  static const _baseWidth = 411.43;

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    return Scaffold(
        backgroundColor:
            settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: body(context)));
  }

  @override
  Widget body(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = _screenWidth < _baseWidth ? 0.76 : 1.0;
    final settingsStore = Provider.of<SettingsStore>(context);
    return Stack(
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(_screenHeight * 0.10 / 3),
                decoration: BoxDecoration(
                    color: settingsStore.isDarkTheme
                        ? Color(0xff21212D)
                        : Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: _screenHeight * 0.10 / 3),
                      child: Image.asset('assets/images/new-images/beldex_logo.png',width: 44,height: 44,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        tr(context).wallet_list_title,
                        style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textScaleFactor: textScaleFactor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                        height: _screenHeight * 0.60 / 3,
                        child: SvgPicture.asset(settingsStore.isDarkTheme
                            ? 'assets/images/new-images/Empty_screen_image.svg'
                            : 'assets/images/new-images/Empty_screen_image_white.svg')),
                    Text(
                      tr(context).welcomeToBeldexWallet,
                      style: TextStyle(
                        backgroundColor: Colors.transparent,
                        fontSize: _screenHeight * 0.05 / 3,
                        fontWeight: FontWeight.w700,
                        color: settingsStore.isDarkTheme
                            ? Color(0xffAFAFBE)
                            : Color(0xff303030),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        tr(context)
                            .selectAnOptionBelowToCreateOrnRecoverExistingWallet,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          backgroundColor: Colors.transparent,
                          fontSize: _screenHeight * 0.05 / 3,
                          color: settingsStore.isDarkTheme
                              ? Color(0xffFFFFFF)
                              : Color(0xff060606),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.restoreOptions);
                      },
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          backgroundColor: Color(0xff2979FB),
                          padding: EdgeInsets.only(
                              top: 13, bottom: 13, left: 42, right: 42),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        tr(context).restore_wallet,
                        style: TextStyle(backgroundColor: Colors.transparent,color:Theme.of(context).primaryTextTheme.button?.color,fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.newWalletFromWelcome);
                      },
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          backgroundColor: Color(0xff0BA70F),
                          padding: EdgeInsets.only(
                              top: 13, bottom: 13, left: 42, right: 42),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        tr(context).create_new,
                        style: TextStyle(backgroundColor: Colors.transparent,color:Theme.of(context).primaryTextTheme.button?.color,fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: _screenHeight * 0.10 / 3,
                    )
                  ],
                ),
              ),
              Positioned(
                  left: 10.0,
                  top: 100,
                  child: Container(
                      height: 65,
                      width: 65,
                      child: Image.asset(
                          'assets/images/new-images/green_coin.png')) //Image.asset('assets/images/new-images/coin.png'),
              ),
              Positioned(
                  right: 2.0,
                  bottom: 130,
                  child: Container(
                      height: 50,
                      width: 55,
                      child: Image.asset('assets/images/new-images/blue_coin.png'))),
            ],
          ),
        ),
      ],
    );
  }
}
