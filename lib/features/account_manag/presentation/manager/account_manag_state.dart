import '../../domain/entities/account_entity.dart';

enum AccountManagStatus { initial, loading, success, error }

class AccountManagState {
  final AccountManagStatus status;
  final List<AccountEntity> accounts;
  final String? message;
// ✅ Editing
  final int? editingAccountId;
  final String editName;
  final String editStatus;
  final String editDescription;
  final bool updateSuccess;

  final bool isSubmitting;
  const AccountManagState({
    this.status = AccountManagStatus.initial,
    this.accounts = const [],
    this.message,
     this.editingAccountId,
    this.editName = '',
    this.editStatus = '',
    this.editDescription = '',
    this.isSubmitting = false,
    this.updateSuccess = false,

  });

  AccountManagState copyWith({
    AccountManagStatus? status,
    List<AccountEntity>? accounts,
    String? message,
    bool clearMessage = false,
     int? editingAccountId,
    String? editName,
    String? editStatus,
    String? editDescription,

    bool? isSubmitting,
    bool? updateSuccess,
  }) {
    return AccountManagState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
      message: clearMessage ? null : (message ?? this.message),
      editingAccountId: editingAccountId ?? this.editingAccountId,
      editName: editName ?? this.editName,
      editStatus: editStatus ?? this.editStatus,
      editDescription: editDescription ?? this.editDescription,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      updateSuccess: updateSuccess ?? this.updateSuccess,
    
    );
  }
}
