import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/create_transaction_model.dart';

class CreateTransactionApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<CreateTransactionModel?> getSignature(Map<String, String> params) async {
    return callCreateTransactionApiService(params: params);
  }

  Future<CreateTransactionModel?> callCreateTransactionApiService(
      {Map? params}) async {
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.createTransaction, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.createTransaction, 'params': {}};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        return CreateTransactionModel.fromJson(resultBody);
      } else {
        print('create transaction api error: status=${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('create transaction api error: $e');
      return null;
    }
  }
}
