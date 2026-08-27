import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/get_currencies_full_model.dart';

class GetCurrenciesFullApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<GetCurrenciesFullModel?> getSignature() async {
    return callGetCurrenciesFullApiService();
  }

  Future<GetCurrenciesFullModel?> callGetCurrenciesFullApiService(
      {Map? params}) async {
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getCurrenciesFull, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getCurrenciesFull, 'params': {}};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        return GetCurrenciesFullModel.fromJson(resultBody);
      } else {
        print('get currencies full api error: status=${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('get currencies full api error: $e');
      return null;
    }
  }
}
