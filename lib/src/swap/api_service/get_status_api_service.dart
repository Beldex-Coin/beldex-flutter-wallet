import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/get_status_model.dart';

class GetStatusApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<GetStatusModel?> getSignature(Map<String, String> params) async {
    return callGetStatusApiService(params: params);
  }

  Future<GetStatusModel?> callGetStatusApiService({Map? params}) async {
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getStatus, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getStatus, 'params': {}};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        return GetStatusModel.fromJson(resultBody);
      } else {
        print('get status api error: status=${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('get status api error: $e');
      return null;
    }
  }
}
