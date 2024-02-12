// To parse this JSON data, do
//
//     final getTransactionsModel = getTransactionsModelFromJson(jsonString);

import 'dart:convert';

GetTransactionsModel getTransactionsModelFromJson(String str) => GetTransactionsModel.fromJson(json.decode(str));

String getTransactionsModelToJson(GetTransactionsModel data) => json.encode(data.toJson());

class GetTransactionsModel {
  String? jsonrpc;
  List<Result>? result;
  String? id;

  GetTransactionsModel({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory GetTransactionsModel.fromJson(Map<String, dynamic> json) => GetTransactionsModel(
    jsonrpc: json["jsonrpc"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "id": id,
  };
}

class Result {
  String? id;
  String? trackUrl;
  int? createdAt;
  String? type;
  String? rate;
  int? payinConfirmations;
  String? status;
  String? currencyFrom;
  String? currencyTo;
  String? payinAddress;
  String? amountExpectedFrom;
  String? payoutAddress;
  String? amountFrom;
  String? amountTo;
  String? amountExpectedTo;
  String? networkFee;
  String? changellyFee;
  String? apiExtraFee;
  bool? canPush;
  bool? canRefund;

  Result({
    this.id,
    this.trackUrl,
    this.createdAt,
    this.type,
    this.rate,
    this.payinConfirmations,
    this.status,
    this.currencyFrom,
    this.currencyTo,
    this.payinAddress,
    this.amountExpectedFrom,
    this.payoutAddress,
    this.amountFrom,
    this.amountTo,
    this.amountExpectedTo,
    this.networkFee,
    this.changellyFee,
    this.apiExtraFee,
    this.canPush,
    this.canRefund,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    trackUrl: json["trackUrl"],
    createdAt: json["createdAt"],
    type: json["type"],
    rate: json["rate"],
    payinConfirmations: json["payinConfirmations"],
    status: json["status"],
    currencyFrom: json["currencyFrom"],
    currencyTo: json["currencyTo"],
    payinAddress: json["payinAddress"],
    amountExpectedFrom: json["amountExpectedFrom"],
    payoutAddress: json["payoutAddress"],
    amountFrom: json["amountFrom"],
    amountTo: json["amountTo"],
    amountExpectedTo: json["amountExpectedTo"],
    networkFee: json["networkFee"],
    changellyFee: json["changellyFee"],
    apiExtraFee: json["apiExtraFee"],
    canPush: json["canPush"],
    canRefund: json["canRefund"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "trackUrl": trackUrl,
    "createdAt": createdAt,
    "type": type,
    "rate": rate,
    "payinConfirmations": payinConfirmations,
    "status": status,
    "currencyFrom": currencyFrom,
    "currencyTo": currencyTo,
    "payinAddress": payinAddress,
    "amountExpectedFrom": amountExpectedFrom,
    "payoutAddress": payoutAddress,
    "amountFrom": amountFrom,
    "amountTo": amountTo,
    "amountExpectedTo": amountExpectedTo,
    "networkFee": networkFee,
    "changellyFee": changellyFee,
    "apiExtraFee": apiExtraFee,
    "canPush": canPush,
    "canRefund": canRefund,
  };
}
