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
    {String path, String password, String language, int nettype = 0}) {
  final pathPointer = Utf8.toUtf8(path);
  final passwordPointer = Utf8.toUtf8(password);
  final languagePointer = Utf8.toUtf8(language);
  final errorMessagePointer = allocate<Utf8>();
  final isWalletCreated = createWalletNative(pathPointer, passwordPointer,
          languagePointer, nettype, errorMessagePointer) !=
      0;

  free(pathPointer);
  free(passwordPointer);
  free(languagePointer);

  if (!isWalletCreated) {
    throw WalletCreationException(
        message: convertUTF8ToString(pointer: errorMessagePointer));
  }
}

bool isWalletExistSync({String path}) {
  final pathPointer = Utf8.toUtf8(path);
  final isExist = isWalletExistNative(pathPointer) != 0;

  free(pathPointer);

  return isExist;
}

void restoreWalletFromSeedSync(
    {String path,
    String password,
    String seed,
    int nettype = 0,
    int restoreHeight = 0}) {
  final pathPointer = Utf8.toUtf8(path);
  final passwordPointer = Utf8.toUtf8(password);
  final seedPointer = Utf8.toUtf8(seed);
  final errorMessagePointer = allocate<Utf8>();
  final isWalletRestored = restoreWalletFromSeedNative(
          pathPointer,
          passwordPointer,
          seedPointer,
          nettype,
          restoreHeight,
          errorMessagePointer) !=
      0;

  free(pathPointer);
  free(passwordPointer);
  free(seedPointer);

  if (!isWalletRestored) {
    throw WalletRestoreFromSeedException(
        message: convertUTF8ToString(pointer: errorMessagePointer));
  }
}

void restoreWalletFromKeysSync(
    {String path,
    String password,
    String language,
    String address,
    String viewKey,
    String spendKey,
    int nettype = 0,
    int restoreHeight = 0}) {
  final pathPointer = Utf8.toUtf8(path);
  final passwordPointer = Utf8.toUtf8(password);
  final languagePointer = Utf8.toUtf8(language);
  final addressPointer = Utf8.toUtf8(address);
  final viewKeyPointer = Utf8.toUtf8(viewKey);
  final spendKeyPointer = Utf8.toUtf8(spendKey);
  final errorMessagePointer = allocate<Utf8>();
  final isWalletRestored = restoreWalletFromKeysNative(
          pathPointer,
          passwordPointer,
          languagePointer,
          addressPointer,
          viewKeyPointer,
          spendKeyPointer,
          nettype,
          restoreHeight,
          errorMessagePointer) !=
      0;

  free(pathPointer);
  free(passwordPointer);
  free(languagePointer);
  free(addressPointer);
  free(viewKeyPointer);
  free(spendKeyPointer);

  if (!isWalletRestored) {
    throw WalletRestoreFromKeysException(
        message: convertUTF8ToString(pointer: errorMessagePointer));
  }
}
