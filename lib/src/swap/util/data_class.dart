
import 'package:beldex_wallet/src/swap/database/swap_transaction_history_model.dart';

class Coins {
  Coins(this.name, this.fullName, this.extraIdName, this.blockchain, this.protocol);

  String? name;
  String? fullName;
  String? extraIdName = "";
  String? blockchain;
  String? protocol;
}

class ExchangeData {
  ExchangeData(this.from, this.to, this.amountFrom, this.extraIdName, this.fromBlockChain, this.toBlockChain, this.fromProtocol, this.toProtocol, {this.exchangeName});

  String? from;
  String? to;
  String? amountFrom;
  String? extraIdName = "";
  String? fromBlockChain;
  String? toBlockChain;
  String? fromProtocol;
  String? toProtocol;
  String? exchangeName;
}

class SwapTransactionHistory {
  SwapTransactionHistory(this.walletAddress, {this.exchangeName});

  String? walletAddress;
  String? exchangeName;
}

class ExchangeDataWithRecipientAddress {
  ExchangeDataWithRecipientAddress(this.from, this.to, this.amountFrom, this.extraIdName, this.recipientAddress, this.fromBlockChain, this.toBlockChain, {this.fromProtocol, this.toProtocol, this.refundAddress, this.exchangeName});

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
  String? exchangeName;
}

class TransactionStatus {
  TransactionStatus(this.transactionModel, this.status, this.walletAddress, {this.exchangeName});

  SwapTransactionHistoryModel transactionModel;
  String? status;
  String walletAddress;
  String? exchangeName;
}

class TransactionDetails {
  TransactionDetails(this.createTransactionModel, this.toBlockChain, this.walletAddress, {this.exchangeName});

  SwapTransactionHistoryModel createTransactionModel;
  String? toBlockChain;
  String walletAddress;
  String? exchangeName;
}

class GetTransactionStatus {
  GetTransactionStatus(this.transactionModel, this.status, this.walletAddress, {this.exchangeName});

  SwapTransactionHistoryModel transactionModel;
  String? status;
  String walletAddress;
  String? exchangeName;
}

class TransactionDataWithWalletAddress {
  TransactionDataWithWalletAddress(this.transactionModel, this.walletAddress, {this.exchangeName});

  SwapTransactionHistoryModel transactionModel;
  String walletAddress;
  String? exchangeName;
}

class GetTransactionStatusWithWalletAddress {
  GetTransactionStatusWithWalletAddress(this.transactionModel, this.walletAddress, {this.exchangeName});

  SwapTransactionHistoryModel transactionModel;
  String walletAddress;
  String? exchangeName;
}