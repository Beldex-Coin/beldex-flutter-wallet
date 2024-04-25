import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexBnsRenewalTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexBnsRenewalTransactionCreationCredentials(
      {this.bnsName,this.mappingYears,this.priority});

  final String bnsName;
  final String mappingYears;
  final BeldexTransactionPriority priority;
}