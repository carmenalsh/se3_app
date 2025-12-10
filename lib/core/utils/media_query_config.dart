import 'package:flutter/widgets.dart';

// class SizeConfig {
//   static late MediaQueryData _mediaQueryData;
//   static late double width;
//   static late double height;

//   static void init(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//     width = _mediaQueryData.size.width;
//     height = _mediaQueryData.size.height;
//   }
// }

import 'dart:math';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double diagonal;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    diagonal = sqrt(width * width + height * height);
  }

  static double textSize(double factor) => diagonal * factor;
}
