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

    required this.fontSize,
    required this.amount,
    required this.date,
    required this.numberAccount,
    required this.statusColor,
  });
  final String title;
  final String status;
  final String amount;
  final String date;
  final String numberAccount;
  final String? titleLocation;
  final String? toAccount;
  final Color statusColor;

  final double fontSize;
  final String? location;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ),
            const Divider(endIndent: 10, indent: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
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
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          "المبلغ",
                          fontSize: SizeConfig.diagonal * .016,
                          color: AppColor.greyTextInCard,
                        ),
                        const SizedBox(height: 3),
                        CustomTextWidget(
                          "التاريخ",
                          fontSize: SizeConfig.diagonal * .016,
                          color: AppColor.greyTextInCard,
                        ),
                        if (toAccount != null) ...[
                          const SizedBox(height: 3),
                          CustomTextWidget(
                            "الى الحساب",
                            fontSize: SizeConfig.diagonal * .016,
                            color: AppColor.greyTextInCard,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          amount,
                          fontSize: SizeConfig.diagonal * .016,
                          color: AppColor.textInCard,

                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 3),
                        CustomTextWidget(
                          date,
                          fontSize: SizeConfig.diagonal * .016,
                          color: AppColor.textInCard,

                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                        ),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
