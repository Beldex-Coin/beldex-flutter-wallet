

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({ Key key }) : super(key: key);

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {



final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isBiometricAvailable = false;
  bool _isFingerprint = false;
  bool _isButtonEnabled = false;



Future<void> _checkBiometricPermission() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    setState(() {
      _isBiometricAvailable = canCheckBiometrics;
    });

    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics = await _localAuthentication.getAvailableBiometrics();
      setState(() {
        _isFingerprint = availableBiometrics.contains(BiometricType.fingerprint);
        _isButtonEnabled = true;
      });
    }
  }

@override
  void initState() {
_checkBiometricPermission();
    super.initState();
  }



 Future<void> _checkBiometricAvailability() async {
    bool isBiometricAvailable = await _localAuthentication.canCheckBiometrics;
    setState(() {
      _isBiometricAvailable = isBiometricAvailable;
      _isButtonEnabled = isBiometricAvailable;
    });

    if (isBiometricAvailable) {
      List<BiometricType> availableBiometrics = await _localAuthentication.getAvailableBiometrics();
      setState(() {
        _isFingerprint = availableBiometrics.contains(BiometricType.fingerprint);
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}