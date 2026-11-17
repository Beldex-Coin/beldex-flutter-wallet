// To parse this JSON data, do
//
//     final getStatusModel = getStatusModelFromJson(jsonString);

import 'dart:convert';

GetStatusModel getStatusModelFromJson(String str) => GetStatusModel.fromJson(json.decode(str));

String getStatusModelToJson(GetStatusModel data) => json.encode(data.toJson());

class GetStatusModel {

  GetStatusModel({
    this.jsonrpc,
    this.result,
    this.id,
  });

  factory GetStatusModel.fromJson(Map<String, dynamic> json) => GetStatusModel(
    jsonrpc: json["jsonrpc"],
    result: json["result"],
    id: json["id"],
  );
  String? jsonrpc;
  String? result;
  String? id;

  Map<String, dynamic> toJson() => {
    "jsonrpc": jsonrpc,
    "result": result,
    "id": id,
  };
}
