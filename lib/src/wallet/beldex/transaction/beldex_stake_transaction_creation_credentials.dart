import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexStakeTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexStakeTransactionCreationCredentials({required this.address, required this.amount});

  final String address;
  final String amount;
}
