// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticationStore on AuthenticationStoreBase, Store {
  final _$stateAtom = Atom(name: 'AuthenticationStoreBase.state');

  @override
  AuthenticationState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthenticationState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'AuthenticationStoreBase.errorMessage');

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

  final _$AuthenticationStoreBaseActionController =
      ActionController(name: 'AuthenticationStoreBase');

  @override
  void created() {
    final _$actionInfo = _$AuthenticationStoreBaseActionController.startAction(
        name: 'AuthenticationStoreBase.created');
    try {
      return super.created();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restored() {
    final _$actionInfo = _$AuthenticationStoreBaseActionController.startAction(
        name: 'AuthenticationStoreBase.restored');
    try {
      return super.restored();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loggedIn() {
    final _$actionInfo = _$AuthenticationStoreBaseActionController.startAction(
        name: 'AuthenticationStoreBase.loggedIn');
    try {
      return super.loggedIn();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void inactive() {
    final _$actionInfo = _$AuthenticationStoreBaseActionController.startAction(
        name: 'AuthenticationStoreBase.inactive');
    try {
      return super.inactive();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void active() {
    final _$actionInfo = _$AuthenticationStoreBaseActionController.startAction(
        name: 'AuthenticationStoreBase.active');
    try {
      return super.active();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loggedOut() {
    final _$actionInfo = _$AuthenticationStoreBaseActionController.startAction(
        name: 'AuthenticationStoreBase.loggedOut');
    try {
      return super.loggedOut();
    } finally {
      _$AuthenticationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage}
    ''';
  }
}
