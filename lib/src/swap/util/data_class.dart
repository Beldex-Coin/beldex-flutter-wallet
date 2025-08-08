
import 'package:beldex_wallet/src/stores/wallet/wallet_store.dart';
import 'package:beldex_wallet/src/swap/model/get_transactions_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/create_transaction_model.dart';

class Coins {
  Coins(this.name, this.fullName, this.extraIdName, this.blockchain, this.protocol);

  String? name;
  String? fullName;
  String? extraIdName = "";
  String? blockchain;
  String? protocol;
}

class ExchangeData {
  ExchangeData(this.from, this.to, this.amountFrom, this.extraIdName, this.fromBlockChain, this.toBlockChain, this.protocol);

  String? from;
  String? to;
  String? amountFrom;
  String? extraIdName = "";
  String? fromBlockChain;
  String? toBlockChain;
  String? protocol;
}

class SwapTransactionHistory {
  SwapTransactionHistory(this.transactionIdList);

  List<String> transactionIdList;
}

class ExchangeDataWithRecipientAddress {
  ExchangeDataWithRecipientAddress(this.from, this.to, this.amountFrom, this.extraIdName, this.recipientAddress, this.fromBlockChain, this.toBlockChain);

  String? from;
  String? to;
  String? amountFrom;
  String? extraIdName = "";
  String? recipientAddress = "";
  String? fromBlockChain;
  String? toBlockChain;
}

class TransactionStatus {
  TransactionStatus(this.transactionModel, this.status, this.walletAddress);

  CreateTransactionModel transactionModel;
  String? status;
  String walletAddress;
}

class TransactionDetails {
  TransactionDetails(this.createTransactionModel, this.fromBlockChain, this.walletAddress);

  CreateTransactionModel? createTransactionModel;
  String? fromBlockChain;
  String walletAddress;
}

class GetTransactionStatus {
  GetTransactionStatus(this.transactionModel, this.status, this.walletAddress);

  GetTransactionResult? transactionModel;
  String? status;
  String walletAddress;
}

class TransactionDataWithWalletAddress {
  TransactionDataWithWalletAddress(this.transactionModel, this.walletAddress);

  CreateTransactionModel transactionModel;
  String walletAddress;
}

class GetTransactionStatusWithWalletAddress {
  GetTransactionStatusWithWalletAddress(this.transactionModel, this.walletAddress);

  GetTransactionResult transactionModel;
  String walletAddress;
}