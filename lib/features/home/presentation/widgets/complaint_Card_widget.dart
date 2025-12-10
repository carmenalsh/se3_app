import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/home/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({
    super.key,
    required this.title,
    required this.statusText,
    required this.statusColor,
    required this.number,
    required this.description,
  });

  final String title;
  final String statusText;
  final Color statusColor;
  final String number;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColor.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  title,
                  fontSize: SizeConfig.diagonal * .022,
                  color: AppColor.black,
                ),
                CustomBackgroundWithChild(
                  borderRadius: BorderRadius.circular(6),
                  backgroundColor: statusColor,
                  childHorizontalPad: 6,
                  childVerticalPad: 2,
                  child: CustomTextWidget(
                    statusText,
                    fontSize: SizeConfig.diagonal * .02,
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
            const Divider(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: LabelColumnTitleValue(
                    label: 'رقم الشكوى',
                    value: number,
                  ),
                ),
                SizedBox(width: SizeConfig.width * .04),
                Expanded(
                  flex: 2,
                  child: LabelColumnTitleValue(
                    label: 'وصف الشكوى',
                    value: description,
                    maxLines: 3,
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
