import 'dart:convert';

import 'package:beldex_wallet/src/swap/apis.dart';
import 'package:beldex_wallet/src/swap/changelly_signer.dart';
import 'package:http/http.dart' as http;

import '../apiKeys.dart';
import '../model/validate_address_model.dart';

class ValidateAddressApiService {
  final _signer = ChangellyRsaSigner(ApiKeys.changellyPrivateKeyHex);

  Future<ValidateAddressModel?> getSignature(Map<String, String> params) async {
    return callValidateAddressApiService(params: params);
  }

  Future<ValidateAddressModel?> callValidateAddressApiService(
      {Map? params}) async {
    try {
      final requestBody = params != null
          ? {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.validateAddress, 'params': params}
          : {'jsonrpc': '2.0', 'id': 'test', 'method': Apis.validateAddress, 'params': {}};
      final body = json.encode(requestBody);
      final headers = await _signer.buildSignedHeaders(body);
      final url = Uri.parse(Apis.mainUrl);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final resultBody = json.decode(response.body);
        return ValidateAddressModel.fromJson(resultBody);
      } else {
        print('validate address api error: status=${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('validate address api error: $e');
      return null;
    }
  }
}
