import 'package:complaints_app/core/common%20widget/custom_text_feild.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';

class AuthFieldLabel extends StatelessWidget {
  const AuthFieldLabel({
    super.key,
    required this.label,
    this.controller,
    required this.hint,
    this.suffixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onSuffixTap,
    this.maxLines,
    this.maxLength,
    this.prefixIcon,
  });

  final String label;
  final TextEditingController? controller;
  final String hint;
  final int? maxLines;
  final int? maxLength;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  final VoidCallback? onSuffixTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          label,
          fontSize: SizeConfig.diagonal * .032,
          color: AppColor.textColor,
        ),
        SizedBox(height: SizeConfig.height * .01),
        CustomTextField(
          controller: controller,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          hint: hint,
          suffixIcon: suffixIcon,
          onSuffixTap: onSuffixTap,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines ?? 1,
          maxLength:maxLength,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
