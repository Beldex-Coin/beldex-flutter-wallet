
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
  ExchangeData(this.from, this.to, this.amountFrom, this.extraIdName, this.fromBlockChain, this.toBlockChain, this.fromProtocol, this.toProtocol);

  String? from;
  String? to;
  String? amountFrom;
  String? extraIdName = "";
  String? fromBlockChain;
  String? toBlockChain;
  String? fromProtocol;
  String? toProtocol;
}

class SwapTransactionHistory {
  SwapTransactionHistory(this.transactionIdList);

  List<String> transactionIdList;
}

class ExchangeDataWithRecipientAddress {
  ExchangeDataWithRecipientAddress(this.from, this.to, this.amountFrom, this.extraIdName, this.recipientAddress, this.fromBlockChain, this.toBlockChain, {this.fromProtocol, this.toProtocol, this.refundAddress});

  String? from;
  String? to;
  String? amountFrom;
  String? extraIdName = "";
  String? recipientAddress = "";
  String? fromBlockChain;
  String? toBlockChain;
  String? fromProtocol;
  String? toProtocol;
  String? refundAddress;
}

class TransactionStatus {
  TransactionStatus(this.transactionModel, this.status, this.walletAddress, {this.exchangeName});

  CreateTransactionModel transactionModel;
  String? status;
  String walletAddress;
  String? exchangeName;
}

class TransactionDetails {
  TransactionDetails(this.createTransactionModel, this.toBlockChain, this.walletAddress, {this.exchangeName});

  CreateTransactionModel? createTransactionModel;
  String? toBlockChain;
  String walletAddress;
  String? exchangeName;
}

class GetTransactionStatus {
  GetTransactionStatus(this.transactionModel, this.status, this.walletAddress, {this.exchangeName});

  GetTransactionResult? transactionModel;
  String? status;
  String walletAddress;
  String? exchangeName;
}

class TransactionDataWithWalletAddress {
  TransactionDataWithWalletAddress(this.transactionModel, this.walletAddress);

  CreateTransactionModel transactionModel;
  String walletAddress;
}

class GetTransactionStatusWithWalletAddress {
  GetTransactionStatusWithWalletAddress(this.transactionModel, this.walletAddress, {this.exchangeName});

  GetTransactionResult transactionModel;
  String walletAddress;
  String? exchangeName;
}