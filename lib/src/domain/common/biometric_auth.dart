import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class BiometricAuth {
  Future<bool> isAuthenticated() async {
    final _localAuth = LocalAuthentication();

    try {

      return await _localAuth.authenticate(
          localizedReason:  S.current.biometric_auth_reason,
          useErrorDialogs:true,
          stickyAuth: false,
          biometricOnly: true
      );


    } on PlatformException catch (e) {
      print(e);
    }

    return false;
  }
}