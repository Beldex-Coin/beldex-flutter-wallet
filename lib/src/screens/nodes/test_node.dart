import 'dart:convert';

import 'package:http/http.dart' as http;

class NodeForTest {
  Future<bool> isWorkingNode(String node) async {
    try {
      final resBody = await sendRPCRequest('getlastblockheader', node);
      return resBody;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> sendRPCRequest(String method, String nodeUri,
      {Map? params}) async {
    Map<String, dynamic> resultBody;
    var flag = false;
    final requestBody = params != null
        ? {'jsonrpc': '2.0', 'id': '0', 'method': method, 'params': params}
        : {'jsonrpc': '2.0', 'id': '0', 'method': method};
    try {
      final url = Uri.http(nodeUri, '/json_rpc');
      print('url full string $url');
      final headers = {'Content-type': 'application/json'};
      final body = json.encode(requestBody);

      final response = await http.post(url, body: body).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      if (response.statusCode == 200) {
        resultBody = json.decode(response.body) as Map<String, dynamic>;

        if (resultBody != null) {
          flag = true;
        }
      }
    } catch (e) {
      print(e);
    }
    return flag;
  }
}
