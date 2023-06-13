import 'dart:convert';

import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:http/http.dart' as http;

//const fiatApiAuthority = 'api.beldex.io';
const fiatApiAuthority = 'api.coingecko.com';

const apiString = 'api/v3/simple/price?ids=beldex&vs_currencies=';
Future<double> fetchPriceFor({CryptoCurrency crypto, FiatCurrency fiat}) async {
  var price = 0.0;

  try {
    // final fiatStringed = fiat.toString();

    // final apiPath = '/price/$fiatStringed';
    // //final uri = Uri.https(fiatApiAuthority, apiPath);
    // final uri = Uri.parse('https://$fiatApiAuthority$apiPath');
    // final response = await get(uri);
    // print('FetchPRICEFOR $response');
    // if (response.statusCode != 200) {
    //   return 0.0;
    // }

    // final responseJSON = json.decode(response.body) as Map<String, dynamic>;

    // if (responseJSON.containsKey(fiatStringed.toLowerCase())) {
    //   price = responseJSON[fiatStringed.toLowerCase()] as double;
    // }

  final uri = Uri.parse('https://$fiatApiAuthority/$apiString${fiat.toString()}');
   
   final response = await http.get(uri);
   print('responsejson ---> $response');
   if(response.statusCode == 200){
      final responseJSON = json.decode(response.body) as Map<String, dynamic>;
   final data = responseJSON['beldex'] as Map<String,dynamic>;

   final covToLower = fiat.toString().toLowerCase();
     price = data['$covToLower'] as double;
    print('data ---> $data');
    print('fist vaue of pice $data');
    print('price value is the $price');
    print('fiatprice ---> $price');

   }
    return price;
  } catch (e) {
    return price;
  }
}
