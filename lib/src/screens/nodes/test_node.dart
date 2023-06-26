import 'dart:convert';

import 'package:http/http.dart' as http;
class NodeForTest{



    Future<bool> isWorkingNode(String node) async {
    try{
         final resBody = await sendRPCRequest('getlastblockheader', node);
         print('resbody --> $resBody');
         return resBody;
    //  if(resBody.isNotEmpty){
    //   print('response value from checkedWorkingNode $resBody');
    //   return true;
    //  }
    }catch(e){
      print(e);
       return false;
    }
   
    //!(resBody['result']['offline'] as bool);
  }

  Future<bool> sendRPCRequest(String method,String nodeUri,
      {Map params}) async {
    Map<String, dynamic> resultBody;
    bool flag = false;
    final requestBody = params != null
        ? {'jsonrpc': '2.0', 'id': '0', 'method': method, 'params': params}
        : {'jsonrpc': '2.0', 'id': '0', 'method': method};
    // if (login != null && password != null) {
    //   final digestRequest = DigestRequest();
    //   final response = await digestRequest.request(
    //       uri: uri, login: login, password: password, requestBody: requestBody);
    //   resultBody = response.data as Map<String, dynamic>;
    // } else {
      try{
       final url = Uri.http(nodeUri, '/json_rpc');
       print('url full string $url');
      final headers = {'Content-type': 'application/json'};
      final body = json.encode(requestBody);

      final response =
          await http.post(url, body: body);
        if(response.statusCode == 200){
            resultBody = json.decode(response.body) as Map<String, dynamic>;

            if(resultBody != null) {
              flag = true;
            }
        }
     
  
      }catch(e){
         print(e);
      }
       //}

    return flag;
  }

}