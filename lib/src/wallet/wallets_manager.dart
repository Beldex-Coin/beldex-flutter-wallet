import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';

abstract class WalletsManager {
  Future<Wallet> create(String name, String password, String language);

  Future<Wallet> restoreFromSeed(
      String name, String password, String seed, int restoreHeight);

  Future<Wallet> restoreFromKeys(String name, String password, String language,
      int restoreHeight, String address, String viewKey, String spendKey);

  Future<Wallet> openWallet(String name, String password);

  Future<bool> isWalletExit(String name);

  Future remove(WalletDescription wallet);
}