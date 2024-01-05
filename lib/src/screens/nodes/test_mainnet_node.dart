import 'dart:convert';

import 'package:beldex_wallet/src/node/digest_request.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'test_mainnet_node.g.dart';

@HiveType(typeId: 1)
class TestMainNetNode extends HiveObject {
  TestMainNetNode({required this.uri, this.login, this.password});

  TestMainNetNode.fromMap(Map map)
      : uri = (map['uri'] ?? '') as String,
        login = map['login'] as String?,
        password = map['password'] as String?;

  static const boxName = 'TestMainNetNodes';

  @HiveField(0)
  String uri;

  @HiveField(1)
  String? login;

  @HiveField(2)
  String? password;

  Future<bool> isMainNet() async {
    try {
      final resBody = await sendRPCRequest('get_info');
      return (resBody['result']['mainnet'] as bool);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<String, dynamic>> sendRPCRequest(String method,
      {Map? params}) async {
    Map<String, dynamic> resultBody;

    final requestBody = params != null
        ? {'jsonrpc': '2.0', 'id': '0', 'method': method, 'params': params}
        : {'jsonrpc': '2.0', 'id': '0', 'method': method};

    /*if (login != null && password != null && login!.isNotEmpty && password!.isNotEmpty) {
      final digestRequest = DigestRequest();
      final response = await digestRequest.request(
          uri: uri, login: login, password: password, requestBody: requestBody);
      resultBody = response.data as Map<String, dynamic>;
    } else */
    final url = Uri.http(uri, '/json_rpc');
    final headers = {'Content-type': 'application/json'};
    final body = json.encode(requestBody);
    final response = await http.post(url, headers: headers, body: body).timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    resultBody = json.decode(response.body) as Map<String, dynamic>;
    return resultBody;
  }
}