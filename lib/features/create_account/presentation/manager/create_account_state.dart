import 'package:equatable/equatable.dart';

enum CreateAccountStatus { initial, loading, success, error }
class CreateAccountState extends Equatable {
  final CreateAccountStatus status;
  final String description;
  final String? selectedTypeAccount;
  final String accountName;
  final String amount;

  final bool isSubmitting;
  final String? message;

  const CreateAccountState({
    this.status = CreateAccountStatus.initial,
    this.description = '',
    this.accountName = '',
    this.amount = '',
    this.selectedTypeAccount,
    this.isSubmitting = false,
    this.message,
  });

  CreateAccountState copyWith({
    CreateAccountStatus? status,
    String? description,
    String? selectedTypeAccount,
    String? accountName,
    String? amount,
    bool? isSubmitting,
    String? message,
    bool clearMessage = false,
  }) {
    return CreateAccountState(
      status: status ?? this.status,
      description: description ?? this.description,
      selectedTypeAccount: selectedTypeAccount ?? this.selectedTypeAccount,
      accountName: accountName ?? this.accountName,
      amount: amount ?? this.amount,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
        status,
        description,
        selectedTypeAccount,
        accountName,
        amount,
        isSubmitting,
        message,
      ];
}
