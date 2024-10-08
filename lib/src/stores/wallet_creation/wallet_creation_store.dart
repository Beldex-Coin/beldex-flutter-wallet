import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/stores/wallet_creation/wallet_creation_state.dart';
import 'package:beldex_wallet/src/stores/authentication/authentication_store.dart';
import '../../../l10n.dart';

part 'wallet_creation_store.g.dart';

class WalletCreationStore = WalletCreationStoreBase with _$WalletCreationStore;

abstract class WalletCreationStoreBase with Store {
  WalletCreationStoreBase(
      {required this.authStore,
        required this.walletListService,
        required this.sharedPreferences}):
    state = WalletCreationStateInitial();

  final AuthenticationStore authStore;
  final WalletListService walletListService;
  final SharedPreferences sharedPreferences;

  @observable
  WalletCreationState state;

  String? errorMessage;

  @action
  Future create({required String name, required String language}) async {
    state = WalletCreationStateInitial();

    try {
      state = WalletIsCreating();
      await walletListService.create(name, language);
      authStore.created();
      state = WalletCreatedSuccessfully();
    } catch (e) {
      state = WalletCreationFailure(error: e.toString());
    }
  }

  void validateWalletName(String value,AppLocalizations t) {
    const pattern = '^[a-zA-Z0-9_]{1,255}\$';
    final regExp = RegExp(pattern);
    final isValid = regExp.hasMatch(value);
    errorMessage = isValid ? null : t.enterAValidNameUpto15Characters;
  }
}
