// To parse this JSON data, do
//
//     final getCurrenciesFullModel = getCurrenciesFullModelFromJson(jsonString);

import 'dart:convert';

GetCurrenciesFullModel getCurrenciesFullModelFromJson(String str) => GetCurrenciesFullModel.fromJson(json.decode(str));

String getCurrenciesFullModelToJson(GetCurrenciesFullModel data) => json.encode(data.toJson());

class GetCurrenciesFullModel {
  String? jsonrpc;
  List<GetCurrenciesResult>? result;
  String? id;

  GetCurrenciesFullModel({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory GetCurrenciesFullModel.fromJson(Map<String, dynamic> json) => GetCurrenciesFullModel(
    jsonrpc: json["jsonrpc"],
    result: json["result"] == null ? [] : List<GetCurrenciesResult>.from(json["result"]!.map((x) => GetCurrenciesResult.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "id": id,
  };
}

class GetCurrenciesResult {
  String? name;
  String? ticker;
  String? fullName;
  bool? enabled;
  bool? enabledFrom;
  bool? enabledTo;
  bool? fixRateEnabled;
  int? payinConfirmations;
  String? addressUrl;
  String? transactionUrl;
  String? image;
  int? fixedTime;
  String? protocol;
  String? blockchain;
  Notifications? notifications;
  String? contractAddress;
  String? extraIdName;

  GetCurrenciesResult({
    this.name,
    this.ticker,
    this.fullName,
    this.enabled,
    this.enabledFrom,
    this.enabledTo,
    this.fixRateEnabled,
    this.payinConfirmations,
    this.addressUrl,
    this.transactionUrl,
    this.image,
    this.fixedTime,
    this.protocol,
    this.blockchain,
    this.notifications,
    this.contractAddress,
    this.extraIdName,
  });

  factory GetCurrenciesResult.fromJson(Map<String, dynamic> json) => GetCurrenciesResult(
    name: json["name"],
    ticker: json["ticker"],
    fullName: json["fullName"],
    enabled: json["enabled"],
    enabledFrom: json["enabledFrom"],
    enabledTo: json["enabledTo"],
    fixRateEnabled: json["fixRateEnabled"],
    payinConfirmations: json["payinConfirmations"],
    addressUrl: json["addressUrl"],
    transactionUrl: json["transactionUrl"],
    image: json["image"],
    fixedTime: json["fixedTime"],
    protocol: json["protocol"],
    blockchain: json["blockchain"],
    notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
    contractAddress: json["contractAddress"],
    extraIdName: json["extraIdName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ticker": ticker,
    "fullName": fullName,
    "enabled": enabled,
    "enabledFrom": enabledFrom,
    "enabledTo": enabledTo,
    "fixRateEnabled": fixRateEnabled,
    "payinConfirmations": payinConfirmations,
    "addressUrl": addressUrl,
    "transactionUrl": transactionUrl,
    "image": image,
    "fixedTime": fixedTime,
    "protocol": protocol,
    "blockchain": blockchain,
    "notifications": notifications?.toJson(),
    "contractAddress": contractAddress,
    "extraIdName": extraIdName,
  };
}

class Notifications {
  String? payin;
  String? payout;

  Notifications({
    this.payin,
    this.payout,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    payin: json["payin"],
    payout: json["payout"],
  );

  Map<String, dynamic> toJson() => {
    "payin": payin,
    "payout": payout,
  };
}
