// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalletListStore on WalletListStoreBase, Store {
  late final _$walletsAtom =
      Atom(name: 'WalletListStoreBase.wallets', context: context);

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

  late final _$updateWalletListAsyncAction =
      AsyncAction('WalletListStoreBase.updateWalletList', context: context);

  @override
  Future<void> updateWalletList() {
    return _$updateWalletListAsyncAction.run(() => super.updateWalletList());
  }

  late final _$loadWalletAsyncAction =
      AsyncAction('WalletListStoreBase.loadWallet', context: context);

  @override
  Future<void> loadWallet(WalletDescription wallet) {
    return _$loadWalletAsyncAction.run(() => super.loadWallet(wallet));
  }

  late final _$removeAsyncAction =
      AsyncAction('WalletListStoreBase.remove', context: context);

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
