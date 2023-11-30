

import 'dart:convert';

import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:http/http.dart' as http;

const fiatApiAuthority = 'api.coingecko.com';

const apiString = 'api/v3/simple/price?ids=beldex&vs_currencies=';

Future<dynamic> getPriceForGivenFiat({CryptoCurrency crypto,FiatCurrency fiat}) async{
 var price = 0.0;

 try{
  
   final uri = Uri.parse('https://$fiatApiAuthority/$apiString${fiat.toString()}');
   
   final response = await http.get(uri);
   print('responsejson ---> $response');
   final responseJSON = json.decode(response.body) as Map<String, dynamic>;
   var d = responseJSON['beldex'] as Map<String,dynamic>;
  // var priceV = d['usd'] as double;

  final covToLower = fiat.toString().toLowerCase();
  var priceV = d['$covToLower'] as double;


   final data = responseJSON.values.take(1);
  // final priceValue = data.first as List ; //as Map<String,dynamic>;
    if (responseJSON.containsKey(fiat.toString().toLowerCase())) {
      price = responseJSON[fiat.toString().toLowerCase()] as double;
    }
    print('data ---> $data');
    print('fist vaue of pice $d');
    print('price value is the $priceV');
    print('fiatprice ---> $price');
    return price;

 }catch(e){
  print(e);
    return price;
 }



}