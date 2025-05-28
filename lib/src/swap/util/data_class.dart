
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/create_transaction_model.dart';

class Coins {
  Coins(this.id, this.name, this.extraIdName, this.bitcoin, this.protocol);

  String? id;
  String? name;
  String? extraIdName = "";
  String? bitcoin;
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
  SwapTransactionHistory(this.transactionIdList, this.secureStorage);

  List<String> transactionIdList;
  FlutterSecureStorage? secureStorage;
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
  TransactionStatus(this.transactionModel, this.status);

  CreateTransactionModel transactionModel;
  String? status;
}