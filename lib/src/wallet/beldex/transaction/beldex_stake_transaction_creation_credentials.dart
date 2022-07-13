import 'package:beldex_wallet/src/wallet/transaction/transaction_creation_credentials.dart';

class BeldexStakeTransactionCreationCredentials
    extends TransactionCreationCredentials {
  BeldexStakeTransactionCreationCredentials({this.address, this.amount});

  final String address;
  final String amount;
}
