import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:beldex_wallet/generated/l10n.dart';

class BiometricAuth {
  Future<bool> isAuthenticated() async {
    final _localAuth = LocalAuthentication();

    try {

     final didAuthendicate = await _localAuth.authenticate(
      localizedReason:  S.current.biometric_auth_reason,
      useErrorDialogs:false, //true,
      //stickyAuth: false,
      biometricOnly: true
      );
      
    if(didAuthendicate){
      return true;
    }else{
      return false;
    }

    } on PlatformException catch (e) {
      print(e);
      return false;
    }

    return false;
  }
}
