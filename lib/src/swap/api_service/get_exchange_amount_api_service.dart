import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/get_exchange_amount_model.dart';

class GetExchangeAmountApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<GetExchangeAmountModel?> getSignature(Map<String?, String?> params) async {
    return callGetExchangeAmountApiService(params: params);
  }

  Future<GetExchangeAmountModel> callGetExchangeAmountApiService(
      {Map? params}) async {
    late GetExchangeAmountModel data;
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getExchangeAmount, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.getExchangeAmount, 'params': {}};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        data = GetExchangeAmountModel.fromJson(resultBody);
      } else {
        print('Error Occurred');
      }
    } catch (e) {
      print('get exchange amount api error occurred' + e.toString());
    }
    return data;
  }
}
