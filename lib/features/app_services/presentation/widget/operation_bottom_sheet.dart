import 'package:complaints_app/core/common%20widget/account_picker_field.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/models/account_item.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:flutter/material.dart';

class OperationBottomSheet extends StatefulWidget {
  final OperationConfig config;

  OperationBottomSheet({super.key, required this.config});

  @override
  State<OperationBottomSheet> createState() => _OperationBottomSheetState();
}

class _OperationBottomSheetState extends State<OperationBottomSheet> {
  String? selectedAccount;

  final accounts = const [
    "حساب جاري - 1234",
    "حساب توفير - 5678",
    "حساب استثمار - 9999",
  ];
  // AccountItem? selected;

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
              Container(
                height: 6,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColor.lightgrey,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColor.lightGreen,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: CustomTextWidget(
                    widget.config.title,
                    fontSize: SizeConfig.diagonal * .028,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Divider(thickness: 2, color: AppColor.lightgrey),
              const SizedBox(height: 3),

              if (widget.config.operayionAddress) ...[
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

              if (widget.config.showFromAccount) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AccountsDropdownField(
                    label:  "الحساب",
                    hint: "اختر الحساب الذي تريد السحب منه...",
                    hintFontSize: 14,
                    selectedValue: selectedAccount,
                    items: accounts,
                    onChanged: (val) => setState(() => selectedAccount = val),
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (widget.config.showToAccount) ...[
                // الحساب المستقبِل (هنا يظهر فقط في الإيداع/التحويل)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AccountsDropdownField(
                    label: "الى الحساب",
                    hint:  "اختر الحساب الذي تريد التحويل اليه",
                    hintFontSize: 14,
                    selectedValue: selectedAccount,
                    items: accounts,
                    onChanged: (val) => setState(() => selectedAccount = val),
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (widget.config.showAmount) ...[
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

              if (widget.config.showAccountName) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AccountsDropdownField(
                    label: 'اسم الحساب',
                    hint: "ادخل اسم الحساب الخاص بك للتعديل...",
                    hintFontSize: 14,
                    selectedValue: selectedAccount,
                    items: accounts,
                    onChanged: (val) => setState(() => selectedAccount = val),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              if (widget.config.showAccountState) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AccountsDropdownField(
                    label:  'حالة الحساب',
                    hint: "اختار حالة الحساب للتعديل...",
                    hintFontSize: 14,
                    selectedValue: selectedAccount,
                    items: accounts,
                    onChanged: (val) => setState(() => selectedAccount = val),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              if (widget.config.showAccountName) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: 'وصف الحساب',
                    hint: "ادخل وصفا للحساب الخاص بك للتعديل...",
                    suffixIcon: Icons.layers_outlined,
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
