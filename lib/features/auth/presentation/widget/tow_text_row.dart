import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class TowTextRow extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const TowTextRow({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextWidget(
          text,
          fontSize: SizeConfig.diagonal * .018,
          color: AppColor.middleGrey,
        ),
        InkWell(
          onTap: onTap,
          child: CustomTextWidget(
            actionText,
            fontSize: SizeConfig.diagonal * .02,
            color: AppColor.primary,
          ),
        ),
      ],
    );
  }
}
