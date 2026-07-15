import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../l10n.dart';
import 'package:beldex_wallet/src/stores/auth/auth_state.dart';
import 'package:beldex_wallet/src/stores/auth/auth_store.dart';
import 'package:beldex_wallet/src/screens/pin_code/pin_code.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/domain/common/biometric_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io' show Platform;
typedef OnAuthenticationFinished = void Function(bool, AuthPageState);

class AuthPage extends StatefulWidget {
  AuthPage({this.onAuthenticationFinished, this.closable = true});

  final OnAuthenticationFinished? onAuthenticationFinished;
  final bool closable;

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _pinCodeKey = GlobalKey<PinCodeState>();
  List<BiometricType> _availableBiometrics = <BiometricType>[];

  void changeProcessText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), backgroundColor: Colors.green));
  }

  void close() => Navigator.of(_key.currentContext!).pop();

  void refresh() {
    setState(() {});
  }

  ReactionDisposer? _authReaction;

  bool _biometricStarted = false;

  @override
  void initState() {
    super.initState();
    _setupAuthReaction();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticateBiometric();
    });
  }

  @override
  void dispose() {
    _authReaction?.call();
    super.dispose();
  }

  Future<void> _authenticateBiometric() async {
    if (_biometricStarted) return;

    _biometricStarted = true;

    final settingsStore = Provider.of<SettingsStore>(context, listen: false);

    final authStore = Provider.of<AuthStore>(context, listen: false);

    if (!Platform.isAndroid ||
        !settingsStore.allowBiometricAuthentication) {
      return;
    }

    try {
      final biometricAuth = BiometricAuth();

      final isAuth = await biometricAuth.isAuthenticated(tr(context));

      if (!mounted) return;

      if (isAuth) {
        authStore.biometricAuth(tr(context));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr(context).authenticated),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (_) {
      // User can still authenticate with PIN; avoid logging auth-flow details.
    }
  }

  void _setupAuthReaction() {
    final authStore = Provider.of<AuthStore>(context, listen: false);

    _authReaction = reaction<AuthState>(
          (_) => authStore.state,
          (state) {
        if (!mounted) return;

        if (state is AuthenticatedSuccessfully) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            if (widget.onAuthenticationFinished != null) {
              widget.onAuthenticationFinished!(true, this);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(tr(context).authenticated),
                  backgroundColor: Colors.green,
                ),
              );
            }
          });
        } else if (state is AuthenticationFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            _pinCodeKey.currentState?.clear();

            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                Text(tr(context).failed_authentication(state.error)),
                backgroundColor: Colors.red,
              ),
            );

            widget.onAuthenticationFinished?.call(false, this);
          });
        } else if (state is AuthenticationBanned) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            _pinCodeKey.currentState?.clear();

            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                Text(tr(context).failed_authentication(state.error)),
                backgroundColor: Colors.red,
              ),
            );

            widget.onAuthenticationFinished?.call(false, this);
          });
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final settingsStore = Provider.of<SettingsStore>(context);

    return Scaffold(
        key: _key,
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          centerTitle: true,
          leading: widget.closable
              ? Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 15),
            alignment: Alignment.centerLeft,
            child: ButtonTheme(
              buttonColor: Colors.transparent,
              minWidth: double.minPositive,
              child: TextButton(
                  onPressed: () => Navigator.pop(context), child: SvgPicture.asset(
                'assets/images/new-images/back_arrow.svg',
                colorFilter: ColorFilter.mode(settingsStore.isDarkTheme ? Colors.white : Colors.black, BlendMode.srcIn),
                fit: BoxFit.fill,
                height: 15,
                width: 15,
              )),
            ),
          )
              : SizedBox(
            width: 0,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              tr(context).enterPin,
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Theme.of(context).primaryTextTheme.bodySmall?.color,
              ),
            ),
          ),
          backgroundColor:
          settingsStore.isDarkTheme ? Color(0xff171720) : Color(0xffffffff),
        ),
        resizeToAvoidBottomInset: false,
        body: PinCode(
                (pin, _) => authStore.auth(
                password: pin.fold('', (ac, val) => ac + '$val'), l10n: tr(context)),
            false,
            _pinCodeKey,
            refresh,_key));
  }
}