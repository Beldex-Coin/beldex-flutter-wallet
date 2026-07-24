import 'dart:io';

import 'package:flutter/services.dart';

class ClipboardHelper {
  static int _copyGeneration = 0;
  static const _channel = MethodChannel('io.beldex.wallet/beldex_wallet_channel');

  static Future<void> copyWithAutoClear(
      String text, {
        Duration clearAfter = const Duration(seconds: 30),
      }) async {
    final generation = ++_copyGeneration;

    if (Platform.isAndroid) {
      await _channel.invokeMethod('copySensitiveClipboard', {'text': text});
    } else {
      await Clipboard.setData(ClipboardData(text: text));
    }

    Future.delayed(clearAfter, () async {
      if (generation != _copyGeneration) return;

      if (Platform.isAndroid) {
        await _channel.invokeMethod('clearClipboard');
      } else {
        final current = await Clipboard.getData('text/plain');
        if (current?.text == text) {
          await Clipboard.setData(const ClipboardData(text: ''));
        }
      }
    });
  }
}
