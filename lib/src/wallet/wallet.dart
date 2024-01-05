import 'package:rxdart/rxdart.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/wallet_type.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/transaction/pending_transaction.dart';
import 'package:beldex_wallet/src/wallet/balance.dart';
import 'package:beldex_wallet/src/node/node.dart';

abstract class Wallet {
  WalletType getType();

  WalletType get walletType;

  Stream<Balance> get onBalanceChange;

  Stream<SyncStatus> get syncStatus;

  Stream<String> get onNameChange;

  Stream<String> get onAddressChange;

  String get name;

  String get address;

  Future updateInfo();

  Future<String> getFilename();

  Future<String> getName();

  Future<String> getAddress();

  Future<String> getSeed();

  Future<Map<String, String>> getKeys();

  Future<int> getFullBalance();

  Future<int> getUnlockedBalance();

  int getCurrentHeight();

  bool isRefreshing();

  Future<int> getNodeHeight();

  Future<bool> isConnected();

  Future close();

  TransactionHistory getHistory();

  Future<void> connectToNode(
      {required Node node, bool useSSL = false, bool isLightWallet = false});

  Future startSync();

  Future<PendingTransaction> createStake(
      TransactionCreationCredentials credentials);

  Future<PendingTransaction> createTransaction(
      TransactionCreationCredentials credentials);

  Future rescan({int restoreHeight = 0});
}
