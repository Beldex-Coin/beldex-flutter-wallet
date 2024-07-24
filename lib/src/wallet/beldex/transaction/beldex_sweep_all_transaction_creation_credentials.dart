import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexSweepAllTransactionCreationCredentials extends TransactionCreationCredentials{
  BeldexSweepAllTransactionCreationCredentials({required this.priority});

  final BeldexTransactionPriority priority;
}