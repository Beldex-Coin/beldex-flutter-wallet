import 'package:flutter/painting.dart';

class UIUtils {
  static double fiatContainerWidth(String amount, String currency) {
    final safeAmount = amount.isEmpty ? '0.00' : amount;
    final textStyle = TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500);
    final amountPainter = TextPainter(
      text: TextSpan(text: safeAmount, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final currencyPainter = TextPainter(
      text: TextSpan(text: currency, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final width = 24 + currencyPainter.width + 8 + amountPainter.width + 5;
    return width.clamp(95.0, 320.0);
  }
}