import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDescriptionTextFiels extends StatefulWidget {
  const CustomDescriptionTextFiels({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.borderRadius = 10,
    this.hintFontSize = 16,
    this.onChanged,
    this.validator,
    this.onSuffixTap,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final double borderRadius;
  final double hintFontSize;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;

  @override
  State<CustomDescriptionTextFiels> createState() =>
      _CustomDescriptionTextFielsState();
}

class _CustomDescriptionTextFielsState
    extends State<CustomDescriptionTextFiels> {
  @override
  Widget build(BuildContext context) {
    final currentLength = widget.controller?.text.length ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null || widget.maxLength != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.label != null)
                CustomTextWidget(
                  widget.label!,
                  fontSize: SizeConfig.diagonal * .032,
                  color: AppColor.textColor,
                ),
              if (widget.maxLength != null)
                Text(
                  "${widget.maxLength}/$currentLength",
                  style: TextStyle(
                    fontFamily: AppFonts.tasees,
                    fontSize: 16,
                    color: AppColor.middleGrey,
                  ),
                ),
            ],
          ),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: (value) {
            setState(() {});
            widget.onChanged?.call(value);
          },
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hint,
            counterText: "",
            hintStyle: TextStyle(
              color: AppColor.middleGrey,
              fontFamily: AppFonts.tasees,
              fontSize: widget.hintFontSize,
            ),
            suffixIcon: widget.suffixIcon == null
                ? null
                : IconButton(
                    onPressed: widget.onSuffixTap,
                    icon: Icon(
                      widget.suffixIcon,
                      size: 20,
                      color: AppColor.middleGrey,
                    ),
                  ),
            prefix: widget.prefixIcon == null
                ? null
                : IconButton(
                    onPressed: widget.onSuffixTap,
                    icon: Icon(widget.prefixIcon, size: 20),
                  ),
            filled: true,
            fillColor: AppColor.grey,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 229, 229, 229),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.primary),
            ),
          ),
        ),
      ],
    );
  }
}
