import 'dart:async';

import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_bns_renewal_transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_bns_transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_bns_update_transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_sweep_all_transaction_creation_credentials.dart';
import 'package:hive/hive.dart';
import 'package:beldex_coin/stake.dart' as beldex_stake;
import 'package:beldex_coin/transaction_history.dart' as transaction_history;
import 'package:beldex_coin/wallet.dart' as beldex_wallet;
import 'package:beldex_wallet/src/node/node.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/wallet/balance.dart';
import 'package:beldex_wallet/src/wallet/beldex/account.dart';
import 'package:beldex_wallet/src/wallet/beldex/account_list.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_balance.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress.dart';
import 'package:beldex_wallet/src/wallet/beldex/subaddress_list.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_stake_transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/beldex_transaction_history.dart';
import 'package:beldex_wallet/src/wallet/transaction/pending_transaction.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/wallet_info.dart';
import 'package:beldex_wallet/src/wallet/wallet_type.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const belDexBlockSize = 1000;

class BelDexWallet extends Wallet {
  BelDexWallet({required this.walletInfoSource, required this.walletInfo}) :
    _cachedBlockchainHeight = 0,
    _name = BehaviorSubject<String>(),
    _address = BehaviorSubject<String>(),
    _syncStatus = BehaviorSubject<SyncStatus>(),
    _onBalanceChange = BehaviorSubject<BelDexBalance>(),
    _account = BehaviorSubject<Account>()..add(Account(id: 0)),
    _subaddress = BehaviorSubject<Subaddress>();

  static Future<BelDexWallet> createdWallet(
      {required Box<WalletInfo> walletInfoSource,
      required String name,
      bool isRecovery = false,
      int restoreHeight = 0}) async {
    const type = WalletType.beldex;
    final id = (walletTypeToString(type)?.toLowerCase() ?? 'unknown') + '_' + name;
    final walletInfo = WalletInfo(
        id: id,
        name: name,
        type: type,
        isRecovery: isRecovery,
        restoreHeight: restoreHeight,
        timestamp: DateTime.now().millisecondsSinceEpoch);
    await walletInfoSource.add(walletInfo);

    return await configured(
        walletInfo: walletInfo, walletInfoSource: walletInfoSource);
  }

  static Future<BelDexWallet> load(
      Box<WalletInfo> walletInfoSource, String name, WalletType type) async {
    final id = (walletTypeToString(type)?.toLowerCase() ?? 'unknown' ) + '_' + name;
    print('Loading wallet $id');

    var walletInfo = walletInfoSource.values.firstWhere((info) => info.id == id,);
    if (walletInfo == null) {
      walletInfo = WalletInfo(
          id: id,
          name: name,
          type: type,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          // We don't know what these were, so use conservative values:
          isRecovery: false,
          restoreHeight: 0);
      await walletInfoSource.add(walletInfo);
    }
    return await configured(
        walletInfoSource: walletInfoSource, walletInfo: walletInfo);
  }

  static Future<BelDexWallet> configured(
      {required Box<WalletInfo> walletInfoSource,
        required WalletInfo walletInfo}) async {
    final wallet =
    BelDexWallet(walletInfoSource: walletInfoSource, walletInfo: walletInfo);

    if (walletInfo.isRecovery) {
      wallet.setRecoveringFromSeed();

      wallet.setRefreshFromBlockHeight(height: walletInfo.restoreHeight);
    }

    return wallet;
  }

  @override
  String get address => _address.value;

  @override
  String get name => _name.value;

  @override
  WalletType getType() => WalletType.beldex;

  @override
  WalletType get walletType => WalletType.beldex;

  @override
  Stream<SyncStatus> get syncStatus => _syncStatus.stream;

  @override
  Stream<Balance> get onBalanceChange => _onBalanceChange.stream;

  @override
  Stream<String> get onNameChange => _name.stream;

  @override
  Stream<String> get onAddressChange => _address.stream;

  Stream<Account> get onAccountChange => _account.stream;

  Stream<Subaddress> get subaddress => _subaddress.stream;

  bool get isRecovery => walletInfo.isRecovery;

  Account get account => _account.value;

  Box<WalletInfo> walletInfoSource;
  WalletInfo walletInfo;

