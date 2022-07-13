// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_creation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WalletCreationStore on WalletCreationStoreBase, Store {
  final _$stateAtom = Atom(name: 'WalletCreationStoreBase.state');

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

  final _$errorMessageAtom = Atom(name: 'WalletCreationStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$isValidAtom = Atom(name: 'WalletCreationStoreBase.isValid');

  @override
  bool get isValid {
    _$isValidAtom.reportRead();
    return super.isValid;
  }

  @override
  set isValid(bool value) {
    _$isValidAtom.reportWrite(value, super.isValid, () {
      super.isValid = value;
    });
  }

  final _$createAsyncAction = AsyncAction('WalletCreationStoreBase.create');

  @override
  Future<dynamic> create({String name, String language}) {
    return _$createAsyncAction
        .run(() => super.create(name: name, language: language));
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage},
isValid: ${isValid}
    ''';
  }
}
