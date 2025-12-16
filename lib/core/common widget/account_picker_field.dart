import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class AccountsDropdownField extends StatelessWidget {
  final String hint;
  final String label;
  final double hintFontSize;
  final Color hintColor;

  final String? selectedValue;

  final List<String> items;

  final ValueChanged<String?> onChanged;

  const AccountsDropdownField({
    super.key,
    required this.hint,
    required this.label,
    required this.hintFontSize,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // إذا عندك label خارجي بالتصميم
        CustomTextWidget(
          label,
          fontSize: SizeConfig.diagonal * .032,
          color: AppColor.textColor,
        ),
        const SizedBox(height: 6),

        DropdownButtonFormField<String>(
          // value: safeValue,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xffACACAC)),

          // خلي الستايل تبعك كما هو (استبدل هاد بالستايل الموجود عندك)
          style: TextStyle(
            fontFamily: AppFonts.tasees,
            fontSize: hintFontSize,
            color: AppColor.middleGrey,
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.grey,
            hintText: hint,

            hintStyle: TextStyle(
              color: AppColor.middleGrey,
              fontFamily: AppFonts.tasees,
              fontSize: hintFontSize,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 229, 229, 229),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.primary),
            ),
          ),

          items: items
              .map(
                (acc) => DropdownMenuItem<String>(
                  value: acc,
                  child: Text(
                    acc,
                    style: TextStyle(color: AppColor.middleGrey),
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),

          onChanged: onChanged,
        ),
      ],
    );
  }
}
