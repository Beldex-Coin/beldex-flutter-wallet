import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:beldex_coin/src/exceptions/setup_wallet_exception.dart';
import 'package:beldex_coin/src/beldex_api.dart';
import 'package:beldex_coin/src/util/convert_utf8_to_string.dart';
import 'package:beldex_coin/src/util/signatures.dart';
import 'package:beldex_coin/src/util/types.dart';

int _boolToInt(bool value) => value ? 1 : 0;

final statusSyncChannel =
    BasicMessageChannel<ByteData>('beldex_coin.sync_listener', BinaryCodec());

final oxenMethodChannel = MethodChannel('beldex_coin');

final getFileNameNative = beldexApi
    .lookup<NativeFunction<get_filename>>('get_filename')
    .asFunction<GetFilename>();

final getSeedNative =
    beldexApi.lookup<NativeFunction<get_seed>>('seed').asFunction<GetSeed>();

final getAddressNative = beldexApi
    .lookup<NativeFunction<get_address>>('get_address')
    .asFunction<GetAddress>();

final getFullBalanceNative = beldexApi
    .lookup<NativeFunction<get_full_balanace>>('get_full_balance')
    .asFunction<GetFullBalance>();

final getUnlockedBalanceNative = beldexApi
    .lookup<NativeFunction<get_unlocked_balanace>>('get_unlocked_balance')
    .asFunction<GetUnlockedBalance>();

final getCurrentHeightNative = beldexApi
    .lookup<NativeFunction<get_current_height>>('get_current_height')
    .asFunction<GetCurrentHeight>();

final getNodeHeightNative = beldexApi
    .lookup<NativeFunction<get_node_height>>('get_node_height')
    .asFunction<GetNodeHeight>();

final isRefreshingNative = beldexApi
    .lookup<NativeFunction<is_refreshing>>('is_refreshing')
    .asFunction<IsRefreshing>();

final isConnectedNative = beldexApi
    .lookup<NativeFunction<is_connected>>('is_connected')
    .asFunction<IsConnected>();

final setupNodeNative = beldexApi
      .lookup<NativeFunction<setup_node>>('setup_node')
    .asFunction<SetupNode>();

final startRefreshNative = beldexApi
    .lookup<NativeFunction<start_refresh>>('start_refresh')
    .asFunction<StartRefresh>();

final connecToNodeNative = beldexApi
    .lookup<NativeFunction<connect_to_node>>('connect_to_node')
    .asFunction<ConnectToNode>();

final setRefreshFromBlockHeightNative = beldexApi
    .lookup<NativeFunction<set_refresh_from_block_height>>(
        'set_refresh_from_block_height')
    .asFunction<SetRefreshFromBlockHeight>();

final setRecoveringFromSeedNative = beldexApi
    .lookup<NativeFunction<set_recovering_from_seed>>(
        'set_recovering_from_seed')
    .asFunction<SetRecoveringFromSeed>();

final storeNative =
    beldexApi.lookup<NativeFunction<store_c>>('store').asFunction<Store>();

final setListenerNative =
    beldexApi.lookupFunction<Void Function(), void Function()>('set_listener');

final getSyncingHeightNative = beldexApi
    .lookup<NativeFunction<get_syncing_height>>('get_syncing_height')
    .asFunction<GetSyncingHeight>();

final isNeededToRefreshNative = beldexApi
    .lookup<NativeFunction<is_needed_to_refresh>>('is_needed_to_refresh')
    .asFunction<IsNeededToRefresh>();

final isNewTransactionExistNative = beldexApi
    .lookup<NativeFunction<is_new_transaction_exist>>(
        'is_new_transaction_exist')
    .asFunction<IsNewTransactionExist>();

final getSecretViewKeyNative = beldexApi
    .lookup<NativeFunction<secret_view_key>>('secret_view_key')
    .asFunction<SecretViewKey>();

final getPublicViewKeyNative = beldexApi
    .lookup<NativeFunction<public_view_key>>('public_view_key')
    .asFunction<PublicViewKey>();

final getSecretSpendKeyNative = beldexApi
    .lookup<NativeFunction<secret_spend_key>>('secret_spend_key')
    .asFunction<SecretSpendKey>();

final getPublicSpendKeyNative = beldexApi
    .lookup<NativeFunction<secret_view_key>>('public_spend_key')
    .asFunction<PublicSpendKey>();

final closeCurrentWalletNative = beldexApi
    .lookup<NativeFunction<close_current_wallet>>('close_current_wallet')
    .asFunction<CloseCurrentWallet>();

final onStartupNative = beldexApi
    .lookup<NativeFunction<on_startup>>('on_startup')
    .asFunction<OnStartup>();

final rescanBlockchainAsyncNative = beldexApi
    .lookup<NativeFunction<rescan_blockchain>>('rescan_blockchain')
    .asFunction<RescanBlockchainAsync>();

int getNodeHeightSync() => getNodeHeightNative();

bool isRefreshingSync() => isRefreshingNative() != 0;

bool isConnectedSync() => isConnectedNative() != 0;

bool setupNodeSync(
    {required String address,
    String? login,
    String? password,
    bool useSSL = false,
    bool isLightWallet = false}) {
  final addressPointer = address.toNativeUtf8();
  Pointer<Utf8> loginPointer = nullptr;
  Pointer<Utf8> passwordPointer = nullptr;

  if (login != null) {
    loginPointer = login.toNativeUtf8();
  }

  if (password != null) {
    passwordPointer = password.toNativeUtf8();
  }

  final isSetupNode = setupNodeNative(
          addressPointer,
          loginPointer,
          passwordPointer,
          _boolToInt(useSSL),
          _boolToInt(isLightWallet));

  calloc.free(addressPointer);
  if(loginPointer != nullptr)
    calloc.free(loginPointer);
  if(passwordPointer != nullptr)
    calloc.free(passwordPointer);

  if (isSetupNode.good) {
    return true;
  }

  throw SetupWalletException(
      message: isSetupNode.errorString());
}

void startRefreshSync() => startRefreshNative();

Future<bool> connectToNode() async => connecToNodeNative().good;

void setRefreshFromBlockHeight({required int height}) =>
    setRefreshFromBlockHeightNative(height);

void setRecoveringFromSeed({required bool isRecovery}) =>
    setRecoveringFromSeedNative(_boolToInt(isRecovery));

void storeSync() {
  final pathPointer = ''.toNativeUtf8();
  storeNative(pathPointer);
  calloc.free(pathPointer);
}
