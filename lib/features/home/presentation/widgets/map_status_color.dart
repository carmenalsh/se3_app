import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

Color mapStatusColor(String status) {
  switch (status) {
    case "معلقة":
      return AppColor.middleGrey;
    case "قيد المعالجة":
      return AppColor.primary;
    case "تمت معالجتها":
      return Colors.green;
    case "تم رفضها":
      return Colors.red;
    case "بحاجة لمعلومات إضافية":
      return Colors.blueGrey;
    default:
      return AppColor.borderContainer;
  }
}
