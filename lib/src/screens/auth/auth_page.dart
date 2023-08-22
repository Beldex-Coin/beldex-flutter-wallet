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

  void changeProcessText(String text) {
    _key.currentState.showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.green));
  }

  void close() => Navigator.of(_key.currentContext).pop();

  //
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);

    if (settingsStore.allowBiometricAuthentication) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final biometricAuth = BiometricAuth();
        biometricAuth.isAuthenticated().then((isAuth) {
          if (isAuth) {
            authStore.biometricAuth();
            _key.currentState.showSnackBar(
              SnackBar(
                content: Text(S.of(context).authenticated),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      });
    }

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
                            'assets/images/new-images/back_button_white_theme.svg',
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
              'Enter Pin',
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
          (pin, _) =>
              authStore.auth(password: pin.fold('', (ac, val) => ac + '$val')),
          false,
          _pinCodeKey,
          refresh,
        ));
  }
}
