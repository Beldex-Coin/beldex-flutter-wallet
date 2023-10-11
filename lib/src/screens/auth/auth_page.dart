import 'package:beldex_wallet/src/screens/pin_code/bio_auth_provider.dart';
import 'package:beldex_wallet/src/screens/pin_code/biometric_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:beldex_wallet/generated/l10n.dart';
import 'package:beldex_wallet/src/stores/auth/auth_state.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';
import 'package:beldex_wallet/src/screens/pin_code/pin_code.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/domain/common/biometric_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

typedef OnAuthenticationFinished = void Function(bool, AuthPageState);

class AuthPage extends StatefulWidget {
  AuthPage({this.onAuthenticationFinished, this.closable = true});

  final OnAuthenticationFinished onAuthenticationFinished;
  final bool closable;

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _pinCodeKey = GlobalKey<PinCodeState>();

  final auth = LocalAuthentication();
  List<BiometricType> _availableBiometrics = <BiometricType>[];

  void changeProcessText(String text) {
    _key.currentState.showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.green));
  }

  void close() => Navigator.of(_key.currentContext).pop();

  //
  void refresh() {
    setState(() {});
  }

  bool isBiometric = false;

  // void getBiometricValue() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isBiometric = prefs.getBool('setBiometric') ?? false;
  //   });
  // }

  // void setvalue() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('setBiometric', false);
  // }

  // Future _getAvailableBiometric() async {
  //   List<BiometricType> availableBiometrics;
  //   print('inside biometric function');
  //   try {
  //     availableBiometrics = await auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     availableBiometrics = <BiometricType>[];
  //     print(e);
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(() {
  //     _availableBiometrics = availableBiometrics;
  //   });
  // }

  void getBioBottomSheet(AuthStore authStore, BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final biometricAuth = BiometricAuth();
      biometricAuth.isAuthenticated().then((isAuth) {
        if (isAuth) {
          authStore.biometricAuth();
          Navigator.of(context).pop();
        }
      });
      showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
           // _getAvailableBiometric();
            return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: settingsStore.isDarkTheme
                      ? Color(0xff272733)
                      : Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height * 1 / 3,
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5, bottom: 8.0),
                            child: Text(
                              S.of(context).unlockBeldexWallet,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
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
                                MediaQuery.of(context).size.height * 0.05 / 3,
                            color: settingsStore.isDarkTheme
                                ? Color(0xff909090)
                                : Color(0xff303030)),
                      )),
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height *
                                  0.10 /
                                  3),
                          child: SvgPicture.asset(
                            'assets/images/new-images/fingerprint.svg',
                            color: settingsStore.isDarkTheme
                                ? Color(0xffffffff)
                                : Color(0xff16161D),
                            height:
                                MediaQuery.of(context).size.height * 0.25 / 3,
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            S.of(context).touchTheFingerprintSensor,
                            style: TextStyle(
                                fontSize: 13, color: Color(0xff909090)),
                          )),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 5,
                                  bottom: 8.0,
                                  top: MediaQuery.of(context).size.height *
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
                    ]));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);
    final buttonClicked = Provider.of<ButtonClickNotifier>(context);
    print('buttonClicked.buttonClicked1 ${buttonClicked.buttonClicked}');
    if (settingsStore.allowBiometricAuthentication) {
      print('buttonClicked.buttonClicked2 ${buttonClicked.buttonClicked}');
      if (buttonClicked.buttonClicked) {
        getBioBottomSheet(authStore, context);
      }
    }
    // if (settingsStore.allowBiometricAuthentication) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     final biometricAuth = BiometricAuth();
    //     biometricAuth.isAuthenticated().then((isAuth) {
    //       if (isAuth) {
    //         authStore.biometricAuth();
    //         _key.currentState.showSnackBar(
    //           SnackBar(
    //             content: Text(S.of(context).authenticated),
    //             backgroundColor: Colors.green,
    //           ),
    //         );
    //       }
    //     });
    //   });
    // }

    reaction((_) => authStore.state, (AuthState state) {
      if (state is AuthenticatedSuccessfully) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.onAuthenticationFinished != null) {
            widget.onAuthenticationFinished(true, this);
          } else {
            _key.currentState.showSnackBar(
              SnackBar(
                content: Text(S.of(context).authenticated),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      }

      if (state is AuthenticationInProgress) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _key.currentState.showSnackBar(
            SnackBar(
              content: Text(S.of(context).authentication),
              backgroundColor: Colors.green,
            ),
          );
        });
      }

      if (state is AuthenticationFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pinCodeKey.currentState.clear();
          _key.currentState.hideCurrentSnackBar();
          _key.currentState.showSnackBar(
            SnackBar(
              content: Text(S.of(context).failed_authentication(state.error)),
              backgroundColor: Colors.red,
            ),
          );

          if (widget.onAuthenticationFinished != null) {
            widget.onAuthenticationFinished(false, this);
          }
        });
      }

      if (state is AuthenticationBanned) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _pinCodeKey.currentState.clear();
          _key.currentState.hideCurrentSnackBar();
          _key.currentState.showSnackBar(
            SnackBar(
              content: Text(S.of(context).failed_authentication(state.error)),
              backgroundColor: Colors.red,
            ),
          );

          if (widget.onAuthenticationFinished != null) {
            widget.onAuthenticationFinished(false, this);
          }
        });
      }
    });

    return Scaffold(
        key: _key,
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          centerTitle: true,
          leading: widget.closable
              ? Container(
                  width: 60,
                  padding: EdgeInsets.only(left: 15, top: 20, bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 30,
                    width: 40,
                    child: ButtonTheme(
                      buttonColor: Colors.transparent,
                      minWidth: double.minPositive,
                      child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/images/new-images/back_arrow.svg',
                            color: settingsStore.isDarkTheme
                                ? Colors.white
                                : Colors.black,
                            height: 80,
                            width: 50,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                )
              : SizedBox(
                  width: 0,
                ),
          title: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              S.of(context).enterPin,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Theme.of(context).primaryTextTheme.caption.color,
              ),
            ),
          ),
          backgroundColor:
              settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        ),
        resizeToAvoidBottomInset: false,
        body: PinCode(
            (pin, _) => authStore.auth(
                password: pin.fold('', (ac, val) => ac + '$val')),
            false,
            _pinCodeKey,
            refresh,
            authStore));
  }
}
