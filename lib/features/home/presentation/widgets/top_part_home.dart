import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_feild.dart';
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
    required this.onChangedSearch,
    required this.onTapServices,
    required this.onTapNotification,
    required this.onSearchTap,
    required this.onTapCancel,
  });

  final void Function(String) onChangedSearch;
  final void Function() onTapServices;
  final void Function() onTapNotification;
  final void Function(String) onSearchTap;
  final void Function() onTapCancel;

  @override
  Widget build(BuildContext context) {
    // String welcomeMessage = CacheHelper.getData(key: "welcomeMessage") ?? "";
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
                  //  welcomeMessage,
                  "مرحبا صديقي المستخدم محمد منصور",
                  color: AppColor.white,
                  fontSize: SizeConfig.diagonal * .028,
                ),

                // Spacer(),
                // CustomButtonWidget(
                //   borderRadius: 30,
                //   childHorizontalPad: 3,
                //   childVerticalPad: 3,
                //   backgroundColor: AppColor.white,
                //   onTap: onTapLogout,
                //   child: Icon(
                //     Icons.login_outlined,
                //     color: AppColor.middleGrey,
                //     size: SizeConfig.height * .038,
                //   ),
                // ),

                // SizedBox(width: SizeConfig.width * .02),

                // CustomButtonWidget(
                //   borderRadius: 30,
                //   childHorizontalPad: 3,
                //   childVerticalPad: 3,
                //   backgroundColor: AppColor.white,
                //   onTap: onTapNotification,
                //   child: Icon(
                //     Icons.notification_important_outlined,
                //     color: AppColor.middleGrey,
                //     size: SizeConfig.height * .038,
                //   ),
                // ),
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
                  // ()
                  //async
                  // {
                  // FocusManager.instance.primaryFocus?.unfocus();

                  // final result = await context.pushNamed<bool>(
                  //   AppRouteRName.submitComplaintView,
                  // );

                  // if (result == true) {
                  //   context.read<HomeCubit>().loadComplaints();
                  // }
                  // },
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
                  onTap:
                      ()
                      //async
                      {
                        // FocusManager.instance.primaryFocus?.unfocus();

                        // final result = await context.pushNamed<bool>(
                        //   AppRouteRName.submitComplaintView,
                        // );

                        // if (result == true) {
                        //   context.read<HomeCubit>().loadComplaints();
                        // }
                      },
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
            // HomeSearchField(
            //   onChangedSearch: onChangedSearch,
            //   onSearchTap: onSearchTap, // يرسل النص
            //   onCancelTap: onTapCancel,
            // ),
          ],
        ),
      ),
    );
  }
}

class HomeSearchField extends StatefulWidget {
  const HomeSearchField({
    super.key,
    required this.onChangedSearch,
    required this.onSearchTap,
    required this.onCancelTap,
  });

  final ValueChanged<String> onChangedSearch;
  final ValueChanged<String> onSearchTap;
  final VoidCallback onCancelTap;

  @override
  State<HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends State<HomeSearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchPressed() {
    FocusScope.of(context).unfocus();

    final text = _controller.text.trim();
    widget.onSearchTap(text);
  }

  void _onCancelPressed() {
    _controller.clear();
    FocusScope.of(context).unfocus();
    widget.onCancelTap();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: SizeConfig.width * .65,
          height: SizeConfig.height * .06,
          child: CustomTextField(
            controller: _controller,
            hint: 'البحث في سجل الشكاوي...',
            suffixIcon: Icons.search,
            hintFontSize: SizeConfig.diagonal * .022,
            borderRadius: 30,
            keyboardType: TextInputType.number,
            onChanged: widget.onChangedSearch,
            onSuffixTap: _onSearchPressed,
          ),
        ),
        CustomButtonWidget(
          borderRadius: 30,
          childHorizontalPad: SizeConfig.width * .06,
          childVerticalPad: SizeConfig.height * .002,
          backgroundColor: AppColor.white,
          onTap: _onCancelPressed,
          child: CustomTextWidget(
            "إالغاء",
            color: AppColor.red,
            fontSize: SizeConfig.diagonal * .028,
          ),
        ),
      ],
    );
  }
}
