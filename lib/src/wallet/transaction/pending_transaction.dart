import 'package:flutter/foundation.dart';
import 'package:beldex_coin/transaction_history.dart' as transaction_history;
import 'package:beldex_coin/beldex_coin_structs.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';

class PendingTransaction {
  /*PendingTransaction(
      {required this.amount, required this.fee, required this.hash});*/

  PendingTransaction.fromTransactionDescription(
      PendingTransactionDescription transactionDescription)
      : amount = belDexAmountToString(transactionDescription.amount),
        fee = belDexAmountToString(transactionDescription.fee),
        hash = transactionDescription.hash,
        _pointerAddress = transactionDescription.pointerAddress;

  final String amount;
  final String fee;
  final String hash;

  final int _pointerAddress;

  Future<void> commit() async => transaction_history
      .commitTransactionFromPointerAddress(address: _pointerAddress);
}
