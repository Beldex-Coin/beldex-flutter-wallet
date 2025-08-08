// To parse this JSON data, do
//
//     final validateAddressModel = validateAddressModelFromJson(jsonString);

import 'dart:convert';

ValidateAddressModel validateAddressModelFromJson(String str) => ValidateAddressModel.fromJson(json.decode(str));

String validateAddressModelToJson(ValidateAddressModel data) => json.encode(data.toJson());

class ValidateAddressModel {
  String? jsonrpc;
  Result? result;
  String? id;

  ValidateAddressModel({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory ValidateAddressModel.fromJson(Map<String, dynamic> json) => ValidateAddressModel(
    jsonrpc: json["jsonrpc"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "result": result?.toJson(),
    "id": id,
  };
}

class Result {
  bool? result;
  String? message;

  Result({
    this.result,
    this.message,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}
