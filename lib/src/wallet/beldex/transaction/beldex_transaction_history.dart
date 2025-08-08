import 'dart:core';

import 'package:flutter/services.dart';
import 'package:beldex_coin/transaction_history.dart' as beldex_transaction_history;
import 'package:beldex_wallet/src/wallet/transaction/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';
import 'package:rxdart/rxdart.dart';

List<TransactionInfo> _getAllTransactions(dynamic _) => beldex_transaction_history
    .getAllTransactions()
    .map((row) => TransactionInfo.fromRow(row))
    .toList();

class BeldexTransactionHistory extends TransactionHistory {
  BeldexTransactionHistory()
      : _transactions = BehaviorSubject<List<TransactionInfo>>.seeded([]);

  @override
  Stream<List<TransactionInfo>> get transactions => _transactions.stream;

  final BehaviorSubject<List<TransactionInfo>> _transactions;
  bool _isUpdating = false;
  bool _isRefreshing = false;
  bool _needToCheckForRefresh = false;

  @override
  Future update() async {
    if (_isUpdating) {
      return;
    }

    try {
      _isUpdating = true;
      print("RangeError-> 1");
      await refresh();
      print("RangeError-> 5");
      _transactions.value = await getAll(force: true);
      print("RangeError-> 6");
      _isUpdating = false;

      if (!_needToCheckForRefresh) {
        _needToCheckForRefresh = true;
      }
    } catch (e) {
      _isUpdating = false;
      print(e);
      print("RangeError-> 7 $e");
      rethrow;
    }
  }

  @override
  Future<List<TransactionInfo>> getAll({bool force = false}) async =>
      _getAllTransactions(null);

  @override
  Future<int> count() async => beldex_transaction_history.countOfTransactions();

  @override
  Future refresh() async {
    if (_isRefreshing) {
      return;
    }

    try {
      _isRefreshing = true;
      print("RangeError-> 2");
      beldex_transaction_history.refreshTransactions();
      print("RangeError-> 3");
      _isRefreshing = false;
    } on PlatformException catch (e) {
      _isRefreshing = false;
      print(e);
      print("RangeError-> 4 $e");
      rethrow;
    }
  }
}
