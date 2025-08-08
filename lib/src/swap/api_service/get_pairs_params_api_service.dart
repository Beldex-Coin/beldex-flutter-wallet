import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/get_pairs_params_model.dart';

class GetPairsParamsApiService {
  Future<GetPairsParamsModel?> getSignature(List<Map<String, String>> params) async {
    print('url --> 1');
    final signatureResponseBody = await callSignatureApiService(Apis.getPairsParams,params: params);
    print('url --> 4');
    if (signatureResponseBody['signature'] as String != null) {
      final getPairsParamsResponseBody =
      await callGetPairsParamsApiService(Apis.getPairsParams,
          signatureResponseBody['signature'] as String,params: params);
      return getPairsParamsResponseBody;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> callSignatureApiService(String method,
      {List<Map<String, dynamic>>? params}) async {
    Map<String, dynamic> resultBody;

    final requestBody = params!.isNotEmpty
        ? Signature(jsonrpc: '2.0', id: 'test', method: method, params: params)
        : Signature(jsonrpc: '2.0', id: 'test', method: method, params: []);

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

  Future<GetPairsParamsModel> callGetPairsParamsApiService(
      String method, String signature,
      {List<Map<String, dynamic>>? params}) async {
    late GetPairsParamsModel data;
    try {
      final requestBody = params!.isNotEmpty
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': []};
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
        data = GetPairsParamsModel.fromJson(resultBody);

        print('get pairs params data from json --> $resultBody');
      } else {
        print('Error Occurred');
      }
    } catch (e) {
      print('get pairs params api error occurred' + e.toString());
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
  List<Map<String, dynamic>> params;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'jsonrpc': jsonrpc,
    'id': id,
    'method': method,
    'params': params
  };
}
