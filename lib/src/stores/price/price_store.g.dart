// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PriceStore on PriceStoreBase, Store {
  final _$pricesAtom = Atom(name: 'PriceStoreBase.prices');

  @override
  ObservableMap<String, double> get prices {
    _$pricesAtom.reportRead();
    return super.prices;
  }

  @override
  set prices(ObservableMap<String, double> value) {
    _$pricesAtom.reportWrite(value, super.prices, () {
      super.prices = value;
    });
  }

  final _$PriceStoreBaseActionController =
      ActionController(name: 'PriceStoreBase');

  @override
  void changePriceForPair(
      {FiatCurrency fiat, CryptoCurrency crypto, double price}) {
    final _$actionInfo = _$PriceStoreBaseActionController.startAction(
        name: 'PriceStoreBase.changePriceForPair');
    try {
      return super.changePriceForPair(fiat: fiat, crypto: crypto, price: price);
    } finally {
      _$PriceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
prices: ${prices}
    ''';
  }
}
