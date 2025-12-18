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
      return AppColor.greyTextInCard;
    case "جاري":
      return AppColor.blue;
    case "استثماري":
      return AppColor.red;
    case "قرض":
      return AppColor.green;
    default:
      return AppColor.borderContainer;
  }
}
Color stutesAccountColor(String status) {
  switch (status) {
    case "نشط":
      return AppColor.green;
    case "موقوف":
      return AppColor.orang;
    case "مغلق":
      return AppColor.red;
    case "مجمد":
      return AppColor.blue;
    default:
      return AppColor.borderContainer;
  }
}