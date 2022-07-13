// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActionListStore on ActionListBase, Store {
  Computed<List<TransactionListItem>> _$transactionsComputed;

  @override
  List<TransactionListItem> get transactions => (_$transactionsComputed ??=
          Computed<List<TransactionListItem>>(() => super.transactions,
              name: 'ActionListBase.transactions'))
      .value;
  Computed<List<ActionListItem>> _$itemsComputed;

  @override
  List<ActionListItem> get items =>
      (_$itemsComputed ??= Computed<List<ActionListItem>>(() => super.items,
              name: 'ActionListBase.items'))
          .value;
  Computed<int> _$totalCountComputed;

  @override
  int get totalCount =>
      (_$totalCountComputed ??= Computed<int>(() => super.totalCount,
              name: 'ActionListBase.totalCount'))
          .value;

  final _$_transactionsAtom = Atom(name: 'ActionListBase._transactions');

  @override
  List<TransactionListItem> get _transactions {
    _$_transactionsAtom.reportRead();
    return super._transactions;
  }

  @override
  set _transactions(List<TransactionListItem> value) {
    _$_transactionsAtom.reportWrite(value, super._transactions, () {
      super._transactions = value;
    });
  }

  @override
  String toString() {
    return '''
transactions: ${transactions},
items: ${items},
totalCount: ${totalCount}
    ''';
  }
}
