import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:beldex_wallet/l10n.dart';

class BiometricAuth {
  Future<bool> isAuthenticated(AppLocalizations t) async {
    final localAuth = LocalAuthentication();

    try {
      return await localAuth.authenticate(
        localizedReason: t.biometric_auth_reason,
        authMessages: <AuthMessages>[
          IOSAuthMessages(
            cancelButton: t.cancel,
          ),
          AndroidAuthMessages(
            biometricHint: t.verify_identity,
            signInTitle: t.authentication_required,
            cancelButton: t.cancel,
          ),
        ],
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }

    return false;
  }
}