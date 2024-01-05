import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:beldex_coin/src/exceptions/setup_wallet_exception.dart';
import 'package:beldex_coin/src/native/wallet.dart' as beldex_wallet;
import 'package:beldex_coin/src/util/convert_utf8_to_string.dart';

int _boolToInt(bool value) => value ? 1 : 0;

final statusSyncChannel =
    BasicMessageChannel<ByteData>('beldex_coin.sync_listener', BinaryCodec());

final beldexMethodChannel = MethodChannel('beldex_coin');

int getSyncingHeight() => beldex_wallet.getSyncingHeightNative();

bool isNeededToRefresh() => beldex_wallet.isNeededToRefreshNative() != 0;

bool isNewTransactionExist() => beldex_wallet.isNewTransactionExistNative() != 0;

String getFilename() =>
    convertUTF8ToString(pointer: beldex_wallet.getFileNameNative());

String getSeed() => convertUTF8ToString(pointer: beldex_wallet.getSeedNative());

String getAddress({int accountIndex = 0, int addressIndex = 0}) =>
    convertUTF8ToString(
        pointer: beldex_wallet.getAddressNative(accountIndex, addressIndex));

int _getFullBalanceSync(int accountIndex) =>
    beldex_wallet.getFullBalanceNative(accountIndex);

Future<int> getFullBalance({int accountIndex = 0}) =>
  compute<int, int>(_getFullBalanceSync, accountIndex);

int _getUnlockedBalanceSync(int accountIndex) =>
    beldex_wallet.getUnlockedBalanceNative(accountIndex);

Future<int> getUnlockedBalance({int accountIndex = 0}) =>
    compute<int, int>(_getUnlockedBalanceSync, accountIndex);

int getCurrentHeight() => beldex_wallet.getCurrentHeightNative();

int getNodeHeightSync() => beldex_wallet.getNodeHeightNative();

bool isRefreshingSync() => beldex_wallet.isRefreshingNative() != 0;

bool isConnectedSync() => beldex_wallet.isConnectedNative() != 0;

bool setupNodeSync(
    {required String address,
    String? login,
    String? password,
    bool useSSL = false,
    bool isLightWallet = false}) {
  final addressPointer = address.toNativeUtf8();
  final Pointer<Utf8> loginPointer = (login ?? '').toNativeUtf8();
  final Pointer<Utf8> passwordPointer = (password ?? '').toNativeUtf8();

  final isSetupNode = beldex_wallet.setupNodeNative(
          addressPointer,
          loginPointer,
          passwordPointer,
          _boolToInt(useSSL),
          _boolToInt(isLightWallet));

  calloc.free(addressPointer);
  calloc.free(loginPointer);
  calloc.free(passwordPointer);

  if (!isSetupNode.good) {
    throw SetupWalletException(message: isSetupNode.errorString());
  }

  return true;
}

void startRefreshSync() => beldex_wallet.startRefreshNative();

Future<bool> connectToNode() async => beldex_wallet.connecToNodeNative().good;

void setRefreshFromBlockHeight({required int height}) =>
    beldex_wallet.setRefreshFromBlockHeightNative(height);

void setRecoveringFromSeed({required bool isRecovery}) =>
    beldex_wallet.setRecoveringFromSeedNative(_boolToInt(isRecovery));

void closeCurrentWallet() => beldex_wallet.closeCurrentWalletNative();

String getSecretViewKey() =>
    convertUTF8ToString(pointer: beldex_wallet.getSecretViewKeyNative());

String getPublicViewKey() =>
    convertUTF8ToString(pointer: beldex_wallet.getPublicViewKeyNative());

String getSecretSpendKey() =>
    convertUTF8ToString(pointer: beldex_wallet.getSecretSpendKeyNative());

String getPublicSpendKey() =>
    convertUTF8ToString(pointer: beldex_wallet.getPublicSpendKeyNative());

class SyncListener {
  SyncListener(this.onNewBlock, this.onNewTransaction);

  void Function(int, int, int, bool) onNewBlock;
  void Function() onNewTransaction;

  Timer? _updateSyncInfoTimer;
  int _cachedBlockchainHeight = 0;
  int _lastKnownBlockHeight = 0;
  int _initialSyncHeight = 0;

  Future<int> getNodeHeightOrUpdate(int baseHeight) async {
    if (_cachedBlockchainHeight < baseHeight || _cachedBlockchainHeight == 0) {
      _cachedBlockchainHeight = await getNodeHeight();
    }

    return _cachedBlockchainHeight;
  }

  void start() {
    _cachedBlockchainHeight = 0;
    _lastKnownBlockHeight = 0;
    _initialSyncHeight = 0;
    _updateSyncInfoTimer ??=
        Timer.periodic(Duration(milliseconds: 1200), (_) async {

      final syncHeight = getCurrentHeight();

      final bchHeight = await getNodeHeightOrUpdate(syncHeight);

      if (_lastKnownBlockHeight == syncHeight || syncHeight == null) {
        return;
      }

      _lastKnownBlockHeight = syncHeight;
      final left = bchHeight - syncHeight;

      if (syncHeight < 0 || bchHeight < syncHeight) {
        return;
      }

      final refreshing = isRefreshing();
      print('refreshing --> $refreshing');
      if (!refreshing) {
        if (isNewTransactionExist()) {
          onNewTransaction.call();
        }
      }

      // 1. Actual new height; 2. Blocks left to finish; 3. Progress in percents; 4. true
      print('syncHeight, blockChainHeight, blockLeft, refreshing --> $syncHeight, $bchHeight, $left, $refreshing');
     /* if(left==0){
        onNewBlock?.call(syncHeight, left, ptc, false);
      }else{
        onNewBlock?.call(syncHeight, left, ptc, refreshing);
      }*/
      onNewBlock.call(syncHeight, bchHeight, left, refreshing);
    });
  }

  void stop() => _updateSyncInfoTimer?.cancel();
}

SyncListener setListeners(void Function(int, int, int, bool) onNewBlock,
    void Function() onNewTransaction) {
  final listener = SyncListener(onNewBlock, onNewTransaction);
  beldex_wallet.setListenerNative();
  return listener;
}

void onStartup() => beldex_wallet.onStartupNative();

void _storeSync(Object _) => beldex_wallet.storeSync();

bool _setupNodeSync(Map args) {
  final address = args['address'] as String;
  final login = (args['login'] ?? '') as String;
  final password = (args['password'] ?? '') as String;
  final useSSL = args['useSSL'] as bool;
  final isLightWallet = args['isLightWallet'] as bool;

  return setupNodeSync(
      address: address,
      login: login,
      password: password,
      useSSL: useSSL,
      isLightWallet: isLightWallet);
}

bool _isConnected(Object _) => isConnectedSync();

bool isRefreshing() => isRefreshingSync();

int _getNodeHeight(Object _) => getNodeHeightSync();

void startRefresh() => startRefreshSync();

Future setupNode(
        {required String address,
        /*String? login,
        String? password,*/
        bool useSSL = false,
        bool isLightWallet = false}) =>
    compute<Map<String, Object>, void>(_setupNodeSync, {
      'address': address,
     /* 'login': login!,
      'password': password!,*/
      'useSSL': useSSL,
      'isLightWallet': isLightWallet
    });

Future store() => compute<int, void>(_storeSync, 0);

Future<bool> isConnected() => compute(_isConnected, 0);

Future<int> getNodeHeight() => compute(_getNodeHeight, 0);

void rescanBlockchainAsync() => beldex_wallet.rescanBlockchainAsyncNative();
