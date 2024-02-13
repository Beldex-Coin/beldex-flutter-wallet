import 'package:beldex_wallet/src/node/node.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/wallet/balance.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress_list.dart';
import 'package:beldex_wallet/src/wallet/transaction/pending_transaction.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/wallet_description.dart';
import 'package:beldex_wallet/src/wallet/wallet_type.dart';
import 'package:rxdart/rxdart.dart';

class WalletService extends Wallet {
  WalletService() {
    _currentWallet = null;
    walletType = WalletType.none;
    _syncStatus = BehaviorSubject<SyncStatus>();
    _onBalanceChange = BehaviorSubject<Balance>();
    _onWalletChanged = BehaviorSubject<Wallet>();
  }

  @override
  Observable<Balance> get onBalanceChange => _onBalanceChange.stream;

  @override
  Observable<SyncStatus> get syncStatus => _syncStatus.stream;

  @override
  Observable<String> get onAddressChange => _currentWallet.onAddressChange;

  @override
  Observable<String> get onNameChange => _currentWallet.onNameChange;

  @override
  String get address => _currentWallet.address;

  @override
  String get name => _currentWallet.name;

  @override
  WalletType get walletType => _currentWallet.walletType;

  Observable<Wallet> get onWalletChange => _onWalletChanged.stream;

  SyncStatus get syncStatusValue => _syncStatus.value;

  Wallet get currentWallet => _currentWallet;

  set currentWallet(Wallet wallet) {
    _currentWallet = wallet;

    if (wallet == null) {
      return;
    }

    _currentWallet.onBalanceChange
        .listen((wallet) => _onBalanceChange.add(wallet));
    _currentWallet.syncStatus.listen((status) => _syncStatus.add(status));
    _onWalletChanged.add(wallet);

    final type = wallet.getType();
    wallet.getName().then(
        (name) => description = WalletDescription(name: name, type: type));
  }

  BehaviorSubject<Wallet> _onWalletChanged;
  BehaviorSubject<Balance> _onBalanceChange;
  BehaviorSubject<SyncStatus> _syncStatus;
  Wallet _currentWallet;

  WalletDescription description;

  @override
  WalletType getType() => WalletType.beldex;

  @override
  Future<String> getFilename() => _currentWallet.getFilename();

  @override
  Future<String> getName() => _currentWallet.getName();

  @override
  Future<String> getAddress() => _currentWallet.getAddress();

  @override
  Future<String> getSeed() => _currentWallet.getSeed();

  @override
  Future<Map<String, String>> getKeys() => _currentWallet.getKeys();

  @override
  SubaddressList getSubAddressList() => _currentWallet.getSubAddressList();

  @override
  Future<int> getFullBalance() => _currentWallet.getFullBalance();

  @override
  Future<int> getUnlockedBalance() => _currentWallet.getUnlockedBalance();

  @override
  int getCurrentHeight() => _currentWallet.getCurrentHeight();

  @override
  bool isRefreshing() => currentWallet.isRefreshing();

  @override
  Future<int> getNodeHeight() => _currentWallet.getNodeHeight();

  @override
  Future<bool> isConnected() => _currentWallet.isConnected();

  @override
  Future close() => _currentWallet.close();

  @override
  Future connectToNode(
          {Node node, bool useSSL = false, bool isLightWallet = false}) =>
      _currentWallet.connectToNode(
          node: node, useSSL: useSSL, isLightWallet: isLightWallet);

  @override
  Future startSync() => _currentWallet.startSync();

  @override
  TransactionHistory getHistory() => _currentWallet.getHistory();

  @override
  Future<PendingTransaction> createStake(
      TransactionCreationCredentials credentials) =>
      _currentWallet.createStake(credentials);

  @override
  Future<PendingTransaction> createTransaction(
          TransactionCreationCredentials credentials) =>
      _currentWallet.createTransaction(credentials);

  @override
  Future<PendingTransaction> createBnsTransaction(
      TransactionCreationCredentials credentials) =>
      _currentWallet.createBnsTransaction(credentials);

  @override
  Future updateInfo() async => _currentWallet.updateInfo();

  @override
  Future rescan({int restoreHeight = 0}) async =>
      _currentWallet.rescan(restoreHeight: restoreHeight);
}
