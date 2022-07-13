// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_keys_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletKeysStore on WalletKeysStoreBase, Store {
  final _$publicViewKeyAtom = Atom(name: 'WalletKeysStoreBase.publicViewKey');

  @override
  String get publicViewKey {
    _$publicViewKeyAtom.reportRead();
    return super.publicViewKey;
  }

  @override
  set publicViewKey(String value) {
    _$publicViewKeyAtom.reportWrite(value, super.publicViewKey, () {
      super.publicViewKey = value;
    });
  }

  final _$privateViewKeyAtom = Atom(name: 'WalletKeysStoreBase.privateViewKey');

  @override
  String get privateViewKey {
    _$privateViewKeyAtom.reportRead();
    return super.privateViewKey;
  }

  @override
  set privateViewKey(String value) {
    _$privateViewKeyAtom.reportWrite(value, super.privateViewKey, () {
      super.privateViewKey = value;
    });
  }

  final _$publicSpendKeyAtom = Atom(name: 'WalletKeysStoreBase.publicSpendKey');

  @override
  String get publicSpendKey {
    _$publicSpendKeyAtom.reportRead();
    return super.publicSpendKey;
  }

  @override
  set publicSpendKey(String value) {
    _$publicSpendKeyAtom.reportWrite(value, super.publicSpendKey, () {
      super.publicSpendKey = value;
    });
  }

  final _$privateSpendKeyAtom =
      Atom(name: 'WalletKeysStoreBase.privateSpendKey');

  @override
  String get privateSpendKey {
    _$privateSpendKeyAtom.reportRead();
    return super.privateSpendKey;
  }

  @override
  set privateSpendKey(String value) {
    _$privateSpendKeyAtom.reportWrite(value, super.privateSpendKey, () {
      super.privateSpendKey = value;
    });
  }

  @override
  String toString() {
    return '''
publicViewKey: ${publicViewKey},
privateViewKey: ${privateViewKey},
publicSpendKey: ${publicSpendKey},
privateSpendKey: ${privateSpendKey}
    ''';
  }
}
