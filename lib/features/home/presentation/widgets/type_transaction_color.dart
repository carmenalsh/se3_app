import 'dart:ui';

import 'package:complaints_app/core/theme/color/app_color.dart';

Color typeTransActionColor(String status) {
  switch (status) {
    case "تحويل":
      return AppColor.green;
    case "ايداع":
      return AppColor.blue;
    case "سحب":
      return AppColor.middleGrey;

    default:
      return AppColor.borderContainer;
  }
}
