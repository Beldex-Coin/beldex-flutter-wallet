import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexBnsTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexBnsTransactionCreationCredentials(
      {required this.owner, required this.backUpOwner, required this.mappingYears,required this.walletAddress,required this.bchatId,required this.belnetId,required this.bnsName,required this.priority});

  final String owner;
  final String backUpOwner;
  final String mappingYears;
  final String walletAddress;
  final String bchatId;
  final String belnetId;
  final String bnsName;
  final BeldexTransactionPriority priority;
}