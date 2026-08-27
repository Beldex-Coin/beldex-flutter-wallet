import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/get_transactions_model.dart';

class GetTransactionsApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<GetTransactionsModel?> getSignature(Map<String, String> params) async {
    return callGetTransactionsApiService(params: params);
  }

  Future<GetTransactionsModel?> getSignatureWithIds(Map<String, List<String>> params) async {
    return callGetTransactionsApiService(params: params);
  }

  Future<GetTransactionsModel?> callGetTransactionsApiService({Map? params}) async {
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getTransactions, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getTransactions, 'params': {}};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        return GetTransactionsModel.fromJson(resultBody);
      } else {
        print('get transactions api error: status=${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('get transactions api error: $e');
      return null;
    }
  }
}
