// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on UserStoreBase, Store {
  final _$stateAtom = Atom(name: 'UserStoreBase.state');

  @override
  UserStoreState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UserStoreState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$errorMessageAtom = Atom(name: 'UserStoreBase.errorMessage');

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

  final _$setAsyncAction = AsyncAction('UserStoreBase.set');

  @override
  Future<dynamic> set({String password}) {
    return _$setAsyncAction.run(() => super.set(password: password));
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage}
    ''';
  }
}
