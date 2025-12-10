import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/widget/down_part_welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: WelcomeViewBody()));
  }
}

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                AppImage.splashLogo,
                height: SizeConfig.height * .065,
              ),
            ),
    
            Expanded(
              flex: 0,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "ن",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontFamily: AppFonts.tasees,
                        fontSize: SizeConfig.diagonal * .05,
                      ),
                    ),
                    TextSpan(
                      text: "قد",
                      style: TextStyle(
                        color: AppColor.black,
                        fontFamily: AppFonts.tasees,
                        fontSize: SizeConfig.diagonal * .05,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
    
        Stack(
          children: [
            SizedBox(
              width: SizeConfig.width * 1,
              child: SvgPicture.asset(
                //height: 120,
                width: SizeConfig.width * 1.6,
                AppImage.zigzagLine,
                fit: BoxFit.cover,
              ),
            ),
    
            Positioned(
              left: SizeConfig.width * 0.26,
              right: SizeConfig.width * 0.26,
              top: SizeConfig.height * .1,
              child: CustomBackgroundWithChild(
                height: SizeConfig.height * .09,
                //width: 100,
                backgroundColor: AppColor.lightGreen,
                borderRadius: BorderRadius.circular(15),
                childHorizontalPad: 10,
                childVerticalPad: 2,
                child: CustomTextWidget(
                  "مرحبا بك !",
                  fontSize: SizeConfig.diagonal * .037,
                ),
              ),
            ),
          ],
        ),
    
        DownPartWelcome(),
      ],
    );
  }
}
