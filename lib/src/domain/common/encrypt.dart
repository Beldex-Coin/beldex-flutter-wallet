import 'package:encrypt/encrypt.dart';
import 'package:beldex_wallet/.secrets.g.dart' as secrets;

class DecodeResult {
  DecodeResult({
    required this.value,
    this.needsMigration = false,
  });

  final String value;
  final bool needsMigration;
}

String encrypt(
    {required String source, required String key, int keyLength = 16}) {
  final _key = Key.fromUtf8(key);
  final iv = IV.fromSecureRandom(16);
  final encrypter = Encrypter(AES(_key, mode: AESMode.sic));
  final encrypted = encrypter.encrypt(source, iv: iv);
  return '${iv.base64}:${encrypted.base64}';
}

String decrypt(
    {required String source, required String key, int keyLength = 16}) {
  final _key = Key.fromUtf8(key);
  final encrypter = Encrypter(AES(_key, mode: AESMode.sic));

  // New format: iv:ciphertext
  if (source.contains(':')) {
    final parts = source.split(':');

    if (parts.length != 2) {
      throw FormatException('Invalid encrypted value');
    }

    final iv = IV.fromBase64(parts[0]);
    final cipherText = parts[1];
    return encrypter.decrypt64(cipherText, iv: iv);
  }

  // Legacy format (all zeros IV)
  final legacyIv = IV.allZerosOfLength(16);
  return encrypter.decrypt64(source, iv: legacyIv);
}

String _encryptAuthenticated({required String source, required String key}) {
  final _key = Key.fromUtf8(key);
  final iv = IV.fromSecureRandom(12);
  final encrypter = Encrypter(AES(_key, mode: AESMode.gcm));
  final encrypted = encrypter.encrypt(source, iv: iv);
  return '${iv.base64}:${encrypted.base64}';
}

String _decryptAuthenticated({required String source, required String key}) {
  final _key = Key.fromUtf8(key);
  final encrypter = Encrypter(AES(_key, mode: AESMode.gcm));
  final parts = source.split(':');
  if (parts.length != 2) {
    throw FormatException('Invalid encrypted value');
  }
  final iv = IV.fromBase64(parts[0]);
  // Throws on authentication-tag mismatch (tamper / wrong key / truncation).
  return encrypter.decrypt64(parts[1], iv: iv);
}

String encodedPinCode({required String pin}) {
  final source = '${secrets.salt_v2}$pin';
  final encrypted = _encryptAuthenticated(
    source: source,
    key: secrets.key_v2,
  );
  return 'v2:$encrypted';
}

DecodeResult decodedPinCode({required String pin}) {
  String decrypted;
  bool migrated = false;
  if (pin.startsWith('v2:')) {
    decrypted = _decryptAuthenticated(
      source: pin.substring(3),
      key: secrets.key_v2,
    );
  } else {
    decrypted = decrypt(
      source: pin,
      key: secrets.key,
    );
    migrated = true;
  }

  if (decrypted.startsWith(secrets.salt_v2)) {
    return DecodeResult(
      value: decrypted.substring(secrets.salt_v2.length, decrypted.length)
    );
  }

  if (decrypted.startsWith(secrets.salt)) {
    final plainPin = decrypted.substring(secrets.salt.length, decrypted.length);

    return DecodeResult(
      value: plainPin,
      needsMigration: migrated,
    );
  }

  throw Exception('Unknown PIN salt version');
}

String encodeWalletPassword({required String password}) {
  final encrypted = _encryptAuthenticated(
    source: password,
    key: secrets.shortKey_v2 + secrets.walletSalt_v2,
  );
  return 'v2:$encrypted';
}

DecodeResult decodeWalletPassword({required String password}) {
  if (password.startsWith('v2:')) {
    return DecodeResult(
      value: _decryptAuthenticated(
        source: password.substring(3),
        key: secrets.shortKey_v2 + secrets.walletSalt_v2,
      ),
    );
  }

  return DecodeResult(
    value: decrypt(
      source: password,
      key: secrets.shortKey + secrets.walletSalt,
    ),
    needsMigration: true,
  );
}