  beldex_wallet.SyncListener? _listener;
  final BehaviorSubject<Account> _account;
  final BehaviorSubject<BelDexBalance> _onBalanceChange;
  final BehaviorSubject<SyncStatus> _syncStatus;
  final BehaviorSubject<String> _name;
  final BehaviorSubject<String> _address;
  final BehaviorSubject<Subaddress> _subaddress;
  int _cachedBlockchainHeight;

  TransactionHistory? _cachedTransactionHistory;
  SubaddressList? _cachedSubaddressList;
  AccountList? _cachedAccountList;
  Future<int>? _cachedGetNodeHeightOrUpdateRequest;

  @override
  Future updateInfo() async {
    _name.value = await getName();
    final acccountList = getAccountList();
    acccountList.refresh();
    _account.value = acccountList.getAll().first;
    final subaddressList = getSubaddress();
    await subaddressList.refresh(
        accountIndex: _account.value != null ? _account.value.id : 0);
    final subaddresses = subaddressList.getAll();
    _subaddress.value = subaddresses.first;
    print('sub address');
    print('sub address value ${_subaddress.value.address}, ${_subaddress.value.id}, ${_subaddress.value.label}');
    _address.value = await getAddress();
    print('address value ${_address.value}');
    setListeners();
  }

  @override
  Future<String> getFilename() async => beldex_wallet.getFilename();

  @override
  Future<String> getName() async => getFilename()
      .then((filename) => filename.split('/'))
      .then((splitted) => splitted.last);

  @override
  Future<String> getAddress() async => beldex_wallet.getAddress(
      accountIndex: _account.value.id, addressIndex: _subaddress.value.id);

  @override
  Future<String> getSeed() async => beldex_wallet.getSeed();

  @override
  Future<int> getFullBalance() async {
    final balance = await beldex_wallet.getFullBalance(accountIndex: _account.value.id);
    return balance;
  }

  @override
  Future<int> getUnlockedBalance() async {
    final balance = await beldex_wallet.getUnlockedBalance(accountIndex: _account.value.id);
    return balance;
  }

  @override
  int getCurrentHeight() => beldex_wallet.getCurrentHeight();

  @override
  bool isRefreshing() => beldex_wallet.isRefreshing();

  @override
  Future<int> getNodeHeight() async {
    _cachedGetNodeHeightOrUpdateRequest ??=
        beldex_wallet.getNodeHeight().then((value) {
      _cachedGetNodeHeightOrUpdateRequest = null;
      return value;
    });

    return _cachedGetNodeHeightOrUpdateRequest!;
  }

  @override
  Future<bool> isConnected() async => beldex_wallet.isConnected();

  @override
  Future<Map<String, String>> getKeys() async => {
        'publicViewKey': beldex_wallet.getPublicViewKey(),
        'privateViewKey': beldex_wallet.getSecretViewKey(),
        'publicSpendKey': beldex_wallet.getPublicSpendKey(),
        'privateSpendKey': beldex_wallet.getSecretSpendKey()
      };

  @override
  TransactionHistory getHistory() {
    _cachedTransactionHistory ??= BeldexTransactionHistory();

    return _cachedTransactionHistory!;
  }

  SubaddressList getSubaddress() {
    _cachedSubaddressList ??= SubaddressList();

    return _cachedSubaddressList!;
  }

  @override
  SubaddressList getSubAddressList() {
    _cachedSubaddressList ??= SubaddressList();

    return _cachedSubaddressList!;
  }

  AccountList getAccountList() {
    _cachedAccountList ??= AccountList();

    return _cachedAccountList!;
  }

  @override
  Future close() async {
    _listener?.stop();
    beldex_wallet.closeCurrentWallet();
    await _name.close();
    await _address.close();
    await _subaddress.close();
  }

  @override
  Future<void> connectToNode(
      {required Node node, bool useSSL = false, bool isLightWallet = false}) async {
    try {
      _syncStatus.value = ConnectingSyncStatus(getCurrentHeight());

      // Check if node is online to avoid crash
      final nodeIsOnline = await node.isOnline();
      if (!nodeIsOnline) {
        _syncStatus.value = FailedSyncStatus(getCurrentHeight());
        return;
      }

      await beldex_wallet.setupNode(
          address: node.uri,
          /*login: node.login,
          password: node.password,*/
          useSSL: useSSL,
          isLightWallet: isLightWallet);
      _syncStatus.value = ConnectedSyncStatus(getCurrentHeight());
    } catch (e) {
      _syncStatus.value = FailedSyncStatus(getCurrentHeight());
      print(e);
    }
  }

