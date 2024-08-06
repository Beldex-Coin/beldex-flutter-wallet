import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';

var isQrScannerShown = false;

class QRScanException implements Exception{
  QRScanException(this.message);

  String message;

  @override
  String toString() => message;
}


Future<String?> presentQRScanner() async {
  isQrScannerShown = true;
  try {
    final ScanResult result = await BarcodeScanner.scan();

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
