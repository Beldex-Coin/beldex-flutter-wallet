import 'package:beldex_coin/transaction_history.dart';
import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';
import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';

/// Estimated transaction fee computed on a background isolate.
///
/// Keeps the blocking native call (and its mutex wait) off the UI thread so
/// the UI cannot hang or trigger an ANR.
Future<double> calculateEstimatedFeeAsync({
  required BeldexTransactionPriority priority,
}) async {
  final raw = await estimateTransactionFeeAsync(priorityRaw: priority.raw);
  return belDexAmountToDouble(raw);
}