// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletListStore on WalletListStoreBase, Store {
  final _$walletsAtom = Atom(name: 'WalletListStoreBase.wallets');

  @override
  List<WalletDescription> get wallets {
    _$walletsAtom.reportRead();
    return super.wallets;
  }

  @override
  set wallets(List<WalletDescription> value) {
    _$walletsAtom.reportWrite(value, super.wallets, () {
      super.wallets = value;
    });
  }

  final _$updateWalletListAsyncAction =
      AsyncAction('WalletListStoreBase.updateWalletList');

  @override
  Future<void> updateWalletList() {
    return _$updateWalletListAsyncAction.run(() => super.updateWalletList());
  }

  final _$loadWalletAsyncAction = AsyncAction('WalletListStoreBase.loadWallet');

  @override
  Future<void> loadWallet(WalletDescription wallet) {
    return _$loadWalletAsyncAction.run(() => super.loadWallet(wallet));
  }

  final _$removeAsyncAction = AsyncAction('WalletListStoreBase.remove');

  @override
  Future<void> remove(WalletDescription wallet) {
    return _$removeAsyncAction.run(() => super.remove(wallet));
  }

  @override
  String toString() {
    return '''
wallets: ${wallets}
    ''';
  }
}