  @override
  Future startSync() async {
   /* try {
      _setInitialHeight();
    } catch (_) {}*/

    print('Starting from height: ${getCurrentHeight()}');
    final prefs =await SharedPreferences.getInstance();
    await prefs.setInt('currentHeight', getCurrentHeight() ?? 0);
    try {
      print('Starting from height try');
      _syncStatus.value = StartingSyncStatus(getCurrentHeight());
      beldex_wallet.startRefresh();
      _setListeners();
      _listener?.start();
    } catch (e) {
      print('Starting from height catch');
      _syncStatus.value = FailedSyncStatus(getCurrentHeight());
      print(e);
      rethrow;
    }
  }

  Future<int> getNodeHeightOrUpdate(int baseHeight) async {
    if (_cachedBlockchainHeight < baseHeight) {
      _cachedBlockchainHeight = await getNodeHeight();
    }

    return _cachedBlockchainHeight;
  }

  @override
  Future<PendingTransaction> createStake(
      TransactionCreationCredentials credentials) async {
    final _credentials = credentials as BeldexStakeTransactionCreationCredentials;
    if (_credentials.amount == null || _credentials.address == null) {
      return Future.error('Amount and address cannot be null.');
    }
    final transactionDescription =
    await beldex_stake.createStake(_credentials.address, _credentials.amount);

    return PendingTransaction.fromTransactionDescription(
        transactionDescription);
  }

  @override
  Future<PendingTransaction> createTransaction(
      TransactionCreationCredentials credentials) async {
    final _credentials = credentials as BeldexTransactionCreationCredentials;
    final transactionDescription = await transaction_history.createTransaction(
        address: _credentials.address,
        amount: _credentials.amount!,
        priorityRaw: _credentials.priority.serialize(),
        accountIndex: _account.value.id);
    print('transaction created');

    return PendingTransaction.fromTransactionDescription(
        transactionDescription);
  }

  @override
  Future<PendingTransaction> createBnsTransaction(
      TransactionCreationCredentials credentials) async {
    final _credentials = credentials as BeldexBnsTransactionCreationCredentials;
    final transactionDescription = await transaction_history.createBnsTransaction(
        owner: _credentials.owner,
        backUpOwner: _credentials.backUpOwner,
        mappingYears: _credentials.mappingYears,
        bchatId: _credentials.bchatId,
        walletAddress: _credentials.walletAddress,
        belnetId: _credentials.belnetId,
        ethAddress: _credentials.ethAddress,
        bnsName: _credentials.bnsName,
        priorityRaw: _credentials.priority.serialize(),
        accountIndex: _account.value.id);
    print('bns transaction created');

    return PendingTransaction.fromTransactionDescription(
        transactionDescription);
  }

  @override
  Future<PendingTransaction> createBnsUpdateTransaction(
      TransactionCreationCredentials credentials) async {
    final _credentials = credentials as BeldexBnsUpdateTransactionCreationCredentials;
    final transactionDescription = await transaction_history.createBnsUpdateTransaction(
        owner: _credentials.owner,
        backUpOwner: _credentials.backUpOwner,
        bchatId: _credentials.bchatId,
        walletAddress: _credentials.walletAddress,
        belnetId: _credentials.belnetId,
        ethAddress: _credentials.ethAddress,
        bnsName: _credentials.bnsName,
        priorityRaw: _credentials.priority.serialize(),
        accountIndex: _account.value.id);
    print('bns update transaction created');

    return PendingTransaction.fromTransactionDescription(
        transactionDescription);
  }

  @override
  Future<PendingTransaction> createBnsRenewalTransaction(
      TransactionCreationCredentials credentials) async {
    final _credentials = credentials as BeldexBnsRenewalTransactionCreationCredentials;
    final transactionDescription = await transaction_history.createBnsRenewalTransaction(
        bnsName: _credentials.bnsName,
        mappingYears: _credentials.mappingYears,
        priorityRaw: _credentials.priority.serialize(),
        accountIndex: _account.value.id);
    print('bns renewal transaction created');

    return PendingTransaction.fromTransactionDescription(
        transactionDescription);
  }

