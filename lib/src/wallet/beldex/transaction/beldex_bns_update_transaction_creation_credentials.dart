import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexBnsUpdateTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexBnsUpdateTransactionCreationCredentials(
      {this.owner, this.backUpOwner, this.walletAddress,this.bchatId,this.belnetId,this.bnsName,this.priority});

  final String owner;
  final String backUpOwner;
  final String walletAddress;
  final String bchatId;
  final String belnetId;
  final String bnsName;
  final BeldexTransactionPriority priority;
}