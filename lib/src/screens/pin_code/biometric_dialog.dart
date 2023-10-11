import 'dart:ui';

import 'package:beldex_wallet/routes.dart';
import 'package:beldex_wallet/src/domain/common/biometric_auth.dart';
import 'package:beldex_wallet/src/domain/services/user_service.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/screens/auth/auth_page.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future showBiometricDialog(
  BuildContext context,
  String title,
  AuthStore authStore
//String body,
//     {String buttonText,
//     void Function(BuildContext context) onPressed,
//     void Function(BuildContext context) onDismiss}
) {
  return showDialog<void>(
      builder: (_) => BiometricDialog(title: title, context: context,authStore:authStore
      ),
      context: context);
}

class BiometricDialog extends StatelessWidget {
  BiometricDialog({Key key, this.title, this.context,this.authStore
  }) : super(key: key);

  final String title;
  final BuildContext context;
  final AuthStore authStore;
  @override
  Widget build(BuildContext context) {
    return BeldexBioDialog(
      title: title,
      authStore: authStore,
    );
  }
}

class BeldexBioDialog extends StatefulWidget {
  BeldexBioDialog({
    this.body,
    this.onDismiss,
    this.title,
    this.context,
   this.authStore,
  });

  final void Function(BuildContext context) onDismiss;
  final String body;
  final String title;
  final BuildContext context;
 final AuthStore authStore;
  @override
  BeldexBioDialogState createState() => BeldexBioDialogState();
}

class BeldexBioDialogState extends State<BeldexBioDialog> {
  void _onDismiss(BuildContext context) {
    if (widget.onDismiss == null) {
      Navigator.of(context).pop();
    } else {
      widget.onDismiss(context);
    }
  }

  bool canClick = true;

  @override
  void initState() {
    // getBiometric(widget.context);
    setvalue();
    super.initState();
  }

  void getBiometric(BuildContext contxt) {
    final authStore = Provider.of<AuthStore>(contxt);
    final biometricAuth = BiometricAuth();
    biometricAuth.isAuthenticated().then((isAuth) {
      if (isAuth) {
        authStore.biometricAuth();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).authenticated),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void setvalue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setBiometric', canClick);
  }

  @override
  void dispose() {
    // resetvalue();
    super.dispose();
  }

  void resetvalue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setBiometric', false);
  }

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final userService = Provider.of<UserService>(context);
    final walletService = Provider.of<WalletService>(context);
    final sharedPreferences = Provider.of<SharedPreferences>(context);
   AuthPageState auth;
    // getBiometric(context);
    return Provider(
        create: (_) => widget.authStore,
        // AuthStore(
        //     userService: userService,
        //     walletService: walletService,
        //     sharedPreferences: sharedPreferences),
        builder: (context, child) {
         // final authStore = Provider.of<AuthStore>(context, listen: false);
          if (settingsStore.allowBiometricAuthentication) {
           WidgetsBinding.instance.addPostFrameCallback((_) {
            final biometricAuth = BiometricAuth();
            biometricAuth.isAuthenticated().then((isAuth) {
              if (isAuth) {
                widget.authStore.biometricAuth();
                Navigator.of(context).pop();
                //auth.close();
                //Navigator.of(context)..pop()..pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).authenticated),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            });
            });
          }
    




          return GestureDetector(
            onTap: () => _onDismiss(context),
            child: Container(
              color: Colors.transparent,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  // margin: EdgeInsets.all(10),
                  // decoration: BoxDecoration(color: Color(0xff171720).withOpacity(0.55)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors
                                .transparent, //Theme.of(context).backgroundColor,
                            //borderRadius: BorderRadius.circular(10)
                          ),
                          child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 3,
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                color: settingsStore.isDarkTheme
                                    ? Color(0xff272733)
                                    : Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding:
                                  EdgeInsets.only(top: 20, left: 15, right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, bottom: 8.0),
                                        child: Text(
                                          S.of(context).unlockBeldexWallet,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07 /
                                                  3,
                                              fontWeight: FontWeight.w600,
                                              color: settingsStore.isDarkTheme
                                                  ? Color(0xffEBEBEB)
                                                  : Color(0xff16161D)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(

                                      // color: Colors.yellow,
                                      child: Text(
                                    S
                                        .of(context)
                                        .confirmYourScreenLockPinpatternAndPassword,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05 /
                                                3,
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xff909090)
                                            : Color(0xff303030)),
                                  )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10 /
                                              3),
                                      child: SvgPicture.asset(
                                        'assets/images/new-images/fingerprint.svg',
                                        color: settingsStore.isDarkTheme
                                            ? Color(0xffffffff)
                                            : Color(0xff16161D),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25 /
                                                3,
                                      )),
                                  Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        S.of(context).touchTheFingerprintSensor,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff909090)),
                                      )),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 5,
                                              bottom: 8.0,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.09 /
                                                  3),
                                          child: Text(
                                            S.of(context).usePattern,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff0BA70F)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
