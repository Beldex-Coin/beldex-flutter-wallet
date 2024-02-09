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
  String? status;
  String? currencyFrom;
  String? currencyTo;
  String? payinAddress;
  String? amountExpectedFrom;
  String? payoutAddress;
  String? payoutExtraId;
  String? amountExpectedTo;

  Result({
    this.id,
    this.trackUrl,
    this.createdAt,
    this.type,
    this.status,
    this.currencyFrom,
    this.currencyTo,
    this.payinAddress,
    this.amountExpectedFrom,
    this.payoutAddress,
    this.payoutExtraId,
    this.amountExpectedTo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    trackUrl: json["trackUrl"],
    createdAt: json["createdAt"],
    type: json["type"],
    status: json["status"],
    currencyFrom: json["currencyFrom"],
    currencyTo: json["currencyTo"],
    payinAddress: json["payinAddress"],
    amountExpectedFrom: json["amountExpectedFrom"],
    payoutAddress: json["payoutAddress"],
    payoutExtraId: json["payoutExtraId"],
    amountExpectedTo: json["amountExpectedTo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trackUrl": trackUrl,
    "createdAt": createdAt,
    "type": type,
    "status": status,
    "currencyFrom": currencyFrom,
    "currencyTo": currencyTo,
    "payinAddress": payinAddress,
    "amountExpectedFrom": amountExpectedFrom,
    "payoutAddress": payoutAddress,
    "payoutExtraId": payoutExtraId,
    "amountExpectedTo": amountExpectedTo,
  };
}
