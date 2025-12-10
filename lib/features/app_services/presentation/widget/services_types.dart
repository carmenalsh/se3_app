import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComplaintInformationWidget extends StatelessWidget {
  const ComplaintInformationWidget({
    super.key,
    required this.titleColor,
    required this.image,
    required this.title,
  });

  final Color titleColor;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(image, width: SizeConfig.width * 0.12),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.tasees,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
