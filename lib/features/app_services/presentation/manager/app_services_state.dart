import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:equatable/equatable.dart';

enum AppServicesStatus { initial, loading, success, error }

class AppServicesState extends Equatable {
  final AppServicesStatus status;

  // ✅ حسابات السيلكت (forSelect)
  final List<AccountSelectItemEntity> accountsForSelect;

  // ✅ اختيار المستخدم (من الدروب داون)
  final int? selectedFromAccountId;
  final String? selectedFromAccountName;

  // ✅ للـ loading
  final bool isSubmitting;
  final bool depositSuccess;

  final String? message;

  final String operationNameChanged;

  // ✅ فلاج نجاح مرة واحدة (ليسكر البوتم شيت بالـ Listener)
  final bool withdrawSuccess;
  final String amountChanged;
  final String toAccountNumberChanged; // ✅ NEW
  final bool transferSuccess;
  const AppServicesState({
    this.status = AppServicesStatus.initial,
    this.accountsForSelect = const [],
    this.selectedFromAccountId,
    this.selectedFromAccountName,
    this.isSubmitting = false,

    this.message,
    this.operationNameChanged = '',
    this.amountChanged = '',

    this.withdrawSuccess = false,
    this.depositSuccess = false,
    this.toAccountNumberChanged = '',
    this.transferSuccess = false,
  });

  bool get hasAccounts => accountsForSelect.isNotEmpty;

  AppServicesState copyWith({
    AppServicesStatus? status,
    List<AccountSelectItemEntity>? accountsForSelect,
    int? selectedFromAccountId,
    String? selectedFromAccountName,
    bool? isSubmitting,
    String? message,
    bool clearMessage = false,
    String? operationNameChanged,
    String? amountChanged,
    bool? withdrawSuccess,
    bool? depositSuccess,
     String? toAccountNumberChanged,
    bool? transferSuccess,
  }) {
    return AppServicesState(
      status: status ?? this.status,
      accountsForSelect: accountsForSelect ?? this.accountsForSelect,
      selectedFromAccountId:
          selectedFromAccountId ?? this.selectedFromAccountId,
      selectedFromAccountName:
          selectedFromAccountName ?? this.selectedFromAccountName,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      message: clearMessage ? null : (message ?? this.message),
      operationNameChanged: operationNameChanged ?? this.operationNameChanged,
      amountChanged: amountChanged ?? this.amountChanged,
      withdrawSuccess: withdrawSuccess ?? this.withdrawSuccess,
      depositSuccess: depositSuccess ?? this.depositSuccess,
      toAccountNumberChanged: toAccountNumberChanged ?? this.toAccountNumberChanged,
      transferSuccess: transferSuccess ?? this.transferSuccess,
    );
  }

  @override
  List<Object?> get props => [
    status,
    accountsForSelect,
    selectedFromAccountId,
    selectedFromAccountName,
    isSubmitting,
    message,
    amountChanged,
    operationNameChanged,
    withdrawSuccess,
    depositSuccess,
    toAccountNumberChanged,
    transferSuccess,
  ];
}
