import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownPartWelcome extends StatelessWidget {
  const DownPartWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundWithChild(
      borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      width: double.infinity,
      backgroundColor: AppColor.primary,
      child: Column(
        children: [
          SizedBox(height: 10),
          Divider(
            color: AppColor.white,
            thickness: 3,
            indent: 130,
            endIndent: 130,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: CustomTextWidget(
              color: AppColor.white,
              fontSize: SizeConfig.diagonal * .03,
              "تطبيق يساعد المستخدمين على\n تتبع معاملاتهم المالية بكل سهولة\n وأمان وبساطة",
            ),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonWidget(
                backgroundColor: AppColor.white,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .015,
                borderRadius: 30,
                onTap: () {
                  debugPrint(" registerrrr");
                  context.pushNamed(AppRouteRName.registerView);
                },
                child: CustomTextWidget(
                  "حساب جديد",
                  fontSize: SizeConfig.height * .025,
                  color: AppColor.black,
                ),
              ),
              CustomButtonWidget(
                backgroundColor: AppColor.darkGrey,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .015,
                borderRadius: 30,
                onTap: () {
                  context.pushNamed(AppRouteRName.loginView);

                  debugPrint(" loginnnnnnnnn ");
                },
                child: CustomTextWidget(
                  "تسجيل الدخول",
                  fontSize: SizeConfig.height * .025,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
