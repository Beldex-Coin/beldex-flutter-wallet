import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../../l10n.dart';

var isQrScannerShown = false;

class QRScanException implements Exception{
  QRScanException(this.message);

  String message;

  @override
  String toString() => message;
}

ScanOptions buildScanOptions(BuildContext context) {
  final translations = tr(context);

  return ScanOptions(
    strings: {
      'cancel': translations.cancel,
      'flash_on': translations.flash_on,
      'flash_off': translations.flash_off,
    },
    android: AndroidOptions(
      appBarTitle: translations.wallet_list_title,
    ),
  );
}

Future<String?> presentQRScanner(BuildContext context) async {
  isQrScannerShown = true;
  try {
    final ScanResult result = await BarcodeScanner.scan(options: buildScanOptions(context));

    isQrScannerShown = false;
    if (result.type == ResultType.Error) {
      throw QRScanException(result.rawContent);
    }
    if (result.type == ResultType.Cancelled) {
      return null;
    }
    return result.rawContent;
  } on PlatformException catch (e) {
    isQrScannerShown = false;
    throw QRScanException(e.toString());
  }
}
