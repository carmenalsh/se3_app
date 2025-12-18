import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/notification_entity.dart';
import 'package:equatable/equatable.dart';

enum AppServicesStatus { initial, loading, success, error }

class AppServicesState extends Equatable {
  final AppServicesStatus status;

  final bool didChange;


  // ✅ حسابات السيلكت (forSelect)
  final List<AccountSelectItemEntity> accountsForSelect;

  // ✅ اختيار المستخدم (من الدروب داون)
  final int? selectedFromAccountId;
  final String? selectedFromAccountName;
  final String? selectedOperationType;
  final String? sectectDate;

  // ✅ للـ loading
  final bool isSubmitting;

  final bool depositSuccess;
  final bool withdrawSuccess;
  final bool transferSuccess;
  final bool scheduledSuccess;

  final String? message;

  final String operationNameChanged;
  final String amountChanged;
  final String toAccountNumberChanged;

  final List<NotificationEntity> notifications;
  final bool isNotificationsLoading;
  final String? notificationsErrorMessage;

  const AppServicesState({
    this.status = AppServicesStatus.initial,
    this.didChange = false,

    this.accountsForSelect = const [],
    this.selectedFromAccountId,
    this.selectedFromAccountName,
    this.selectedOperationType,
    this.sectectDate,
    this.isSubmitting = false,

    this.message,
    this.operationNameChanged = '',
    this.amountChanged = '',

    this.withdrawSuccess = false,
    this.depositSuccess = false,
    this.scheduledSuccess = false,
    this.toAccountNumberChanged = '',
    this.transferSuccess = false,
    this.notifications = const [],
    this.isNotificationsLoading = false,
    this.notificationsErrorMessage,
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
    String? sectectDate,
    String? selectedOperationType,
    bool? scheduledSuccess,
    List<NotificationEntity>? notifications,
    bool? isNotificationsLoading,
    String? notificationsErrorMessage,
    bool? didChange,

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
      toAccountNumberChanged:
          toAccountNumberChanged ?? this.toAccountNumberChanged,
      transferSuccess: transferSuccess ?? this.transferSuccess,
      sectectDate: sectectDate ?? this.sectectDate,
      selectedOperationType:
          selectedOperationType ?? this.selectedOperationType,
      scheduledSuccess: scheduledSuccess ?? this.scheduledSuccess,
      notifications: notifications ?? this.notifications,
      isNotificationsLoading:
          isNotificationsLoading ?? this.isNotificationsLoading,
      notificationsErrorMessage:
          notificationsErrorMessage ?? this.notificationsErrorMessage,
          didChange: didChange ?? this.didChange,

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
    selectedOperationType,
    sectectDate,
    scheduledSuccess,
    notificationsErrorMessage,
    isNotificationsLoading,
    notifications,
    didChange
  ];
}
