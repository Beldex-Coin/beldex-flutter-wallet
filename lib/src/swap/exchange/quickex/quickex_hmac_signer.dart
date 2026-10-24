import 'dart:convert';
import 'package:crypto/crypto.dart';

class QuickexHmacSigner {
  QuickexHmacSigner._();

  static String sign(String timestamp, String body, String publicKey, String secretKey) {
    final strToSign = '$timestamp$body$publicKey';
    final hmac = Hmac(sha256, utf8.encode(secretKey));
    final digest = hmac.convert(utf8.encode(strToSign));
    return base64Encode(digest.bytes);
  }

  static String timestampMs() => DateTime.now().millisecondsSinceEpoch.toString();
}
