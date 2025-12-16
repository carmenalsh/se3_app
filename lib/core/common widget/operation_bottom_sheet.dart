import 'package:complaints_app/core/common%20widget/account_picker_field.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:flutter/material.dart';

class OperationBottomSheet extends StatefulWidget {
  final OperationConfig config;

  final bool isSubmitting;
  final VoidCallback onSubmit;

  final String? initialAccountName;
  final String? initialStatus;
  final String? initialDescription;
  final ValueChanged<String?>? onDropdownChanged;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<String>? onDescriptionChanged;
  final List<String> dropdownItems;

  final ValueChanged<String>? onAmountChanged;
  final ValueChanged<String>? onOperationNameChanged;
  final ValueChanged<String>? onToAccountNumberChanged;

  final Map<String, int> nameToId;
  final ValueChanged<int?>? onFromAccountIdChanged;

  OperationBottomSheet({
    super.key,
    required this.config,
    this.dropdownItems = const [],
    this.onNameChanged,
    this.onDescriptionChanged,
    required this.isSubmitting,
    required this.onSubmit,
    this.initialAccountName,
    this.initialStatus,
    this.initialDescription,
    this.onDropdownChanged,
    this.nameToId = const {},
    this.onFromAccountIdChanged,
    this.onAmountChanged,
    this.onOperationNameChanged,
    this.onToAccountNumberChanged,
  });

  @override
  State<OperationBottomSheet> createState() => _OperationBottomSheetState();
}

class _OperationBottomSheetState extends State<OperationBottomSheet> {
  String? selectedStatus;
  String? selectedFromAccountName;
  int? selectedFromAccountId;

  late final TextEditingController nameController;
  late final TextEditingController descController;

  // AccountItem? selected;
  @override
  void initState() {
    super.initState();
    selectedStatus = widget.initialStatus;

    nameController = TextEditingController(
      text: widget.initialAccountName ?? '',
    );
    descController = TextEditingController(
      text: widget.initialDescription ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.dropdownItems;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 8,
        ),
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
                      widget.onOperationNameChanged?.call(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (widget.config.showFromAccount) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AccountsDropdownField(
                    label: "الحساب",
                    hint: "اختر الحساب الذي تريد السحب منه...",
                    hintFontSize: 16,
                    hintColor: AppColor.middleGrey,
                    selectedValue: selectedFromAccountName,
                    items: items, // items = widget.dropdownItems (أسماء فقط)
                    onChanged: (val) {
                      setState(() => selectedFromAccountName = val);

                      final id = (val == null) ? null : widget.nameToId[val];
                      selectedFromAccountId = id;
                      widget.onFromAccountIdChanged?.call(id);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],

              if (widget.config.showToAccount) ...[
               
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    // vertical: 4,
                  ),
                  child: AuthFieldLabel(
                    label: "الى الحساب",
                    hint: "اختر الحساب الذي تريد التحويل اليه",
                    suffixIcon: Icons.edit,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      widget.onToAccountNumberChanged?.call(value);
                    },
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
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.onAmountChanged?.call(value); 
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
                  child: AuthFieldLabel(
                    controller: nameController,
                    label: 'اسم الحساب',
                    hint: "ادخل اسم الحساب الجديد للتعديل...",
                    suffixIcon: Icons.edit,
                    keyboardType: TextInputType.text,
                    onChanged: (v) => widget.onNameChanged?.call(v),
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
                    label: 'حالة الحساب',
                    hint: "اختار حالة الحساب للتعديل...",
                    hintFontSize: 16,
                    hintColor: AppColor.middleGrey,
                    selectedValue: selectedStatus,
                    items: items,
                    onChanged: (val) {
                      setState(() => selectedStatus = val);
                      widget.onDropdownChanged?.call(val);
                    },
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
                    controller: descController,
                    label: 'وصف الحساب',
                    hint: "ادخل وصفا للحساب الخاص بك للتعديل...",
                    suffixIcon: Icons.layers_outlined,
                    keyboardType: TextInputType.text,

                    onChanged: (v) => widget.onDescriptionChanged?.call(v),
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

                // onTap: () {
                //   final cubit = context.read<AccountManagCubit>();

                //   // ✅ منع الإرسال مرتين
                //   // if (cubit.state.isSubmitting) return;

                //   final name = nameController.text.trim();
                //   final desc = descController.text.trim();
                //   final status = selectedStatus?.trim();

                //   // ✅ Validation بسيطة
                //   if (name.isEmpty) {
                //     // إذا بدك سناكبار سريع بدل state message:
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('اسم الحساب مطلوب')),
                //     );
                //     return;
                //   }

                //   if (status == null || status.isEmpty) {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('اختر حالة الحساب')),
                //     );
                //     return;
                //   }

                //   // ✅ خزّن القيم بالـ Cubit
                //   cubit.editNameChanged(name);
                //   cubit.editDescriptionChanged(desc);
                //   cubit.editStatusChanged(status);

                //   // ✅ Debug: شو عم ينبعت بالضبط
                //   debugPrint(
                //     "============ BottomSheet Submit UpdateAccount ============",
                //   );
                //   debugPrint("name: $name");
                //   debugPrint("status: $status");
                //   debugPrint("description: $desc");
                //   debugPrint(
                //     "=========================================================",
                //   );

                //   // ✅ نفّذ
                //   cubit.submitUpdateAccount();
                // },
                onTap: () {
                  if (widget.isSubmitting) return;
                  widget.onSubmit();
                },
                child: widget.isSubmitting
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : CustomTextWidget(
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
