import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/get_pairs_params_model.dart';

class GetPairsParamsApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<GetPairsParamsModel?> getSignature(List<Map<String, String>> params) async {
    return callGetPairsParamsApiService(params: params);
  }

  Future<GetPairsParamsModel> callGetPairsParamsApiService(
      {List<Map<String, dynamic>>? params}) async {
    late GetPairsParamsModel data;
    try {
      final requestBody = params != null && params.isNotEmpty
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getPairsParams, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getPairsParams, 'params': []};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        data = GetPairsParamsModel.fromJson(resultBody);
      } else {
        print('Error Occurred');
      }
    } catch (e) {
      print('get pairs params api error occurred' + e.toString());
    }
    return data;
  }
}
