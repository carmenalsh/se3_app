import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

class SubmitComplaintTypeField extends StatelessWidget {
  final String? selectedType;
  final String? hint;
  final List<String> items;
  final double hintFontSize;
  final Function(String?) onChanged;

  const SubmitComplaintTypeField({
    super.key,
    required this.selectedType,
    required this.items,
    required this.onChanged,
    this.hint,
    this.hintFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedType,
      icon: Icon(Icons.keyboard_arrow_down, color: Color(0xffACACAC)),
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
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 229, 229, 229),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.primary),
        ),
      ),

      items: items
          .map(
            (type) => DropdownMenuItem(
              value: type,

              // ************* 3) ستايل عناصر القائمة *************
              child: Text(
                type,
                style: TextStyle(
                  fontFamily: AppFonts.tasees,
                  fontSize: hintFontSize,
                  color: AppColor.middleGrey,
                ),
              ),
            ),
          )
          .toList(),

      onChanged: onChanged,
    );
  }
}
