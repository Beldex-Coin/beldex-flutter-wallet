import 'package:mobx/mobx.dart';
import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';

part 'price_store.g.dart';

class PriceStore = PriceStoreBase with _$PriceStore;

abstract class PriceStoreBase with Store {
  PriceStoreBase() : prices = ObservableMap();

  static String generateSymbolForPair(
          {FiatCurrency fiat, CryptoCurrency crypto}) =>
      crypto.toString().toUpperCase() + fiat.toString().toUpperCase();

  @observable
  ObservableMap<String, double> prices;

  // @action
  // Future updatePrice({FiatCurrency fiat, CryptoCurrency crypto}) async {
  //   final symbol = generateSymbolForPair(fiat: fiat, crypto: crypto);
  //   final price = await fetchPriceFor(fiat: fiat, crypto: crypto);
  //   prices[symbol] = price;
  // }

  @action
  void changePriceForPair(
      {FiatCurrency fiat, CryptoCurrency crypto, double price}) {
    final symbol = generateSymbolForPair(fiat: fiat, crypto: crypto);
    prices[symbol] = price;
  }
}
