import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beldex_wallet/src/domain/common/secret_store_key.dart';
import 'package:beldex_wallet/src/domain/common/encrypt.dart';
import 'package:beldex_wallet/src/wallet/wallet_info.dart';
import 'package:hive/hive.dart';

class UserService {
  UserService({required this.sharedPreferences, required this.secureStorage,required this.walletInfoSource});

  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;
  final Box<WalletInfo> walletInfoSource;
  static const _migrationKey = 'secret_migration_v2';

  Future<void> setPassword(String password) async {
    final key = generateStoreKeyFor(key: SecretStoreKey.pinCodePassword);

    try {
      final encodedPassword = encodedPinCode(pin: password);

      await secureStorage.write(key: key, value: encodedPassword);
    } catch (e) {
      debugPrint('Failed to save PIN: $e');
      rethrow;
    }
  }

  Future<bool> canAuthenticate() async {
    final key = generateStoreKeyFor(key: SecretStoreKey.pinCodePassword);
    final walletName = sharedPreferences.getString('current_wallet_name') ?? '';
    if (!(walletName?.isNotEmpty ?? false)) {
      return false;
    }
    String? password;

    try {
      password = await secureStorage.read(key: key);
    } catch (e) {
      debugPrint('Failed to read PIN: $e');
    }

    return password?.isNotEmpty ?? false;
  }

  Future<bool> authenticate(String pin) async {
    final key = generateStoreKeyFor(key: SecretStoreKey.pinCodePassword);
    final encodedPin = await secureStorage.read(key: key);
    if (encodedPin == null) {
      return false;
    }
    try {
      final decodedPin = decodedPinCode(pin: encodedPin);

      final isValid = decodedPin.value == pin;

      if (isValid && decodedPin.needsMigration) {
        await secureStorage.write(
          key: key,
          value: encodedPinCode(pin: decodedPin.value),
        );
      }

      return isValid;
    } catch (e) {
      debugPrint('Failed to authenticate PIN: $e');
      return false;
    }
  }

  Future<void> migrateSecretsToV2() async {
    bool migrationSucceeded = true;

    if (sharedPreferences.getBool(_migrationKey) ?? false) {
      return;
    }

    try {
      // Migrate PIN
      final pinKey = generateStoreKeyFor(
        key: SecretStoreKey.pinCodePassword,
      );

      final pin = await secureStorage.read(key: pinKey);

      try {
        if (pin != null && !pin.startsWith('v2:')) {
          final decoded = decodedPinCode(pin: pin);

          await secureStorage.write(
            key: pinKey,
            value: encodedPinCode(pin: decoded.value),
          );
        }
      } catch (e) {
        migrationSucceeded = false;
        debugPrint('Failed to migrate PIN: $e');
      }

      // Migrate wallet passwords
      for (final info in walletInfoSource.values) {
        try {
          final key = generateStoreKeyFor(
            key: SecretStoreKey.moneroWalletPassword,
            walletName: info.name,
          );

          final stored = await secureStorage.read(key: key);

          if (stored == null || stored.startsWith('v2:')) {
            continue;
          }

          final decoded = decodeWalletPassword(password: stored);
          await secureStorage.write(
            key: key,
            value: encodeWalletPassword(password: decoded.value),
          );
        } catch (e) {
          migrationSucceeded = false;
          debugPrint('Failed to migrate wallet ${info.name}: $e');
        }
      }

      if (migrationSucceeded) {
        await sharedPreferences.setBool(_migrationKey, true);
      }
    } catch (e) {
      debugPrint('Secret migration failed: $e');
    }
  }
}
