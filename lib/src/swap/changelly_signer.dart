import 'package:flutter/services.dart';

class ChangellyRsaSigner {
  ChangellyRsaSigner(this._privateKeyHex);

  static const _channel = MethodChannel('io.beldex.wallet/changelly_signer');

  final String _privateKeyHex;

  Future<Map<String, String>> buildSignedHeaders(String body) async {
    final result = await _channel.invokeMethod('sign', {
      'privateKeyHex': _privateKeyHex,
      'body': body,
    });
    return {
      'Content-Type': 'application/json',
      'X-Api-Key': result['xApiKey'] as String,
      'X-Api-Signature': result['xApiSignature'] as String,
    };
  }
}
