import 'dart:async';
import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_balance.dart';
import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/wallet/wallet.dart';
import 'package:beldex_wallet/src/wallet/balance.dart';
import 'package:beldex_wallet/src/domain/services/wallet_service.dart';
import 'package:beldex_wallet/src/domain/common/calculate_fiat_amount.dart';
import 'package:beldex_wallet/src/stores/price/price_store.dart';
import 'package:beldex_wallet/src/stores/settings/settings_store.dart';
import 'package:beldex_wallet/src/start_updating_price.dart';

part 'balance_store.g.dart';

class BalanceStore = BalanceStoreBase with _$BalanceStore;

abstract class BalanceStoreBase with Store {
  BalanceStoreBase(
      {
        required WalletService walletService,
        required SettingsStore settingsStore,
        required PriceStore priceStore}):
        _walletService = walletService,
        _settingsStore = settingsStore,
        _priceStore = priceStore {

    if (_walletService.currentWallet != null) {
      _onWalletChanged(_walletService.currentWallet!);
    }

    _onWalletChangeSubscription = _walletService.onWalletChange
        .listen((wallet) => _onWalletChanged(wallet));
  }

  @observable
  int fullBalance=0;

  @observable
  int unlockedBalance=0;

  @computed
  String get fullBalanceString {
    return belDexAmountToString(fullBalance, detail: _settingsStore.balanceDetail);
  }

  @computed
  String get unlockedBalanceString {
    return belDexAmountToString(unlockedBalance, detail: _settingsStore.balanceDetail);
  }

  @computed
  String get fiatFullBalance {
    final symbol = PriceStoreBase.generateSymbolForFiat(
        fiat: _settingsStore.fiatCurrency);
    final price = _priceStore.prices[symbol];
    return calculateFiatAmount(price: price!, cryptoAmount: fullBalance);
  }

  @computed
  String get fiatUnlockedBalance {
    final symbol = PriceStoreBase.generateSymbolForFiat(
        fiat: _settingsStore.fiatCurrency);
    final price = _priceStore.prices[symbol];
    return calculateFiatAmount(price: price!, cryptoAmount: unlockedBalance);
  }

  @observable
  bool isReversing=false;

  final WalletService _walletService;
  late StreamSubscription<Wallet> _onWalletChangeSubscription;
  StreamSubscription<Balance>? _onBalanceChangeSubscription;
  final SettingsStore _settingsStore;
  final PriceStore _priceStore;

//  @override
//  void dispose() {
//    _onWalletChangeSubscription.cancel();
//
//    if (_onBalanceChangeSubscription != null) {
//      _onBalanceChangeSubscription.cancel();
//    }
//
//    super.dispose();
//  }

  Future _onBalanceChange(Balance balance) async {
    final _balance = balance as BelDexBalance;

    if (fullBalance != _balance.fullBalance) {
      fullBalance = _balance.fullBalance;
    }

    if (unlockedBalance != _balance.unlockedBalance) {
      unlockedBalance = _balance.unlockedBalance;
    }
  }

  Future _onWalletChanged(Wallet wallet) async {
    if (_onBalanceChangeSubscription != null) {
      await _onBalanceChangeSubscription?.cancel();
    }

    _onBalanceChangeSubscription = _walletService.onBalanceChange
        .listen((balance) async => await _onBalanceChange(balance));

    await _updateBalances(wallet);
  }

  Future _updateBalances(Wallet? wallet) async {
    if (wallet == null) {
      return;
    }

    fullBalance = await _walletService.getFullBalance() ?? 0;
    unlockedBalance = await _walletService.getUnlockedBalance() ?? 0;
    await updateFiatBalance();
  }

  Future updateFiatBalance() async {
    await startUpdatingPrice(settingsStore: _settingsStore, priceStore: _priceStore);
  }
}
