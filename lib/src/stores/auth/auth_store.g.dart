// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on AuthStoreBase, Store {
  final _$stateAtom = Atom(name: 'AuthStoreBase.state');

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_failureCounterAtom = Atom(name: 'AuthStoreBase._failureCounter');

  @override
  int get _failureCounter {
    _$_failureCounterAtom.reportRead();
    return super._failureCounter;
  }

  @override
  set _failureCounter(int value) {
    _$_failureCounterAtom.reportWrite(value, super._failureCounter, () {
      super._failureCounter = value;
    });
  }

  final _$authAsyncAction = AsyncAction('AuthStoreBase.auth');

  @override
  Future<dynamic> auth({String password}) {
    return _$authAsyncAction.run(() => super.auth(password: password));
  }

  final _$AuthStoreBaseActionController =
      ActionController(name: 'AuthStoreBase');

  @override
  void biometricAuth() {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.biometricAuth');
    try {
      return super.biometricAuth();
    } finally {
      _$AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
