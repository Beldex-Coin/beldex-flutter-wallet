// To parse this JSON data, do
//
//     final getExchangeAmountModel = getExchangeAmountModelFromJson(jsonString);

import 'dart:convert';

GetExchangeAmountModel getExchangeAmountModelFromJson(String str) => GetExchangeAmountModel.fromJson(json.decode(str));

String getExchangeAmountModelToJson(GetExchangeAmountModel data) => json.encode(data.toJson());

class GetExchangeAmountModel {

  GetExchangeAmountModel({
    this.jsonrpc,
    this.result,
    this.error,
    this.id,
  });

  factory GetExchangeAmountModel.fromJson(Map<String, dynamic> json) => GetExchangeAmountModel(
    jsonrpc: json["jsonrpc"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
    id: json["id"],
  );
  String? jsonrpc;
  List<Result>? result;
  Error? error;
  String? id;

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "error": error?.toJson(),
    "id": id,
  };
}

class Result {

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

class Error {

  Error({
    this.code,
    this.message,
    this.data,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
  int? code;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {

  Data({
    this.limits,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    limits: json["limits"] == null ? null : Limits.fromJson(json["limits"]),
  );
  Limits? limits;

  Map<String, dynamic> toJson() => {
    "limits": limits?.toJson(),
  };
}

class Limits {

  Limits({
    this.max,
    this.min,
  });

  factory Limits.fromJson(Map<String, dynamic> json) => Limits(
    max: json["max"] == null ? null : Max.fromJson(json["max"]),
    min: json["min"] == null ? null : Max.fromJson(json["min"]),
  );
  Max? max;
  Max? min;

  Map<String, dynamic> toJson() => {
    "max": max?.toJson(),
    "min": min?.toJson(),
  };
}

class Max {

  Max({
    this.from,
    this.to,
  });

  factory Max.fromJson(Map<String, dynamic> json) => Max(
    from: json["from"],
    to: json["to"],
  );
  String? from;
  String? to;

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
  };
}
