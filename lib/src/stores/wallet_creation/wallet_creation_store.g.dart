// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_creation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalletCreationStore on WalletCreationStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'WalletCreationStoreBase.state', context: context);

  @override
  WalletCreationState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(WalletCreationState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$createAsyncAction =
      AsyncAction('WalletCreationStoreBase.create', context: context);

  @override
  Future<dynamic> create({required String name, required String language}) {
    return _$createAsyncAction
        .run(() => super.create(name: name, language: language));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
