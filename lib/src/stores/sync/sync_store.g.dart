// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SyncStore on SyncStoreBase, Store {
  final _$statusAtom = Atom(name: 'SyncStoreBase.status');

  @override
  SyncStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(SyncStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
