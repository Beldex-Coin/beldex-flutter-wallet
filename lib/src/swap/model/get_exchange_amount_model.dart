// To parse this JSON data, do
//
//     final getExchangeAmountModel = getExchangeAmountModelFromJson(jsonString);

import 'dart:convert';

GetExchangeAmountModel getExchangeAmountModelFromJson(String str) => GetExchangeAmountModel.fromJson(json.decode(str));

String getExchangeAmountModelToJson(GetExchangeAmountModel data) => json.encode(data.toJson());

class GetExchangeAmountModel {
  String? jsonrpc;
  List<Result>? result;
  String? id;

  GetExchangeAmountModel({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory GetExchangeAmountModel.fromJson(Map<String, dynamic> json) => GetExchangeAmountModel(
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
  String? from;
  String? to;
  String? networkFee;
  String? amountFrom;
  String? amountTo;
  String? max;
  String? maxFrom;
  String? maxTo;
  String? min;
  String? minFrom;
  String? minTo;
  String? visibleAmount;
  String? rate;
  String? fee;

  Result({
    this.from,
    this.to,
    this.networkFee,
    this.amountFrom,
    this.amountTo,
    this.max,
    this.maxFrom,
    this.maxTo,
    this.min,
    this.minFrom,
    this.minTo,
    this.visibleAmount,
    this.rate,
    this.fee,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    from: json["from"],
    to: json["to"],
    networkFee: json["networkFee"],
    amountFrom: json["amountFrom"],
    amountTo: json["amountTo"],
    max: json["max"],
    maxFrom: json["maxFrom"],
    maxTo: json["maxTo"],
    min: json["min"],
    minFrom: json["minFrom"],
    minTo: json["minTo"],
    visibleAmount: json["visibleAmount"],
    rate: json["rate"],
    fee: json["fee"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "networkFee": networkFee,
    "amountFrom": amountFrom,
    "amountTo": amountTo,
    "max": max,
    "maxFrom": maxFrom,
    "maxTo": maxTo,
    "min": min,
    "minFrom": minFrom,
    "minTo": minTo,
    "visibleAmount": visibleAmount,
    "rate": rate,
    "fee": fee,
  };
}
