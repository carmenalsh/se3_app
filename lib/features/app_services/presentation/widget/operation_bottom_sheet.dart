import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:flutter/material.dart';

class OperationBottomSheet extends StatelessWidget {
  final OperationConfig config;

  const OperationBottomSheet({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(config.title, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),

              if (config.operayionAddress) ...[
                // عنوان العملية
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    //  vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "عنوان العملية",
                    hint: "ادخل عنونا للعملية المالية...",
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // context.read<SubmitComplaintCubit>().titleChanged(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (config.showFromAccount) ...[
                // الحساب المرسل
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "الحساب",
                    hint: "اختر الحساب الذي تريد السحب منه",
                    suffixIcon: Icons.edit_document,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // context.read<SubmitComplaintCubit>().titleChanged(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (config.showToAccount) ...[
                // الحساب المستقبِل (هنا يظهر فقط في الإيداع/التحويل)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "الى الحساب",
                    hint: "اختر الحساب الذي تريد التحويل اليه",
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // context.read<SubmitComplaintCubit>().titleChanged(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (config.showAmount) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "المبلغ",
                    hint: "ادخل مبلغا تريد ايداعه في الحساب...",
                    suffixIcon: Icons.credit_card_outlined,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      // context.read<SubmitComplaintCubit>().titleChanged(value);
                    },
                  ),
                ),
                const SizedBox(height: 35),
              ],

              CustomButtonWidget(
                width: double.infinity,
                backgroundColor: AppColor.primary,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .012,
                borderRadius: 10,
                onTap: () {
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   debugPrint("im at confirm log innnnnn");
                  //   context.read<LoginCubit>().loginSubmitted();
                  // }
                },
                child: CustomTextWidget(
                  "تأكيد الارسال",
                  fontSize: SizeConfig.height * .025,
                  color: AppColor.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  const _TextField({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
