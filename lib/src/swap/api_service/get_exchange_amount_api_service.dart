import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/get_exchange_amount_model.dart';

class GetExchangeAmountApiService {
  Future<GetExchangeAmountModel?> getSignature(Map<String?, String?> params) async {
    print('url --> 1');
    final signatureResponseBody =
    await callSignatureApiService(Apis.getExchangeAmount,params: params);
    print('url --> 4');
    if (signatureResponseBody['signature'] as String != null) {
      final getExchangeAmountResponseBody =
      await callGetExchangeAmountApiService(Apis.getExchangeAmount,
          signatureResponseBody['signature'] as String,params: params);
      return getExchangeAmountResponseBody;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> callSignatureApiService(String method,
      {Map<String?, dynamic?>? params}) async {
    Map<String, dynamic> resultBody;

    final requestBody = params != null
        ? Signature(jsonrpc: '2.0', id: 'test', method: method, params: params)
        : Signature(jsonrpc: '2.0', id: 'test', method: method, params: {});

    final url = Uri.parse(Apis.signatureUrl);
    print('url --> $url');
    final headers = {'Content-type': 'application/json'};
    final body = json.encode(requestBody);
    print('json body --> $body');
    final response = await http.post(url, headers: headers, body: body);
    resultBody = json.decode(response.body) as Map<String, dynamic>;

    print('signature data from json --> $resultBody');
    return resultBody;
  }

  Future<GetExchangeAmountModel> callGetExchangeAmountApiService(
      String method, String signature,
      {Map? params}) async {
    late GetExchangeAmountModel data;
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': {}};
      final url = Uri.parse(Apis.mainUrl);
      print('url --> $url');
      final headers = {
        'Content-type': 'application/json',
        'X-Api-Key': '+kLt3F2TMo8W2LbQSjs6IDaBG4O/VLZsRH+qnNX5FyU=',
        'X-Api-Signature': signature
      };
      final body = json.encode(requestBody);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        data = GetExchangeAmountModel.fromJson(resultBody);

        print('get exchange amount data from json --> $resultBody');
      } else {
        print('Error Occurred');
      }
    } catch (e) {
      print('get exchange amount api error occurred' + e.toString());
    }
    return data;
  }
}

class Signature {
  Signature(
      {required this.jsonrpc,
        required this.id,
        required this.method,
        required this.params});

  String jsonrpc;
  String id;
  String method;
  Map<String?, dynamic?> params;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'jsonrpc': jsonrpc,
    'id': id,
    'method': method,
    'params': params
  };
}
