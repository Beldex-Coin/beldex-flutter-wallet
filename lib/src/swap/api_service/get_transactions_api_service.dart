import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../apiKeys.dart';
import '../model/get_transactions_model.dart';

class GetTransactionsApiService {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<GetTransactionsModel?> getSignature(Map<String, String> params) async {

    final prefs = await _prefs;
    final privacySwapApiEnable = prefs.getBool('privacySwap') ?? false;

    print('url --> 1');
    final signatureResponseBody = await callSignatureApiService(
        Apis.getTransactions,
        params: params,
        privacySwapApiEnable: privacySwapApiEnable);
    print('url --> 4');

    final signature = signatureResponseBody['signature'] as String?;
    if (signature != null) {
      final getTransactionsResponseBody = await callGetTransactionsApiService(
          Apis.getTransactions, signatureResponseBody['signature'] as String,
          params: params, privacySwapApiEnable: privacySwapApiEnable);
      return getTransactionsResponseBody;
    } else {
      return null;
    }
  }

  Future<GetTransactionsModel?> getSignatureWithIds(
      Map<String, List<String>> params) async {

    final prefs = await _prefs;
    final privacySwapApiEnable = prefs.getBool('privacySwap') ?? false;

    final signatureResponseBody = await callSignatureApiService(
        Apis.getTransactions,
        params: params,
        privacySwapApiEnable: privacySwapApiEnable);

    final signature = signatureResponseBody['signature'] as String?;
    if (signature != null) {
      final getTransactionsResponseBody = await callGetTransactionsApiService(
          Apis.getTransactions, signatureResponseBody['signature'] as String,
          params: params, privacySwapApiEnable: privacySwapApiEnable);
      return getTransactionsResponseBody;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> callSignatureApiService(String method,
      {Map<String, dynamic>? params,
      required bool privacySwapApiEnable}) async {
    Map<String, dynamic> resultBody;

    final requestBody = params != null
        ? Signature(jsonrpc: '2.0', id: 'test', method: method, params: params)
        : Signature(jsonrpc: '2.0', id: 'test', method: method, params: {});

    final url = Uri.parse(privacySwapApiEnable
        ? Apis.privacySignatureUrl
        : Apis.swapSignatureUrl);
    print('url --> $url');
    final headers = {
      'Content-type': 'application/json',
      'X-Api-Key': ApiKeys.signatureXApiKey
    };
    print('json headers --> $headers');
    final body = json.encode(requestBody);
    print('json body --> $body');
    final response = await http.post(url, headers: headers, body: body);
    resultBody = json.decode(response.body) as Map<String, dynamic>;

    print('signature data from json --> $resultBody');
    return resultBody;
  }

  Future<GetTransactionsModel> callGetTransactionsApiService(
      String method, String signature,
      {Map? params, required bool privacySwapApiEnable}) async {
    late GetTransactionsModel data;
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': {}};
      final url = Uri.parse(Apis.mainUrl);
      print('url --> $url');
      final headers = {
        'Content-type': 'application/json',
        'X-Api-Key': privacySwapApiEnable
            ? ApiKeys.privacyMainXApiKey
            : ApiKeys.swapMainXApiKey,
        'X-Api-Signature': signature
      };
      print('changelly api json headers --> $headers');
      final body = json.encode(requestBody);
      print('changelly api json body --> $body');
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        data = GetTransactionsModel.fromJson(resultBody);

        print('get transactions data from json --> $resultBody');
      } else {
        print('Error Occurred');
      }
    } catch (e) {
      print('get transactions api error occurred' + e.toString());
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
  Map<String, dynamic> params;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'jsonrpc': jsonrpc,
        'id': id,
        'method': method,
        'params': params
      };
}
