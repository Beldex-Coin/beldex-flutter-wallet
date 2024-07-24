// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$stateAtom = Atom(name: 'AuthStoreBase.state', context: context);

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

  late final _$_failureCounterAtom =
      Atom(name: 'AuthStoreBase._failureCounter', context: context);

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

  late final _$authAsyncAction =
      AsyncAction('AuthStoreBase.auth', context: context);

  @override
  Future<dynamic> auth({required String password, required AppLocalizations l10n}) {
    return _$authAsyncAction
        .run(() => super.auth(password: password, l10n: l10n));
  }

  late final _$AuthStoreBaseActionController =
      ActionController(name: 'AuthStoreBase', context: context);

  @override
  void biometricAuth(AppLocalizations t) {
    final _$actionInfo = _$AuthStoreBaseActionController.startAction(
        name: 'AuthStoreBase.biometricAuth');
    try {
      return super.biometricAuth(t);
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
