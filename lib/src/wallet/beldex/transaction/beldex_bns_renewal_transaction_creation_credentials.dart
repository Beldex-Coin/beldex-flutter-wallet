import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexBnsRenewalTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexBnsRenewalTransactionCreationCredentials(
      {required this.bnsName,required this.mappingYears,required this.priority});

  final String bnsName;
  final String mappingYears;
  final BeldexTransactionPriority priority;
}