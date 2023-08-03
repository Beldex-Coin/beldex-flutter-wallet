import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:beldex_wallet/src/domain/common/encrypt.dart';
import 'package:beldex_wallet/src/domain/common/secret_store_key.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_wallets_manager.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:beldex_wallet/src/wallet/wallet_info.dart';
import 'package:beldex_wallet/src/wallet/wallet_type.dart';
import 'package:beldex_wallet/src/wallet/wallets_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class WalletIsExistException implements Exception {
  WalletIsExistException(this.name);

  String name;

  @override
  String toString() => 'Wallet with name $name is already exist!';
}

class WalletListService {
  WalletListService(
      {this.secureStorage,
      this.walletInfoSource,
      this.walletsManager,
      @required this.walletService,
      @required this.sharedPreferences});

  final FlutterSecureStorage secureStorage;
  final WalletService walletService;
  final Box<WalletInfo> walletInfoSource;
  final SharedPreferences sharedPreferences;
  WalletsManager walletsManager;

  Future<List<WalletDescription>> getAll() async => walletInfoSource.values
      .map((info) => WalletDescription(name: info.name, type: info.type))
      .toList();

  Future create(String name, String language) async {
    if (await walletsManager.isWalletExit(name)) {
      throw WalletIsExistException(name);
    }

    if (walletService.currentWallet != null) {
      await walletService.close();
    }

    final password = Uuid().v4();
    await saveWalletPassword(password: password, walletName: name);

    final wallet = await walletsManager.create(name, password, language);

    await onWalletChange(wallet);
  }

  Future restoreFromSeed(String name, String seed, int restoreHeight) async {
    if (await walletsManager.isWalletExit(name)) {
      throw WalletIsExistException(name);
    }

    if (walletService.currentWallet != null) {
      await walletService.close();
    }

    final password = Uuid().v4();
    await saveWalletPassword(password: password, walletName: name);

    final wallet = await walletsManager.restoreFromSeed(
        name, password, seed, restoreHeight);

    await onWalletChange(wallet);
  }

  Future restoreFromKeys(String name, String language, int restoreHeight,
      String address, String viewKey, String spendKey) async {
    if (await walletsManager.isWalletExit(name)) {
      throw WalletIsExistException(name);
    }

    if (walletService.currentWallet != null) {
      await walletService.close();
    }

    final password = Uuid().v4();
    await saveWalletPassword(password: password, walletName: name);

    final wallet = await walletsManager.restoreFromKeys(
        name, password, language, restoreHeight, address, viewKey, spendKey);

    await onWalletChange(wallet);
   
  SharedPreferences prefs = await SharedPreferences.getInstance();
   
   await prefs.setBool('isRestored', true);


  }

  Future openWallet(String name) async {
    try{

    }catch(e){
      print('inside openWallet error $e');
    }
    if (walletService.currentWallet != null) {
      print('if it is current wallet ${walletService.currentWallet}');
      //await walletService.currentWallet.close();
      await walletService.close();
      print('after close the wallet service of current wallet');
    }
      final password = await getWalletPassword(walletName: name);
      final wallet = await walletsManager.openWallet(name, password);
      print('the wallet password and wallet name is $password ---- ${wallet.name}');
      await onWalletChange(wallet);



  }

  Future changeWalletManger({WalletType walletType}) async {
    switch (walletType) {
      case WalletType.beldex:
        walletsManager =  BeldexWalletsManager(walletInfoSource: walletInfoSource);
        break;
      case WalletType.monero:
      case WalletType.none:
        walletsManager = null;
        break;
    }
  }

  Future onWalletChange(Wallet wallet) async {
    try{
      //if(walletService.currentWallet == null){
        print('inside onWalletChange ---->');
        walletService.currentWallet = wallet;
        print('the current wallet is ${walletService.currentWallet}');
        final walletName = await wallet.getName();
        print('the name of wallet is $walletName');
        await sharedPreferences.setString('current_wallet_name', walletName);
        print('-------');
      //}

    }catch(e){
      print('inside on walletchange error $e');
    }

  }

  Future remove(WalletDescription wallet) async =>
      await walletsManager.remove(wallet);

  Future<String> getWalletPassword({String walletName}) async {
    final key = generateStoreKeyFor(
        key: SecretStoreKey.moneroWalletPassword, walletName: walletName);
    final encodedPassword = await secureStorage.read(key: key);

    return decodeWalletPassword(password: encodedPassword);
  }

  Future saveWalletPassword({String walletName, String password}) async {
    final key = generateStoreKeyFor(
        key: SecretStoreKey.moneroWalletPassword, walletName: walletName);
    final encodedPassword = encodeWalletPassword(password: password);

    await secureStorage.write(key: key, value: encodedPassword);
  }
}
