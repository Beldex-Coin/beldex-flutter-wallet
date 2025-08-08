// To parse this JSON data, do
//
//     final getPairsParamsModel = getPairsParamsModelFromJson(jsonString);

import 'dart:convert';

GetPairsParamsModel getPairsParamsModelFromJson(String str) => GetPairsParamsModel.fromJson(json.decode(str));

String getPairsParamsModelToJson(GetPairsParamsModel data) => json.encode(data.toJson());

class GetPairsParamsModel {
  String? jsonrpc;
  List<Result>? result;
  String? id;

  GetPairsParamsModel({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory GetPairsParamsModel.fromJson(Map<String, dynamic> json) => GetPairsParamsModel(
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
  String? minAmountFloat;
  String? maxAmountFloat;
  String? minAmountFixed;
  String? maxAmountFixed;

  Result({
    this.from,
    this.to,
    this.minAmountFloat,
    this.maxAmountFloat,
    this.minAmountFixed,
    this.maxAmountFixed,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    from: json["from"],
    to: json["to"],
    minAmountFloat: json["minAmountFloat"],
    maxAmountFloat: json["maxAmountFloat"],
    minAmountFixed: json["minAmountFixed"],
    maxAmountFixed: json["maxAmountFixed"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "minAmountFloat": minAmountFloat,
    "maxAmountFloat": maxAmountFloat,
    "minAmountFixed": minAmountFixed,
    "maxAmountFixed": maxAmountFixed,
  };
}
