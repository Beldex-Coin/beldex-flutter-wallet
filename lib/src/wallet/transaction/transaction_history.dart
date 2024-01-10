import 'package:rxdart/rxdart.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_info.dart';

abstract class TransactionHistory {
  Stream<List<TransactionInfo>> get transactions;
  Future<List<TransactionInfo>> getAll();
  Future<int> count();
  Future refresh();
  Future update();
}
