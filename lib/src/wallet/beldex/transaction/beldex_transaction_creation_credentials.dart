import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexTransactionCreationCredentials(
      {required this.address, required this.priority, this.amount});

  final String address;
  final String? amount;
  final BeldexTransactionPriority priority;
}
