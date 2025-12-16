import 'dart:ui';

import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class CardDetaisWidget extends StatelessWidget {
  const CardDetaisWidget({
    super.key,
    required this.title,
    required this.status,

    this.titleLocation,
    this.toAccount,
    this.location,
    this.editIcon,
    this.accountDescreption,
    this.accountState,
    this.accountStateColor,

    required this.fontSize,
    required this.amount,
    required this.date,
    required this.numberAccount,
    required this.statusColor,
    required this.onTapEditAccount,
  });
  final String title;
  final String status;
  final String amount;
  final String date;
  final String numberAccount;
  final String? titleLocation;
  final String? toAccount;
  final String? accountDescreption;
  final String? accountState;
  final Color statusColor;
  final Color? accountStateColor;
  final IconData? editIcon;
  final double fontSize;
  final String? location;
  final void Function() onTapEditAccount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.borderContainer, width: 1),
          boxShadow: [
            BoxShadow(
              color: const Color(0x17000000),
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(
                      title,
                      fontSize: fontSize,
                      color: AppColor.textInCard,
                    ),
                    Row(
                      children: [
                        if (editIcon != null) ...[
                          InkWell(
                            onTap: onTapEditAccount,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                editIcon,
                                color: AppColor.greyTextInCard,
                              ),
                            ),
                          ),
                        ],
                        CustomBackgroundWithChild(
                          borderRadius: BorderRadius.circular(6),
                          backgroundColor: statusColor,
                          childHorizontalPad: 16,
                          childVerticalPad: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: CustomTextWidget(
                              status,
                              fontSize: SizeConfig.diagonal * .02,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(endIndent: 10, indent: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            'رقم الحساب',
                            fontSize: SizeConfig.diagonal * .016,
                            color: AppColor.greyTextInCard,
                          ),
                          const SizedBox(height: 6),
                          CustomTextWidget(
                            numberAccount,
                            fontSize: SizeConfig.diagonal * .016,
                            color: AppColor.textInCard,
                            maxLines: 7,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomTextWidget(
                                "المبلغ",
                                fontSize: SizeConfig.diagonal * .016,
                                color: AppColor.greyTextInCard,
                              ),
                              SizedBox(width: 12),
                              CustomTextWidget(
                                amount,
                                fontSize: SizeConfig.diagonal * .016,
                                color: AppColor.textInCard,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              CustomTextWidget(
                                "التاريخ",
                                fontSize: SizeConfig.diagonal * .016,
                                color: AppColor.greyTextInCard,
                              ),
                              SizedBox(width: 12),
                              CustomTextWidget(
                                date,
                                fontSize: SizeConfig.diagonal * .016,
                                color: AppColor.textInCard,

                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if (toAccount != null) ...[
                                const SizedBox(height: 3),
                                CustomTextWidget(
                                  "الى الحساب",
                                  fontSize: SizeConfig.diagonal * .016,
                                  color: AppColor.greyTextInCard,
                                ),
                                SizedBox(width: 12),
                                if (toAccount != null) ...[
                                  const SizedBox(height: 3),
                                  CustomTextWidget(
                                    toAccount!,
                                    fontSize: SizeConfig.diagonal * .016,
                                    color: AppColor.textInCard,

                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              if (accountState != null) ...[
                                const SizedBox(height: 3),
                                CustomTextWidget(
                                  "حالة الحساب",
                                  fontSize: SizeConfig.diagonal * .016,
                                  color: AppColor.greyTextInCard,
                                ),
                                SizedBox(width: 12),
                                if (accountState != null) ...[
                                  const SizedBox(height: 3),
                                  CustomTextWidget(
                                    accountState!,
                                    fontSize: SizeConfig.diagonal * .016,
                                    color: accountStateColor,

                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ],
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (accountDescreption != null) ...[
                                const SizedBox(height: 3),
                                CustomTextWidget(
                                  "وصف الحساب",
                                  fontSize: SizeConfig.diagonal * .016,
                                  color: AppColor.greyTextInCard,
                                ),
                              ],
                              SizedBox(width: 12),
                              if (accountDescreption != null) ...[
                                const SizedBox(height: 3),
                                Expanded(
                                  child: CustomTextWidget(
                                    accountDescreption!,
                                    fontSize: SizeConfig.diagonal * .015,
                                    color: AppColor.textInCard,

                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Expanded(
                    //   flex: 10,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       CustomTextWidget(
                    //         amount,
                    //         fontSize: SizeConfig.diagonal * .016,
                    //         color: AppColor.textInCard,

                    //         overflow: TextOverflow.visible,
                    //         textAlign: TextAlign.start,
                    //       ),
                    //       const SizedBox(height: 3),
                    //       CustomTextWidget(
                    //         date,
                    //         fontSize: SizeConfig.diagonal * .016,
                    //         color: AppColor.textInCard,

                    //         overflow: TextOverflow.visible,
                    //         textAlign: TextAlign.start,
                    //       ),
                    // if (toAccount != null) ...[
                    //   const SizedBox(height: 3),
                    //   CustomTextWidget(
                    //     toAccount!,
                    //     fontSize: SizeConfig.diagonal * .016,
                    //     color: AppColor.textInCard,

                    //     overflow: TextOverflow.visible,
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ],
                    // if (accountState != null) ...[
                    //   const SizedBox(height: 3),
                    //   CustomTextWidget(
                    //     accountState!,
                    //     fontSize: SizeConfig.diagonal * .016,
                    //     color: AppColor.textInCard,

                    //     overflow: TextOverflow.visible,
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ],
                    //   if (accountDescreption != null) ...[
                    //     const SizedBox(height: 3),
                    //     CustomTextWidget(
                    //       accountDescreption!,
                    //       fontSize: SizeConfig.diagonal * .016,
                    //       color: AppColor.textInCard,

                    //       overflow: TextOverflow.visible,
                    //       textAlign: TextAlign.start,
                    //     ),
                    //   ],
                    // ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
