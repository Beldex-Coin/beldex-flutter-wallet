import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:beldex_coin/src/native/wallet_manager.dart' as wallet_manager;

void loadWallet({String path, String password, int nettype = 0}) {
  final pathPointer = Utf8.toUtf8(path);
  final passwordPointer = Utf8.toUtf8(password);

  wallet_manager.loadWalletNative(pathPointer, passwordPointer, nettype);
  free(pathPointer);
  free(passwordPointer);
}

void _createWallet(Map<String, dynamic> args) {
  final path = args['path'] as String;
  final password = args['password'] as String;
  final language = args['language'] as String;
  final nettype = args['nettype'] as int;

  wallet_manager.createWalletSync(
      path: path, password: password, language: language, nettype: nettype);
}

void _restoreFromSeed(Map<String, dynamic> args) {
  final path = args['path'] as String;
  final password = args['password'] as String;
  final seed = args['seed'] as String;
  final restoreHeight = args['restoreHeight'] as int;
  final nettype = args['nettype'] as int;

  wallet_manager.restoreWalletFromSeedSync(
      path: path,
      password: password,
      seed: seed,
      restoreHeight: restoreHeight,
      nettype: nettype);
}

void _restoreFromKeys(Map<String, dynamic> args) {
  final path = args['path'] as String;
  final password = args['password'] as String;
  final language = args['language'] as String;
  final restoreHeight = args['restoreHeight'] as int;
  final nettype = args['nettype'] as int;
  final address = args['address'] as String;
  final viewKey = args['viewKey'] as String;
  final spendKey = args['spendKey'] as String;

  wallet_manager.restoreWalletFromKeysSync(
      path: path,
      password: password,
      language: language,
      restoreHeight: restoreHeight,
      nettype: nettype,
      address: address,
      viewKey: viewKey,
      spendKey: spendKey);
}

Future<void> _openWallet(Map<String, String> args) async =>
    loadWallet(path: args['path'], password: args['password']);

bool _isWalletExist(String path) =>
    wallet_manager.isWalletExistSync(path: path);

void openWallet({String path, String password, int nettype = 0}) async =>
    loadWallet(path: path, password: password, nettype: nettype);

Future<void> openWalletAsync(Map<String, String> args) async =>
    compute(_openWallet, args);

Future<void> createWallet(
        {String path,
        String password,
        String language,
        int nettype = 0}) async =>
    compute(_createWallet, {
      'path': path,
      'password': password,
      'language': language,
      'nettype': nettype
    });

Future restoreFromSeed(
        {String path,
        String password,
        String seed,
        int nettype = 0,
        int restoreHeight = 0}) async =>
    compute<Map<String, Object>, void>(_restoreFromSeed, {
      'path': path,
      'password': password,
      'seed': seed,
      'nettype': nettype,
      'restoreHeight': restoreHeight
    });

Future restoreFromKeys(
        {String path,
        String password,
        String language,
        String address,
        String viewKey,
        String spendKey,
        int nettype = 0,
        int restoreHeight = 0}) async =>
    compute<Map<String, Object>, void>(_restoreFromKeys, {
      'path': path,
      'password': password,
      'language': language,
      'address': address,
      'viewKey': viewKey,
      'spendKey': spendKey,
      'nettype': nettype,
      'restoreHeight': restoreHeight
    });

Future<bool> isWalletExist({String path}) => compute(_isWalletExist, path);
