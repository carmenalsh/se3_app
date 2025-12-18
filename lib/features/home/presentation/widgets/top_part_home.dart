import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/databases/cache/cache_helper.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common widget/custom_background_with_child.dart';

class TopPartHome extends StatelessWidget {
  const TopPartHome({
    super.key,

    required this.onTapServices,
    required this.onTapAccountsManag,

  });


  final void Function() onTapServices;
  final void Function() onTapAccountsManag;


  @override
  Widget build(BuildContext context) {
    String welcomeMessage = CacheHelper.getData(key: "welcomeMessage") ?? "";
    return CustomBackgroundWithChild(
      width: double.infinity,
      backgroundColor: AppColor.primary,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: SizeConfig.height * .028,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextWidget(
                  welcomeMessage,
                  color: AppColor.white,
                  fontSize: SizeConfig.diagonal * .028,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height * .02),
            Row(
              children: [
                CustomButtonWidget(
                  borderRadius: 6,
                  childHorizontalPad: SizeConfig.width * .005,
                  // childVerticalPad: SizeConfig.height * .002,
                  backgroundColor: AppColor.lightGreen,
                  onTap: onTapServices,
                  
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: AppColor.primary,
                          size: SizeConfig.height * .025,
                        ),
                        SizedBox(width: SizeConfig.width * .01),
                        CustomTextWidget(
                          "خدمات نقد",
                          fontSize: SizeConfig.diagonal * .025,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CustomButtonWidget(
                  borderRadius: 6,
                  childHorizontalPad: SizeConfig.width * .005,
                  //childVerticalPad: SizeConfig.height * .002,
                  backgroundColor: AppColor.darkGrey,
                  onTap: onTapAccountsManag,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImage.manageAccount,
                          width: SizeConfig.width * 0.05,
                          height: SizeConfig.height * 0.02,
                        ),
                        SizedBox(width: SizeConfig.width * .02),
                        CustomTextWidget(
                          "إدارة حساباتك",
                          fontSize: SizeConfig.diagonal * .025,
                          color: AppColor.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



