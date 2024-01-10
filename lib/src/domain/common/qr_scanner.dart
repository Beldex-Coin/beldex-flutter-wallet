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
    print("QRCode -> 0");
    final ScanResult result = await BarcodeScanner.scan();

    print("QRCode -> 1");
    isQrScannerShown = false;
    print("QRCode -> 2");
    if (result.type == ResultType.Error) {
      print("QRCode -> 3 ${result.rawContent}");
      throw QRScanException(result.rawContent);
    }
    if (result.type == ResultType.Cancelled) {
      print("QRCode -> 4");
      return null;
    }
    print("QRCode -> 5");
    return result.rawContent;
    } on PlatformException catch (e) {
    isQrScannerShown = false;
    print("QRCode -> 6 ${e.toString()}");
    throw QRScanException(e.toString());
  }
}
