import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/node/sync_status.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';

part 'sync_store.g.dart';

class SyncStore = SyncStoreBase with _$SyncStore;

abstract class SyncStoreBase with Store {
  SyncStoreBase(
      {SyncStatus syncStatus = const NotConnectedSyncStatus(0),
        required WalletService walletService}):
        status = syncStatus
  {

    if (walletService.currentWallet != null) {
      unawaited(_onWalletChanged(walletService.currentWallet!));
    }

    _onWalletChangeSubscription =
        walletService.onWalletChange.listen(_onWalletChanged);
  }

  @observable
  SyncStatus status;

  late StreamSubscription<Wallet> _onWalletChangeSubscription;
  StreamSubscription<SyncStatus>? _onSyncStatusChangeSubscription;

  void dispose() {
    unawaited(_onSyncStatusChangeSubscription?.cancel());
    unawaited(_onWalletChangeSubscription.cancel());
  }

  Future<void> _onWalletChanged(Wallet wallet) async {
    await _onSyncStatusChangeSubscription?.cancel();

    _onSyncStatusChangeSubscription =
        wallet.syncStatus.listen((status) => this.status = status);
  }
}
