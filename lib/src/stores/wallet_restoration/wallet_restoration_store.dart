import 'package:mobx/mobx.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beldex_wallet/src/domain/services/wallet_list_service.dart';
import 'package:beldex_wallet/src/wallet/mnemotic_item.dart';
import 'package:beldex_wallet/src/stores/wallet_restoration/wallet_restoration_state.dart';
import 'package:beldex_wallet/src/stores/authentication/authentication_store.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/generated/l10n.dart';

part 'wallet_restoration_store.g.dart';

class WalletRestorationStore = WalletRestorationStoreBase
    with _$WalletRestorationStore;

abstract class WalletRestorationStoreBase with Store {
  WalletRestorationStoreBase(
      {this.seed,
      @required this.authStore,
      @required this.walletListService,
      @required this.sharedPreferences}) {
    state = WalletRestorationStateInitial();
  }

  final AuthenticationStore authStore;
  final WalletListService walletListService;
  final SharedPreferences sharedPreferences;

  @observable
  WalletRestorationState state;

  @observable
  String errorMessage;

  @observable
  bool isValid;

  @observable
  List<MnemoticItem> seed;

  @action
  Future restoreFromSeed({String name, String seed, int restoreHeight}) async {
    state = WalletRestorationStateInitial();
    final _seed = seed ?? _seedText();

    try {
      state = WalletIsRestoring();
      await walletListService.restoreFromSeed(name, _seed, restoreHeight);
      authStore.restored();
      state = WalletRestoredSuccessfully();
    } catch (e) {
      state = WalletRestorationFailure(error: e.toString());
    }
  }

  @action
  Future restoreFromKeys(
      {String name,
      String language,
      String address,
      String viewKey,
      String spendKey,
      int restoreHeight}) async {
    state = WalletRestorationStateInitial();

    try {
      state = WalletIsRestoring();
      await walletListService.restoreFromKeys(
          name, language, restoreHeight, address, viewKey, spendKey);
      authStore.restored();
      state = WalletRestoredSuccessfully();
    } catch (e) {
      state = WalletRestorationFailure(error: 'Check your keys');
    }
  }

  @action
  void setSeed(List<MnemoticItem> seed) {
    this.seed = seed;
  }

  @action
  void validateSeed(List<MnemoticItem> seed) {
    final _seed = seed ?? this.seed;
    var isValid = _seed != null ? _seed.length == 25 : false;

    if (!isValid) {
      errorMessage = S.current.wallet_restoration_store_incorrect_seed_length;
      this.isValid = isValid;
      return;
    }

    for (final item in _seed) {
      if (!item.isCorrect()) {
        isValid = false;
        break;
      }
    }

    if (isValid) {
      errorMessage = null;
    }

    this.isValid = isValid;
    return;
  }

  String _seedText() {
    return seed.fold('', (acc, item) => acc + ' ' + item.toString());
  }

  void validateWalletName(String value) {
   // const pattern = '^[a-zA-Z0-9_]{1,15}\$';
    const pattern = r'^(?=.{1,15}$)[a-zA-Z0-9]+$';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    errorMessage = isValid ? null : S.current.enterAValidNameUpto15Characters;
  }

  void validateAddress(String value, {CryptoCurrency cryptoCurrency}) {
    // OXEN (95, 106), XMR (95, 106), ADA (59, 92, 105), BCH (42), BNB (42),
    // BTC (34, 42), DASH (34), EOS (42), ETH (42), LTC (34), NANO (64, 65),
    // TRX (34), USDT (42), XLM (56), XRP (34)
    const pattern = '^[0-9a-zA-Z]{95}\$|^[0-9a-zA-Z]{34}\$|^[0-9a-zA-Z]{42}\$|^[0-9a-zA-Z]{56}\$|^[0-9a-zA-Z]{59}\$|^[0-9a-zA-Z_]{64}\$|^[0-9a-zA-Z_]{65}\$|^[0-9a-zA-Z]{92}\$|^[0-9a-zA-Z]{105}\$|^[0-9a-zA-Z]{106}\$|^[0-9a-zA-Z]{97}\$';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    if (isValid && cryptoCurrency != null) {
      switch (cryptoCurrency) {
        case CryptoCurrency.xmr:
        case CryptoCurrency.bdx:
          isValid = (value.length == 95)||(value.length == 106)||(value.length == 97);
          break;
        case CryptoCurrency.bch:
        case CryptoCurrency.bnb:
        case CryptoCurrency.usdt:
        case CryptoCurrency.eos:
        case CryptoCurrency.eth:
          isValid = (value.length == 42);
          break;
        case CryptoCurrency.dash:
        case CryptoCurrency.ltc:
        case CryptoCurrency.trx:
        case CryptoCurrency.xrp:
          isValid = (value.length == 34);
          break;
        case CryptoCurrency.ada:
          isValid = (value.length == 59)||(value.length == 92)||(value.length == 105);
          break;
        case CryptoCurrency.btc:
          isValid = (value.length == 34)||(value.length == 42);
          break;
        case CryptoCurrency.nano:
          isValid = (value.length == 64)||(value.length == 65);
          break;
        case CryptoCurrency.xlm:
          isValid = (value.length == 56);
          break;
      }
    }

    errorMessage = isValid ? null : S.current.error_text_address;
  }

  void validateKeys(String value) {
    const pattern = '^[A-Fa-f0-9]{64}\$';
    final regExp = RegExp(pattern);
    isValid = regExp.hasMatch(value);
    errorMessage = isValid ? null : S.current.error_text_keys;
  }
}
