// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountListStore on AccountListStoreBase, Store {
  late final _$accountsAtom =
      Atom(name: 'AccountListStoreBase.accounts', context: context);

  @override
  List<Account> get accounts {
    _$accountsAtom.reportRead();
    return super.accounts;
  }

  @override
  set accounts(List<Account> value) {
    _$accountsAtom.reportWrite(value, super.accounts, () {
      super.accounts = value;
    });
  }

  late final _$isValidAtom =
      Atom(name: 'AccountListStoreBase.isValid', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'AccountListStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isAccountCreatingAtom =
      Atom(name: 'AccountListStoreBase.isAccountCreating', context: context);

  @override
  bool get isAccountCreating {
    _$isAccountCreatingAtom.reportRead();
    return super.isAccountCreating;
  }

  @override
  set isAccountCreating(bool value) {
    _$isAccountCreatingAtom.reportWrite(value, super.isAccountCreating, () {
      super.isAccountCreating = value;
    });
  }

  @override
  String toString() {
    return '''
accounts: ${accounts},
isValid: ${isValid},
errorMessage: ${errorMessage},
isAccountCreating: ${isAccountCreating}
    ''';
  }
}
