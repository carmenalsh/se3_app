import 'package:complaints_app/features/app_services/domain/use_case/deposit_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/get_accounts_for_select_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/transfer_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/withdraw_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_services_state.dart';

class AppServicesCubit extends Cubit<AppServicesState> {
  final GetAccountsForSelectUseCase getAccountsForSelectUseCase;
  final WithdrawUseCase withdrawUseCase;
  final DepositUseCase depositUseCase;
  final TransferUseCase transferUseCase;
  AppServicesCubit({
    required this.getAccountsForSelectUseCase,
    required this.withdrawUseCase,
    required this.depositUseCase,
    required this.transferUseCase,
  }) : super(const AppServicesState());

  /// تحميل قائمة الحسابات (للاستخدام في السحب/الإيداع...)
  Future<void> loadAccountsForSelect() async {
    debugPrint(
      "============ AppServicesCubit.loadAccountsForSelect ============",
    );

    // إذا كانت القائمة موجودة مسبقاً لا نعيد الطلب
    if (state.accountsForSelect.isNotEmpty) {
      debugPrint("ƒo: accountsForSelect already loaded, skip fetch");
      debugPrint("=================================================");
      return;
    }

    emit(
      state.copyWith(
        status: AppServicesStatus.loading,
        isSubmitting: true,
        clearMessage: true,
      ),
    );

    final result = await getAccountsForSelectUseCase.call();

    result.fold(
      (failure) {
        debugPrint("ƒo- loadAccountsForSelect failed: ${failure.errMessage}");
        emit(
          state.copyWith(
            status: AppServicesStatus.error,
            isSubmitting: false,
            message: failure.errMessage,
          ),
        );
      },
      (accounts) {
        debugPrint(
          "ƒo: loadAccountsForSelect success: ${accounts.length} items",
        );
        emit(
          state.copyWith(
            status: AppServicesStatus.success,
            accountsForSelect: accounts,
            isSubmitting: false,
          ),
        );
      },
    );

    debugPrint("=================================================");
  }

  Future<void> submitWithdraw() async {
    debugPrint("============ AppServicesCubit.submitWithdraw ============");

    if (state.isSubmitting) return;

    final accountId = state.selectedFromAccountId;
    final name = state.operationNameChanged.trim();
    final amount = state.amountChanged.trim();

    // ✅ Validation بسيطة
    if (accountId == null) {
      emit(state.copyWith(message: "اختر الحساب", clearMessage: false));
      return;
    }
    if (name.isEmpty) {
      emit(state.copyWith(message: "اكتب عنوان العملية", clearMessage: false));
      return;
    }
    if (amount.isEmpty) {
      emit(state.copyWith(message: "ادخل المبلغ", clearMessage: false));
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        withdrawSuccess: false,
        clearMessage: true,
      ),
    );

    final params = WithdrawParams(
      accountId: accountId,
      name: name,
      amount: amount,
    );

    final result = await withdrawUseCase.call(params);

    result.fold(
      (failure) {
        debugPrint("✗ submitWithdraw failed: ${failure.errMessage}");
        emit(state.copyWith(isSubmitting: false, message: failure.errMessage));
      },
      (success) {
        debugPrint("✓ submitWithdraw success: ${success.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            message: success.successMessage,
            withdrawSuccess: true, // ✅ مرة واحدة
          ),
        );
      },
    );

    debugPrint("=================================================");
  }

  Future<void> submitDeposit() async {
    debugPrint("============ AppServicesCubit.submitDeposit ============");

    if (state.isSubmitting) return;

    final accountId = state.selectedFromAccountId;
    final name = state.operationNameChanged.trim();
    final amount = state.amountChanged.trim();

    if (accountId == null) {
      emit(state.copyWith(message: "اختر الحساب", clearMessage: false));
      return;
    }
    if (name.isEmpty) {
      emit(state.copyWith(message: "اكتب عنوان العملية", clearMessage: false));
      return;
    }
    if (amount.isEmpty) {
      emit(state.copyWith(message: "ادخل المبلغ", clearMessage: false));
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        depositSuccess: false, // ✅
        clearMessage: true,
      ),
    );

    final params = DepositParams(
      accountId: accountId,
      name: name,
      amount: amount,
    );

    final result = await depositUseCase.call(params);

    result.fold(
      (failure) {
        debugPrint("✗ submitDeposit failed: ${failure.errMessage}");
        emit(state.copyWith(isSubmitting: false, message: failure.errMessage));
      },
      (success) {
        debugPrint("✓ submitDeposit success: ${success.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            message: success.successMessage,
            depositSuccess: true, // ✅ مرة واحدة
          ),
        );
      },
    );

    debugPrint("=================================================");
  }

  Future<void> submitTransfer() async {
    debugPrint("============ AppServicesCubit.submitTransfer ============");

    if (state.isSubmitting) return;

    final fromAccountId = state.selectedFromAccountId;
    final name = state.operationNameChanged.trim();
    final amount = state.amountChanged.trim();
    final toAccountNumber = state.toAccountNumberChanged.trim();

    if (fromAccountId == null) {
      emit(state.copyWith(message: "اختر الحساب", clearMessage: false));
      return;
    }
    if (name.isEmpty) {
      emit(state.copyWith(message: "اكتب عنوان العملية", clearMessage: false));
      return;
    }
    if (amount.isEmpty) {
      emit(state.copyWith(message: "ادخل المبلغ", clearMessage: false));
      return;
    }
    if (toAccountNumber.isEmpty) {
      emit(
        state.copyWith(
          message: "ادخل رقم الحساب المستقبِل",
          clearMessage: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        transferSuccess: false,
        clearMessage: true,
      ),
    );

    final params = TransferParams(
      accountId: fromAccountId,
      name: name,
      amount: amount,
      toAccountNumber: toAccountNumber,
    );

    final result = await transferUseCase.call(params);

    result.fold(
      (failure) {
        debugPrint("✗ submitTransfer failed: ${failure.errMessage}");
        emit(state.copyWith(isSubmitting: false, message: failure.errMessage));
      },
      (success) {
        debugPrint("✓ submitTransfer success: ${success.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            message: success.successMessage,
            transferSuccess: true,
          ),
        );
      },
    );

    debugPrint("=================================================");
  }

  /// تحديث الحساب المختار من القائمة
  void fromAccountIdChanged(int? id) {
    emit(state.copyWith(selectedFromAccountId: id));
  }

  /// تحديث اسم الحساب المختار (في حال الحاجة)
  void fromAccountNameChanged(String? name) {
    emit(state.copyWith(selectedFromAccountName: name));
  }

  void operationNameChanged(String value) {
    emit(state.copyWith(operationNameChanged: value));
  }

  void amountChanged(String value) {
    emit(state.copyWith(amountChanged: value));
  }

  void resetWithdrawSuccess() {
    if (!state.withdrawSuccess) return;
    emit(state.copyWith(withdrawSuccess: false));
  }

  void resetDepositSuccess() {
    if (!state.depositSuccess) return;
    emit(state.copyWith(depositSuccess: false));
  }

  void toAccountNumberChanged(String value) {
    emit(state.copyWith(toAccountNumberChanged: value));
  }

  void resetTransferSuccess() {
    if (!state.transferSuccess) return;
    emit(state.copyWith(transferSuccess: false));
  }
}
