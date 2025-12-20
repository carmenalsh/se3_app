import 'package:complaints_app/core/adapters/feed/notification_feed_adapter.dart';
import 'package:complaints_app/core/common%20widget/account_picker_field.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/app_services/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final ValueChanged<String>? onFileTypeChanged;
  final ValueChanged<String>? onPeriodChanged;
  final ValueChanged<String>? onScheduledTypeChanged; // "إيداع" | "سحب"
  final ValueChanged<String>? onScheduledAtChanged;

  final Map<String, int> nameToId;
  final ValueChanged<int?>? onFromAccountIdChanged;

  final List<NotificationEntity> notifications;
  final bool isNotificationsLoading;
  final String? notificationsErrorMessage;
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
    this.onFileTypeChanged,
    this.onPeriodChanged,
    this.onScheduledAtChanged,
    this.onScheduledTypeChanged,
    this.notifications = const [],
    this.isNotificationsLoading = false,
    this.notificationsErrorMessage,
  });

  @override
  State<OperationBottomSheet> createState() => _OperationBottomSheetState();
}

class _OperationBottomSheetState extends State<OperationBottomSheet> {
  String? selectedStatus;
  String? selectedFromAccountName;
  int? selectedFromAccountId;
  String? selectedFileType; // 'pdf' | 'csv'
  String? selectedPeriod;
  String? selectedScheduledType; // "إيداع" | "سحب"
  DateTime? selectedScheduledDateTime;
  String? scheduledAtFormatted;
  late final TextEditingController nameController;
  late final TextEditingController descController;
  String _formatDateTime(DateTime dt) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
  }

  // final List<Map<String, String>> _fakeNotifications = const [
  //   {"title": "test1 title", "body": "test1 body", "date": "منذ 55 ثانية"},
  //   {"title": "test title", "body": "test body", "date": "منذ دقيقة"},
  // ];

  // AccountItem? selected;
  @override
  void initState() {
    super.initState();
    selectedStatus = widget.initialStatus;
    selectedFileType = 'pdf';
    selectedPeriod = 'month';
    selectedScheduledType = "ايداع";
    selectedScheduledDateTime = DateTime.now().add(const Duration(minutes: 5));

    scheduledAtFormatted = _formatDateTime(selectedScheduledDateTime!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onFileTypeChanged?.call(selectedFileType!);
      widget.onPeriodChanged?.call(selectedPeriod!);
      widget.onScheduledTypeChanged?.call(selectedScheduledType!);
      widget.onScheduledAtChanged?.call(scheduledAtFormatted!);
    });

    nameController = TextEditingController(
      text: widget.initialAccountName ?? '',
    );
    descController = TextEditingController(
      text: widget.initialDescription ?? '',
    );
    if (widget.config.selectTypeTransActioToScheduled) {
      selectedScheduledType ??= 'إيداع';
      widget.onScheduledTypeChanged?.call(selectedScheduledType!);
    }

    if (widget.config.showCelender) {
      final dt = DateTime.now().add(const Duration(minutes: 5));
      selectedScheduledDateTime ??= dt;
      scheduledAtFormatted ??= _formatDateTime(dt);
      widget.onScheduledAtChanged?.call(scheduledAtFormatted!);
    }
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
    return Padding(
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
                  hint: "اختر الحساب الذي تريده...",
                  hintFontSize: 16,
                  hintColor: AppColor.middleGrey,
                  selectedValue: selectedFromAccountName,
                  items: items,
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    widget.onToAccountNumberChanged?.call(value);
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
            if (widget.config.showSelectFileType) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      "صيغة الملف",
                      fontSize: SizeConfig.diagonal * .032,
                      color: AppColor.textColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'pdf',
                            groupValue: selectedFileType,
                            onChanged: (v) {
                              setState(() => selectedFileType = v);
                              if (v != null) widget.onFileTypeChanged?.call(v);
                            },
                            title: const CustomTextWidget(
                              'PDF',
                              color: AppColor.middleGrey,
                              textAlign: TextAlign.right,
                            ),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'csv',
                            groupValue: selectedFileType,
                            onChanged: (v) {
                              setState(() => selectedFileType = v);
                              if (v != null) widget.onFileTypeChanged?.call(v);
                            },
                            title: const CustomTextWidget(
                              'CSV',
                              color: AppColor.middleGrey,
                              textAlign: TextAlign.right,
                            ),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (widget.config.showChoosePeriod) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      "المدة",
                      fontSize: SizeConfig.diagonal * .032,
                      color: AppColor.textColor,
                    ),
                    RadioListTile<String>(
                      value: 'week',
                      groupValue: selectedPeriod,
                      onChanged: (v) {
                        setState(() => selectedPeriod = v);
                        if (v != null) widget.onPeriodChanged?.call(v);
                      },
                      title: CustomTextWidget(
                        'أسبوع',
                        color: AppColor.middleGrey,
                        textAlign: TextAlign.right,
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      value: 'month',
                      groupValue: selectedPeriod,
                      onChanged: (v) {
                        setState(() => selectedPeriod = v);
                        if (v != null) widget.onPeriodChanged?.call(v);
                      },

                      title: CustomTextWidget(
                        'شهر',
                        color: AppColor.middleGrey,
                        textAlign: TextAlign.right,
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      value: 'year',
                      groupValue: selectedPeriod,
                      onChanged: (v) {
                        setState(() => selectedPeriod = v);
                        if (v != null) widget.onPeriodChanged?.call(v);
                      },
                      title: CustomTextWidget(
                        'سنة',
                        color: AppColor.middleGrey,
                        textAlign: TextAlign.right,
                      ),
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (widget.config.selectTypeTransActioToScheduled) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      "نوع المعاملة",
                      fontSize: SizeConfig.diagonal * .032,
                      color: AppColor.textColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'ايداع',
                            groupValue: selectedScheduledType,
                            onChanged: (v) {
                              setState(() => selectedScheduledType = v);
                              if (v != null)
                                widget.onScheduledTypeChanged?.call(v);
                            },
                            title: const CustomTextWidget(
                              'ايداع',
                              color: AppColor.middleGrey,
                              textAlign: TextAlign.right,
                            ),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'سحب',
                            groupValue: selectedScheduledType,
                            onChanged: (v) {
                              setState(() => selectedScheduledType = v);
                              if (v != null)
                                widget.onScheduledTypeChanged?.call(v);
                            },
                            title: const CustomTextWidget(
                              'سحب',
                              color: AppColor.middleGrey,
                              textAlign: TextAlign.right,
                            ),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (widget.config.showCelender) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      "تاريخ ووقت التنفيذ",
                      fontSize: SizeConfig.diagonal * .032,
                      color: AppColor.textColor,
                    ),
                    const SizedBox(height: 10),

                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final now = DateTime.now();
                        final initial = selectedScheduledDateTime ?? now;

                        final date = await showDatePicker(
                          context: context,
                          initialDate: initial,
                          firstDate: now,
                          lastDate: DateTime(now.year + 10),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: Theme.of(context).colorScheme
                                    .copyWith(
                                      primary: AppColor.primary,
                                      onPrimary: Colors.white,
                                      surface: Colors.white,
                                      onSurface: AppColor.black,
                                    ),
                                datePickerTheme: const DatePickerThemeData(
                                  // هون تقدر تخصص أكثر (اختياري)
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date == null) return;

                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(initial),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                timePickerTheme: TimePickerThemeData(
                                  backgroundColor: Colors.white,
                                  // ✅ الوقت المعروض فوق (HH:MM)
                                  hourMinuteTextColor: AppColor.primary,
                                  hourMinuteColor: Colors.white,
                                  // ✅ أزرار OK / CANCEL
                                  confirmButtonStyle: TextButton.styleFrom(
                                    foregroundColor: AppColor.primary,
                                  ),
                                  cancelButtonStyle: TextButton.styleFrom(
                                    foregroundColor: AppColor.middleGrey,
                                  ),
                                ),
                                colorScheme: Theme.of(context).colorScheme
                                    .copyWith(
                                      primary: AppColor.primary,
                                      onSurface: AppColor.black,
                                    ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (time == null) return;

                        final dt = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                          0,
                        );

                        setState(() {
                          selectedScheduledDateTime = dt;
                          scheduledAtFormatted = _formatDateTime(dt);
                        });

                        widget.onScheduledAtChanged?.call(
                          scheduledAtFormatted!,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColor.lightgrey),
                          color: AppColor.textFieldColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextWidget(
                                scheduledAtFormatted ?? 'اختر التاريخ والوقت',
                                fontSize: 16,
                                color: AppColor.middleGrey,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColor.middleGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (widget.config.showNotifications) ...[
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextWidget(
                    "الإشعارات",
                    fontSize: SizeConfig.diagonal * .032,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              if (widget.isNotificationsLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (widget.notificationsErrorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomTextWidget(
                    widget.notificationsErrorMessage!,
                    color: Colors.red,
                    textAlign: TextAlign.right,
                  ),
                )
              else
                Builder(
                  builder: (context) {
                    // ✅ هون المكان الوحيد الصحيح لتعريف المتغير
                    final items = widget.notifications
                        .map(NotificationToFeedAdapter.adapt)
                        .toList();

                    if (items.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: CustomTextWidget(
                          "لا يوجد إشعارات حالياً",
                          color: AppColor.middleGrey,
                          textAlign: TextAlign.right,
                        ),
                      );
                    }

                    return SizedBox(
                      height: SizeConfig.height * .45,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) {
                          final item = items[i];

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColor.lightgrey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  item.title,
                                  color: AppColor.black,
                                  fontSize: SizeConfig.diagonal * .03,
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 6),
                                CustomTextWidget(
                                  item.subtitle,
                                  color: AppColor.middleGrey,
                                  fontSize: SizeConfig.diagonal * .027,
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomTextWidget(
                                    item.dateText,
                                    color: AppColor.middleGrey,
                                    fontSize: SizeConfig.diagonal * .024,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

              const SizedBox(height: 8),
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
            // ✅ لا تُظهر زر الإرسال في حالة الإشعارات
            if (!widget.config.showNotifications)
              CustomButtonWidget(
                width: double.infinity,
                backgroundColor: AppColor.primary,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .012,
                borderRadius: 10,
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
    );
  }
}
