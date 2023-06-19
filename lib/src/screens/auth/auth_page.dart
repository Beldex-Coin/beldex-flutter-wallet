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
  void dispose() {

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);

    if (settingsStore.allowBiometricAuthentication) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final biometricAuth = BiometricAuth();
        biometricAuth.isAuthenticated().then(
                (isAuth) {
              if (isAuth) {
                authStore.biometricAuth();
                _key.currentState.showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).authenticated),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }
        );
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
         // ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
        
        // appBar: CupertinoNavigationBar(
        //   trailing: widget.closable ? SizedBox(width: 0,):SizedBox(width: 0,),
        //   middle:widget.closable ? Container() :Container(margin:EdgeInsets.only(top: 5),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(padding:EdgeInsets.all(6),decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.black,
        //         ),child: SvgPicture.asset('assets/images/beldex_logo_foreground1.svg',width: 25,height: 25,)),
        //         SizedBox(width: 5,),
        //         Text(
        //           'Beldex Wallet',
        //           style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryTextTheme.caption.color,),
        //         ),
        //       ],
        //     ),
        //   ),
        //   leading: widget.closable ? CloseButton():SizedBox(width: 0,),
        //   backgroundColor: Theme.of(context).backgroundColor,
        //   border: null,
        // ),
        resizeToAvoidBottomInset: false,
        body: PinCode(
            (pin, _) => authStore.auth(
                password: pin.fold('', (ac, val) => ac + '$val')),
            false,
            _pinCodeKey,refresh,
           // canShowBackArrow: false, // canShowBackArrow 
            ));
  }
}
