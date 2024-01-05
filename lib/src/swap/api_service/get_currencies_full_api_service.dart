import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCurrenciesFullApiService {

  Future<Map<String,dynamic>?> getSignature() async {
    print('url --> 1');
    final signatureResponseBody = await callSignatureApiService('getCurrenciesFull');
    print('url --> 4');
    if(signatureResponseBody['signature'] as String !=null){
      final getCurrenciesFullResponseBody = await callGetCurrenciesFullApiService('getCurrenciesFull',signatureResponseBody['signature'] as String);
      return getCurrenciesFullResponseBody;
    }else {
      return null;
    }
  }

  Future<Map<String, dynamic>> callSignatureApiService(String method,
      {Map? params}) async {
    print('url --> 2');
    Map<String, dynamic> resultBody;

    final requestBody = params != null
        ? {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': params}
        : {'jsonrpc': '2.0', 'id': 'test', 'method': method};
    print('url --> 3');
    final url = Uri.parse('https://api.beldex.io/api/v1/swap');
    print('url --> $url');
    final body = json.encode(requestBody);
    final response = await http.post(url, body: body);
    resultBody = json.decode(response.body) as Map<String, dynamic>;

    print('signature data from json --> for the node api.beldex.io/api/v1 --> $resultBody');
    return resultBody;
  }

  Future<Map<String, dynamic>> callGetCurrenciesFullApiService(String method,String signature,
      {Map? params}) async {
    print('url --> 2');
    Map<String, dynamic> resultBody;

    final requestBody = params != null
        ? {'jsonrpc': '2.0', 'id': 'test', 'method': method, 'params': params}
        : {'jsonrpc': '2.0', 'id': 'test', 'method': method};
    print('url --> 3');
    final url = Uri.parse('https://api.changelly.com/v2');
    print('url --> $url');
    final headers = {'Content-type': 'application/json','X-Api-Key': '+kLt3F2TMo8W2LbQSjs6IDaBG4O/VLZsRH+qnNX5FyU=',
      'X-Api-Signature': signature};
    final body = json.encode(requestBody);
    final response = await http.post(url, headers:headers, body: body);
    resultBody = json.decode(response.body) as Map<String,dynamic>;

    print('get currencies data from json --> for the node https://api.changelly.com/v2 --> $resultBody');
    return resultBody;
  }
}