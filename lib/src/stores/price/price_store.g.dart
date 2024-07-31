// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PriceStore on PriceStoreBase, Store {
  late final _$pricesAtom =
      Atom(name: 'PriceStoreBase.prices', context: context);

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

  late final _$PriceStoreBaseActionController =
      ActionController(name: 'PriceStoreBase', context: context);

  @override
  void changePriceForPair({required FiatCurrency fiat, required double price}) {
    final _$actionInfo = _$PriceStoreBaseActionController.startAction(
        name: 'PriceStoreBase.changePriceForPair');
    try {
      return super.changePriceForPair(fiat: fiat, price: price);
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
