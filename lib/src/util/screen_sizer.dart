import 'package:flutter/widgets.dart';

class ScreenSize {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double screenHeight05 = 0;
  static double screenHeight06 = 0;
  static double screenHeight07 = 0;
  static double screenHeight1 = 0;
  static double screenHeight2 = 0;
  static double screenHeight035 = 0;
  static double screenHeight025 = 0;
  static double screenHeight071 = 0;
  static double screenHeight070 = 0;
  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    screenHeight05 = mediaQuery.size.height * 0.05 / 3;
    screenHeight06 = mediaQuery.size.height * 0.06 / 3;
    screenHeight07 = mediaQuery.size.height * 0.07 / 3;
    screenHeight1 = mediaQuery.size.height * 1.0 / 3;
    screenHeight2 = mediaQuery.size.height * 2.0 / 3;
    screenHeight035 = mediaQuery.size.height * 0.35 / 3;
    screenHeight025 = mediaQuery.size.height * 0.25 / 3;
    screenHeight071 = mediaQuery.size.height * 0.71 / 3;
    screenHeight070 = mediaQuery.size.height * 0.70/3;
  }
}
