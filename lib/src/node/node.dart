import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'node.g.dart';

@HiveType(typeId: 1)
class Node extends HiveObject {
  Node({required this.uri, this.login, this.password});

  Node.fromMap(Map map)
      : uri = (map['uri'] ?? '') as String,
        login = map['login'] as String?,
        password = map['password'] as String?;

  static const boxName = 'Nodes';

  @HiveField(0)
  String uri;

  @HiveField(1)
  String? login;

  @HiveField(2)
  String? password;

  Future<bool> isOnline() async {
    final resBody = await sendRPCRequest('get_info');
    return resBody!=null ? true : false;
  }

  Future<Map<String, dynamic>?> sendRPCRequest(String method,
      {Map? params}) async {
    try {
      final requestBody = {
        'jsonrpc': '2.0',
        'id': '0',
        'method': method,
        if (params != null) 'params': params,
      };

      final url = Uri.http(uri, '/json_rpc');
      final headers = {'Content-Type': 'application/json'};

      final response = await http
          .post(url, headers: headers, body: json.encode(requestBody));

      if (response.statusCode != 200) {
        print('node data from json --> HTTP ${response.statusCode} from node $uri');
        return null;
      }

      // Attempt to decode JSON safely
      final dynamic decoded = json.decode(response.body);
      if (decoded is! Map<String, dynamic>) {
        print('node data from json --> Unexpected response format from node $uri: ${response.body}');
        return null;
      }

      print('node data from json --> $uri: $decoded');
      return decoded;

    } on SocketException catch (e) {
      print('node data from json --> Network error when contacting node $uri: $e');
      return null;
    } on http.ClientException catch (e) {
      print('node data from json --> Client exception for node $uri: $e');
      return null;
    } on FormatException catch (e) {
      print('node data from json --> Invalid JSON response from node $uri: $e');
      return null;
    } catch (e) {
      print('node data from json --> Unexpected error when calling node $uri: $e');
      return null;
    }
  }
}
