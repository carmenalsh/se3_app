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

Color accountTypeColor(String status) {
  switch (status) {
    case "توفير":
      return AppColor.middleGrey;
    case "جاري":
      return AppColor.blue;
    case "استثماري":
      return AppColor.green;
    case "قرض":
      return AppColor.red;
    default:
      return AppColor.borderContainer;
  }
}
