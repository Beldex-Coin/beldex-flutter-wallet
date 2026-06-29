import 'package:flutter/services.dart';

class ClipboardHelper {
  static Future<void> copyWithAutoClear(
      String text, {
        Duration clearAfter = const Duration(seconds: 30),
      }) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    );

    Future.delayed(clearAfter, () async {
      final current =
      await Clipboard.getData('text/plain');

      if (current?.text == text) {
        await Clipboard.setData(
          const ClipboardData(text: ''),
        );
      }
    });
  }
}