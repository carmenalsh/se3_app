import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonTopPartForgetPassword extends StatelessWidget {
  const CommonTopPartForgetPassword({
    super.key,
    required this.title,
    required this.bodyText,
    required this.img,
    required this.imgHeight,
  });

  final String title;
  final String bodyText;
  final String img;
  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundWithChild(
      borderRadius: BorderRadius.circular(20),
      width: double.infinity,
      backgroundColor: AppColor.lightGreen,
      child: Column(
        children: [
          ArrowBack(),
          SvgPicture.asset(img, height: imgHeight),

          CustomTextWidget(title, fontSize: SizeConfig.diagonal * .05),
          CustomTextWidget(bodyText, color: AppColor.black),
          SizedBox(height: SizeConfig.height * .03),
        ],
      ),
    );
  }
}
