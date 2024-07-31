// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$stateAtom = Atom(name: 'UserStoreBase.state', context: context);

  @override
  UserStoreState? get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UserStoreState? value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'UserStoreBase.errorMessage', context: context);

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

  late final _$setAsyncAction =
      AsyncAction('UserStoreBase.set', context: context);

  @override
  Future<dynamic> set({required String password}) {
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
