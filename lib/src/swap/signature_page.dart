import 'dart:ui';

import 'package:beldex_wallet/src/screens/base_page.dart';
import 'package:beldex_wallet/src/swap/api_service/signature.dart';
import 'package:flutter/material.dart';

class SignaturePage extends BasePage {
  @override
  bool get isModalBackButton => false;

  @override
  String get title => 'Swap';

  @override
  Color get textColor => Colors.white;

  @override
  Widget trailing(BuildContext context) {
    return Container();
  }

  @override
  Widget body(BuildContext context) {
    return SignatureHome();
  }
}

class SignatureHome extends StatefulWidget {
  @override
  State<SignatureHome> createState() => _SignatureHomeState();
}

class _SignatureHomeState extends State<SignatureHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map<String,dynamic>?>(
        future: getSignature(),
        builder: (context, AsyncSnapshot<Map<String,dynamic>?> snapshot){
          print('${snapshot.data} snapshot hasData');
          final data = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Text('$data');
            default:
              return Text('Error');
          }
        },
      ),
    );
  }

}