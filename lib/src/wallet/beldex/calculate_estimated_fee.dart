import 'package:beldex_coin/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';

double calculateEstimatedFee({required BeldexTransactionPriority priority}) {
  return belDexAmountToDouble(estimateTransactionFee(priority.raw));
}
