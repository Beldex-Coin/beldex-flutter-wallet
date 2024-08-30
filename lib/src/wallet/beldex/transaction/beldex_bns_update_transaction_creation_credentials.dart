import 'package:beldex_wallet/src/wallet/beldex/transaction/transaction_priority.dart';
import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexBnsUpdateTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexBnsUpdateTransactionCreationCredentials(
      {required this.owner, required this.backUpOwner, required this.walletAddress, required this.bchatId, required this.belnetId, required this.ethAddress, required this.bnsName, required this.priority});

  final String owner;
  final String backUpOwner;
  final String walletAddress;
  final String bchatId;
  final String belnetId;
  final String ethAddress;
  final String bnsName;
  final BeldexTransactionPriority priority;
}