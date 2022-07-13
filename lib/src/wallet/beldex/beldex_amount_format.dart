import 'package:intl/intl.dart';
import 'package:beldex_wallet/src/wallet/crypto_amount_format.dart';

const belDexAmountDivider = 1000000000;

String belDexAmountToString(int amount,
    {AmountDetail detail = AmountDetail.ultra}) {
  final beldexAmountFormat = NumberFormat()
    ..maximumFractionDigits = detail.fraction
    ..minimumFractionDigits = 1;
  return beldexAmountFormat.format(belDexAmountToDouble(amount));
}

double belDexAmountToDouble(int amount) =>
    cryptoAmountToDouble(amount: amount, divider: belDexAmountDivider);
