import 'dart:async';
import 'package:beldex_wallet/src/domain/common/default_settings_migration.dart';
import 'package:beldex_wallet/src/node/node_list.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/node/node.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/start_updating_price.dart';
import 'package:beldex_wallet/src/stores/sync/sync_store.dart';
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/stores/price/price_store.dart';
import 'package:beldex_wallet/src/stores/authentication/authentication_store.dart';
import 'package:beldex_wallet/src/stores/login/login_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

Timer? _reconnectionTimer;
ReactionDisposer? _connectToNodeDisposer;
ReactionDisposer? _onSyncStatusChangeDisposer;
ReactionDisposer? _onCurrentWalletChangeDisposer;

void setReactions(
    {required SettingsStore settingsStore,
    required PriceStore priceStore,
    required SyncStore syncStore,
    required WalletStore walletStore,
    required WalletService walletService,
    required AuthenticationStore authenticationStore,
    required LoginStore loginStore,
    required Box<Node> nodes,
    required SharedPreferences sharedPreferences}) {
  dynamicallySelectNode(sharedPreferences: sharedPreferences,nodes : nodes,settingsStore: settingsStore);
  connectToNode(settingsStore: settingsStore, walletStore: walletStore,sharedPreferences: sharedPreferences);
  onSyncStatusChange(
      syncStore: syncStore,
      walletStore: walletStore,
      settingsStore: settingsStore);
  onCurrentWalletChange(
      walletStore: walletStore,
      settingsStore: settingsStore,
      priceStore: priceStore);
  autorun((_) async {
    if (authenticationStore.state == AuthenticationState.allowed) {
      await loginStore.loadCurrentWallet();
      authenticationStore.state = AuthenticationState.readyToLogin;
    }
  });
}

void dynamicallySelectNode({required SharedPreferences sharedPreferences, required Box<Node> nodes, required SettingsStore settingsStore}) async {
  await resetToDefault(nodes,true);
  await changeCurrentNodeToDefault(
      sharedPreferences: sharedPreferences, nodes: nodes);
  await settingsStore.loadSettings();
}

void connectToNode({required SettingsStore settingsStore, required WalletStore walletStore, required SharedPreferences sharedPreferences}) {
  _connectToNodeDisposer?.call();
  _connectToNodeDisposer = reaction((_) => settingsStore.node,
      (Node? node) async {
    final nodeInitialSetUp = sharedPreferences.getBool('node_initial_setup');
    if(!nodeInitialSetUp!) {
      await walletStore.connectToNode(node: node);
    }else{
      await sharedPreferences.setBool('node_initial_setup', false);
    }
  });
}

void onCurrentWalletChange(
    {required WalletStore walletStore,
    required SettingsStore settingsStore,
    required PriceStore priceStore}) {
  _onCurrentWalletChangeDisposer?.call();

//_onCurrentWalletChangeDisposer = 
reaction((_) => walletStore.name, (String _) {
    walletStore.connectToNode(node: settingsStore.node);
    startUpdatingPrice(settingsStore: settingsStore, priceStore: priceStore);
  });
}

void onSyncStatusChange(
    {required SyncStore syncStore,
    required WalletStore walletStore,
    required SettingsStore settingsStore}) {
  _onSyncStatusChangeDisposer?.call();

// _onSyncStatusChangeDisposer =
  reaction((_) => syncStore.status, (SyncStatus status) async {
    if (status is ConnectedSyncStatus) {
      await walletStore.startSync();
    }

    // Reconnect to the node if the app is not started sync after 30 seconds
    if (status is StartingSyncStatus) {
      startReconnectionObserver(syncStore: syncStore, walletStore: walletStore);
    }
  });
}

void startReconnectionObserver({required SyncStore syncStore, required WalletStore walletStore}) {
  _reconnectionTimer?.cancel();
  _reconnectionTimer = Timer.periodic(Duration(seconds: 1060), (_) async {
    try {
      final isConnected = await walletStore.isConnected();

      if (isConnected !=null && !isConnected) {
        await walletStore.reconnect();
      }
    } catch (e) {
      print(e);
    }
  });
}
