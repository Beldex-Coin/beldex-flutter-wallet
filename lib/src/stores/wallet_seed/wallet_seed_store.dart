import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';

part 'wallet_seed_store.g.dart';

class WalletSeedStore = WalletSeedStoreBase with _$WalletSeedStore;

abstract class WalletSeedStoreBase with Store {
  WalletSeedStoreBase({required WalletService walletService}) {
    if (walletService.currentWallet != null) {
      isLoading = true;
      walletService.getSeed().then((seed) {
        this.seed = seed;
        isLoading = false;
      });
      walletService.getName().then((name) => this.name = name);
    }
  }

  @observable
  bool isLoading = false;

  @observable
  String name = '';

  @observable
  String seed = '';
}
