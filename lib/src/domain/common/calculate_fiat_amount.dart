import 'package:beldex_wallet/src/wallet/beldex/beldex_amount_format.dart';

String calculateFiatAmount({double price, int cryptoAmount}) {
  if (price == null || cryptoAmount == null) {
    return '0.00';
  }
  final result = price * belDexAmountToDouble(cryptoAmount);

  if (result == 0.0) {
    return '0.00';
  }

  return result > 0.01 ? result.toStringAsFixed(2) : '< 0.01';
}