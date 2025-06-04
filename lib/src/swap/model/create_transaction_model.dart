// To parse this JSON data, do
//
//     final createTransactionModel = createTransactionModelFromJson(jsonString);

import 'dart:convert';

CreateTransactionModel createTransactionModelFromJson(String str) => CreateTransactionModel.fromJson(json.decode(str));

String createTransactionModelToJson(CreateTransactionModel data) => json.encode(data.toJson());

class CreateTransactionModel {
  String? jsonrpc;
  Result? result;
  Error? error;
  String? id;

  CreateTransactionModel({
    this.jsonrpc,
    this.result,
    this.error,
    this.id,
  });

  factory CreateTransactionModel.fromJson(Map<String, dynamic> json) => CreateTransactionModel(
    jsonrpc: json["jsonrpc"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "result": result?.toJson(),
    "error": error?.toJson(),
    "id": id,
  };
}

class Error {
  int? code;
  String? message;

  Error({
    this.code,
    this.message,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}

class Result {
  String? id;
  String? trackUrl;
  int? createdAt;
  String? type;
  int? moneyReceived;
  int? moneySent;
  String? rate;
  dynamic payinConfirmations;
  String? status;
  String? currencyFrom;
  String? currencyTo;
  String? payinAddress;
  String? payinExtraId;
  String? payinExtraIdName;
  String? payinHash;
  String? payoutHashLink;
  String? refundHashLink;
  String? amountExpectedFrom;
  String? payoutAddress;
  String? payoutExtraId;
  String? payoutExtraIdName;
  String? payoutHash;
  String? refundHash;
  String? refundAddress;
  String? refundExtraId;
  String? amountFrom;
  String? amountTo;
  String? amountExpectedTo;
  String? networkFee;
  String? changellyFee;
  String? apiExtraFee;
  String? totalFee;
  bool? canPush;
  bool? canRefund;
  DateTime? payTill;

  Result({
    this.id,
    this.trackUrl,
    this.createdAt,
    this.type,
    this.moneyReceived,
    this.moneySent,
    this.rate,
    this.payinConfirmations,
    this.status,
    this.currencyFrom,
    this.currencyTo,
    this.payinAddress,
    this.payinExtraId,
    this.payinExtraIdName,
    this.payinHash,
    this.payoutHashLink,
    this.refundHashLink,
    this.amountExpectedFrom,
    this.payoutAddress,
    this.payoutExtraId,
    this.payoutExtraIdName,
    this.payoutHash,
    this.refundHash,
    this.refundAddress,
    this.refundExtraId,
    this.amountFrom,
    this.amountTo,
    this.amountExpectedTo,
    this.networkFee,
    this.changellyFee,
    this.apiExtraFee,
    this.totalFee,
    this.canPush,
    this.canRefund,
    this.payTill,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    trackUrl: json["trackUrl"],
    createdAt: json["createdAt"],
    type: json["type"],
    moneyReceived: json["moneyReceived"],
    moneySent: json["moneySent"],
    rate: json["rate"],
    payinConfirmations: json["payinConfirmations"],
    status: json["status"],
    currencyFrom: json["currencyFrom"],
    currencyTo: json["currencyTo"],
    payinAddress: json["payinAddress"],
    payinExtraId: json["payinExtraId"],
    payinExtraIdName: json["payinExtraIdName"],
    payinHash: json["payinHash"],
    payoutHashLink: json["payoutHashLink"],
    refundHashLink: json["refundHashLink"],
    amountExpectedFrom: json["amountExpectedFrom"],
    payoutAddress: json["payoutAddress"],
    payoutExtraId: json["payoutExtraId"],
    payoutExtraIdName: json["payoutExtraIdName"],
    payoutHash: json["payoutHash"],
    refundHash: json["refundHash"],
    refundAddress: json["refundAddress"],
    refundExtraId: json["refundExtraId"],
    amountFrom: json["amountFrom"],
    amountTo: json["amountTo"],
    amountExpectedTo: json["amountExpectedTo"],
    networkFee: json["networkFee"],
    changellyFee: json["changellyFee"],
    apiExtraFee: json["apiExtraFee"],
    totalFee: json["totalFee"],
    canPush: json["canPush"],
    canRefund: json["canRefund"],
    payTill: json["payTill"] == null ? null : DateTime.parse(json["payTill"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trackUrl": trackUrl,
    "createdAt": createdAt,
    "type": type,
    "moneyReceived": moneyReceived,
    "moneySent": moneySent,
    "rate": rate,
    "payinConfirmations": payinConfirmations,
    "status": status,
    "currencyFrom": currencyFrom,
    "currencyTo": currencyTo,
    "payinAddress": payinAddress,
    "payinExtraId": payinExtraId,
    "payinExtraIdName": payinExtraIdName,
    "payinHash": payinHash,
    "payoutHashLink": payoutHashLink,
    "refundHashLink": refundHashLink,
    "amountExpectedFrom": amountExpectedFrom,
    "payoutAddress": payoutAddress,
    "payoutExtraId": payoutExtraId,
    "payoutExtraIdName": payoutExtraIdName,
    "payoutHash": payoutHash,
    "refundHash": refundHash,
    "refundAddress": refundAddress,
    "refundExtraId": refundExtraId,
    "amountFrom": amountFrom,
    "amountTo": amountTo,
    "amountExpectedTo": amountExpectedTo,
    "networkFee": networkFee,
    "changellyFee": changellyFee,
    "apiExtraFee": apiExtraFee,
    "totalFee": totalFee,
    "canPush": canPush,
    "canRefund": canRefund,
    "payTill": payTill?.toIso8601String(),
  };
}
