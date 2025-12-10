import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 85, width: 1.8, color: AppColor.middleGrey);
  }
}
