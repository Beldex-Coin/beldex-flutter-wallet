import 'package:flutter/material.dart';
import 'package:qr/qr.dart';

class QrPainter extends CustomPainter {
  QrPainter(
    String data,
    this.color,
    this.version,
    this.errorCorrectionLevel,
  ) : _qr = QrCode(version, errorCorrectionLevel)..addData(data) {
    _p.color = color;

    //qrImage.addData(data);
    //qrImage.make();
    qrImage = QrImage(_qr);
  }

  final int version;
  final int errorCorrectionLevel;
  final Color color;

  final QrCode _qr;
  late final QrImage qrImage;
  final _p = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final squareSize = size.shortestSide / qrImage.moduleCount;
    for (var x = 0; x < qrImage.moduleCount; x++) {
      for (var y = 0; y < qrImage.moduleCount; y++) {
        if (qrImage.isDark(y, x)) {
          final squareRect = Rect.fromLTWH(
              x * squareSize, y * squareSize, squareSize, squareSize);
          canvas.drawRect(squareRect, _p);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is QrPainter) {
      return color != oldDelegate.color ||
          errorCorrectionLevel != oldDelegate.errorCorrectionLevel ||
          version != oldDelegate.version;
    }
    
    return false;
  }
}
