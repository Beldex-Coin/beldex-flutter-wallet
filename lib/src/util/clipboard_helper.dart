import 'package:flutter/services.dart';

class ClipboardHelper {
  static int _copyGeneration = 0;

  static Future<void> copyWithAutoClear(
      String text, {
        Duration clearAfter = const Duration(seconds: 30),
      }) async {
    final generation = ++_copyGeneration;

    await Clipboard.setData(
      ClipboardData(text: text),
    );

    Future.delayed(clearAfter, () async {
      if (generation != _copyGeneration) return;

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