import 'package:complaints_app/features/create_account/domain/use_case/create_account_use_case.dart';
import 'package:complaints_app/features/create_account/domain/use_case/params/create_account_params.dart';
import 'package:complaints_app/features/create_account/presentation/manager/create_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final CreateAccountUseCase createAccountUseCase;

  final descriptionController = TextEditingController();
  final accountNameController = TextEditingController();
  final amountController = TextEditingController();

  CreateAccountCubit({required this.createAccountUseCase})
    : super(const CreateAccountState());
  @override
  Future<void> close() {
    descriptionController.dispose();
    accountNameController.dispose();
    amountController.dispose();
    return super.close();
  }

  void descriptionChanged(String value) {
    emit(
      state.copyWith(
        description: value,
        // submitErrorMessage: null,
        // isSubmitSuccess: false,
      ),
    );
  }

  void accountChanged(String? value) {
    // value رح تكون null فقط إذا عملتي clear من UI
    emit(state.copyWith(selectedTypeAccount: value));
  }

  void accountNameChanged(String v) => emit(state.copyWith(accountName: v));

  void amountChanged(String v) => emit(state.copyWith(amount: v));

  Future<void> submitCreateAccount() async {
    if (state.isSubmitting) return;

    // Validation قبل ما ترفع isSubmitting
    if (state.accountName.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CreateAccountStatus.error,
          message: "اسم الحساب مطلوب",
        ),
      );
      return;
    }

    if (state.selectedTypeAccount == null) {
      emit(
        state.copyWith(
          status: CreateAccountStatus.error,
          message: "اختر نوع الحساب",
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: CreateAccountStatus.loading,
        isSubmitting: true,
        clearMessage: true,
      ),
    );

    final params = CreateAccountParams(
      name: state.accountName.trim(),
      accountType: state.selectedTypeAccount!,
      initialAmount: state.amount.trim(),
      description: state.description.trim(),
    );

    final result = await createAccountUseCase.call(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: CreateAccountStatus.error,
            isSubmitting: false,
            message: failure.errMessage,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            status: CreateAccountStatus.success,
            isSubmitting: false,
            message: success.successMessage,
          ),
        );
      },
    );
  }
}
