import 'package:flutter/material.dart';

Widget circularProgressBar(Color color, double strokeWidth) {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(color),
    strokeWidth: strokeWidth,
  );
}