import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/util/convert_utf8_to_string.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';
import 'package:beldex_coin/src/exceptions/wallet_creation_exception.dart';
import 'package:beldex_coin/src/exceptions/wallet_restore_from_keys_exception.dart';
import 'package:beldex_coin/src/exceptions/wallet_restore_from_seed_exception.dart';

final createWalletNative = beldexApi
    .lookup<NativeFunction<create_wallet>>('create_wallet')
    .asFunction<CreateWallet>();

final restoreWalletFromSeedNative = beldexApi
    .lookup<NativeFunction<restore_wallet_from_seed>>(
        'restore_wallet_from_seed')
    .asFunction<RestoreWalletFromSeed>();

final restoreWalletFromKeysNative = beldexApi
    .lookup<NativeFunction<restore_wallet_from_keys>>(
        'restore_wallet_from_keys')
    .asFunction<RestoreWalletFromKeys>();

final isWalletExistNative = beldexApi
    .lookup<NativeFunction<is_wallet_exist>>('is_wallet_exist')
    .asFunction<IsWalletExist>();

final loadWalletNative = beldexApi
    .lookup<NativeFunction<load_wallet>>('load_wallet')
    .asFunction<LoadWallet>();

void createWalletSync(
    {required String path, required String password, required String language, int nettype = 0}) {
  final pathPointer = path.toNativeUtf8();
  final passwordPointer = password.toNativeUtf8();
  final languagePointer = language.toNativeUtf8();
  final isWalletCreated = createWalletNative(pathPointer, passwordPointer,
          languagePointer, nettype);

  calloc.free(pathPointer);
  calloc.free(passwordPointer);
  calloc.free(languagePointer);

  if (!isWalletCreated.good) {
    throw WalletCreationException(
        message: isWalletCreated.errorString());
  }
}

bool isWalletExistSync({required String path}) {
  final pathPointer = path.toNativeUtf8();
  final isExist = isWalletExistNative(pathPointer) != 0;

  calloc.free(pathPointer);

  return isExist;
}

void restoreWalletFromSeedSync(
    {required String path,
    required String password,
    required String seed,
    int nettype = 0,
    int restoreHeight = 0}) {
  final pathPointer = path.toNativeUtf8();
  final passwordPointer = password.toNativeUtf8();
  final seedPointer = seed.toNativeUtf8();
  final isWalletRestored = restoreWalletFromSeedNative(
          pathPointer,
          passwordPointer,
          seedPointer,
          nettype,
          restoreHeight);

  calloc.free(pathPointer);
  calloc.free(passwordPointer);
  calloc.free(seedPointer);

  if (!isWalletRestored.good) {
    throw WalletRestoreFromSeedException(
        message: isWalletRestored.errorString());
  }
}

void restoreWalletFromKeysSync(
    {required String path,
    required String password,
    required String language,
    required String address,
    required String viewKey,
    required String spendKey,
    int nettype = 0,
    int restoreHeight = 0}) {
  final pathPointer = path.toNativeUtf8();
  final passwordPointer = password.toNativeUtf8();
  final languagePointer = language.toNativeUtf8();
  final addressPointer = address.toNativeUtf8();
  final viewKeyPointer = viewKey.toNativeUtf8();
  final spendKeyPointer = spendKey.toNativeUtf8();
  final isWalletRestored = restoreWalletFromKeysNative(
          pathPointer,
          passwordPointer,
          languagePointer,
          addressPointer,
          viewKeyPointer,
          spendKeyPointer,
          nettype,
          restoreHeight);

  calloc.free(pathPointer);
  calloc.free(passwordPointer);
  calloc.free(languagePointer);
  calloc.free(addressPointer);
  calloc.free(viewKeyPointer);
  calloc.free(spendKeyPointer);

  if (!isWalletRestored.good) {
    throw WalletRestoreFromKeysException(
        message: isWalletRestored.errorString());
  }
}
