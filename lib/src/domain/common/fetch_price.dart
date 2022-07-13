import 'dart:convert';

import 'package:beldex_wallet/src/domain/common/crypto_currency.dart';
import 'package:beldex_wallet/src/domain/common/fiat_currency.dart';
import 'package:http/http.dart';

const fiatApiAuthority = 'api.beldex.io';

Future<double> fetchPriceFor({CryptoCurrency crypto, FiatCurrency fiat}) async {
  var price = 0.0;

  try {
    final fiatStringed = fiat.toString();

    final apiPath = '/price/$fiatStringed';
    final uri = Uri.https(fiatApiAuthority, apiPath);
    final response = await get(uri);

    if (response.statusCode != 200) {
      return 0.0;
    }

    final responseJSON = json.decode(response.body) as Map<String, dynamic>;

    if (responseJSON.containsKey(fiatStringed.toLowerCase())) {
      price = responseJSON[fiatStringed.toLowerCase()] as double;
    }

    return price;
  } catch (e) {
    return price;
  }
}