  @override
  Future<PendingTransaction> createSweepAllTransaction(
      TransactionCreationCredentials credentials) async {
    final _credentials = credentials as BeldexSweepAllTransactionCreationCredentials;
    final transactionDescription = await transaction_history.createSweepAllTransaction(
        priorityRaw: _credentials.priority.serialize(),
        accountIndex: _account.value.id);
    print('sweep all transaction created');

    return PendingTransaction.fromTransactionDescription(
        transactionDescription);
  }

  @override
  Future rescan({int restoreHeight = 0}) async {
    _syncStatus.value = StartingSyncStatus(getCurrentHeight());
    setRefreshFromBlockHeight(height: restoreHeight);
    beldex_wallet.rescanBlockchainAsync();
    _syncStatus.value = StartingSyncStatus(getCurrentHeight());
  }

  void setRecoveringFromSeed() =>
      beldex_wallet.setRecoveringFromSeed(isRecovery: true);

  void setRefreshFromBlockHeight({required int height}) =>
      beldex_wallet.setRefreshFromBlockHeight(height: height);

  Future setAsRecovered() async {
    walletInfo.isRecovery = false;
    await walletInfo.save();
  }

  Future askForUpdateBalance() async {
    final fullBalance = await getFullBalance();
    final unlockedBalance = await getUnlockedBalance();
    final needToChange = !_onBalanceChange.hasValue
        ? true : _onBalanceChange.value.fullBalance != fullBalance ||
        _onBalanceChange.value.unlockedBalance != unlockedBalance;

    if (needToChange) {
      _onBalanceChange.add(BelDexBalance(
          fullBalance: fullBalance, unlockedBalance: unlockedBalance));
    }
  }

  Future askForUpdateTransactionHistory() async {
    await getHistory().update();
  }

  void changeCurrentSubaddress(Subaddress subaddress) =>
      _subaddress.value = subaddress;

  void changeAccount(Account account) {
    _account.add(account);

    getSubaddress()
        .refresh(accountIndex: account.id)
        .then((dynamic _) => getSubaddress().getAll())
        .then((subaddresses) => _subaddress.value = subaddresses[0]);
  }

  beldex_wallet.SyncListener setListeners() =>
      beldex_wallet.setListeners(_onNewBlock, _onNewTransaction);

  Future _onNewBlock(int height, int target,int blocksLeft, bool isRefreshing) async {
    try {
      print('blocksLeft --> $blocksLeft');
      if (isRefreshing) {
        _syncStatus.add(SyncingSyncStatus(height, target,blocksLeft));
          print('isRefreshingNew if $isRefreshing');
      } else {
        print('isRefreshingNew else $isRefreshing');
        await askForUpdateTransactionHistory();
        await askForUpdateBalance();

        if (blocksLeft < 2) {
          print('isRefreshingNew else if $isRefreshing');
          _syncStatus.add(SyncedSyncStatus(height));
          await beldex_wallet.store();

          if (walletInfo.isRecovery) {
            await setAsRecovered();
          }
        }

        /*if (blocksLeft <= 1) {
          beldex_wallet.setRefreshFromBlockHeight(height: height);
        }*/
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  void _setListeners() {
    _listener?.stop();
    print('Starting from height _setListeners()');
    _listener = beldex_wallet.setListeners(_onNewBlock, _onNewTransaction);
  }

  void _setInitialHeight() {
    if (walletInfo.isRecovery) {
      return;
    }

    final currentHeight = getCurrentHeight();
    print('setInitialHeight() $currentHeight');

    if (currentHeight <= 1) {
      final height = _getHeightByDate(walletInfo.date);
      beldex_wallet.setRecoveringFromSeed(isRecovery: true);
      beldex_wallet.setRefreshFromBlockHeight(height: height);
    }
  }

  int _getHeightDistance(DateTime date) {
    final distance =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    final daysTmp = (distance / 86400).round();
    final days = daysTmp < 1 ? 1 : daysTmp;

    return days * 1000;
  }

  int _getHeightByDate(DateTime date) {
    final nodeHeight = beldex_wallet.getNodeHeightSync();
    final heightDistance = _getHeightDistance(date);

    if (nodeHeight <= 0) {
      return 0;
    }

    return nodeHeight - heightDistance;
  }

  Future _onNewTransaction() async {
    try {
      await askForUpdateTransactionHistory();
      await askForUpdateBalance();
    } catch (e) {
      print(e.toString());
    }
  }
}
