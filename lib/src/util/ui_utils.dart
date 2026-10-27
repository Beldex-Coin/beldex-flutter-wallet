import 'package:flutter/painting.dart';

class UIUtils {
  static double fiatContainerWidth(String amount, String currency,
      {TextScaler? textScaler, double? maxWidth}) {
    final safeAmount = amount.isEmpty ? '0.00' : amount;
    final textStyle = const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'OpenSans');
    final amountPainter = TextPainter(
      text: TextSpan(text: safeAmount, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
      textScaler: textScaler ?? TextScaler.noScaling,
    )..layout();
    final currencyPainter = TextPainter(
      text: TextSpan(text: currency, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
      textScaler: textScaler ?? TextScaler.noScaling,
    )..layout();
    final width =
        24 + currencyPainter.width + 5 + amountPainter.width + 10;
    final lower = 95.0;
    final upper = maxWidth ?? 320.0;
    return width.clamp(lower, upper);
  }
}