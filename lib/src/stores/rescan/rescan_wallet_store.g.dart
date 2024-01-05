// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rescan_wallet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RescanWalletStore on RescanWalletStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'RescanWalletStoreBase.state', context: context);

  @override
  RescanWalletState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(RescanWalletState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$rescanCurrentWalletAsyncAction = AsyncAction(
      'RescanWalletStoreBase.rescanCurrentWallet',
      context: context);

  @override
  Future<dynamic> rescanCurrentWallet({required int restoreHeight}) {
    return _$rescanCurrentWalletAsyncAction
        .run(() => super.rescanCurrentWallet(restoreHeight: restoreHeight));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
