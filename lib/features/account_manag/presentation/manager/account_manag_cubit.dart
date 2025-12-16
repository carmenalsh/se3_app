import 'package:complaints_app/features/account_manag/domain/entities/account_entity.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/get_accounts_use_case.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/update_account_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import 'account_manag_state.dart';

class AccountManagCubit extends Cubit<AccountManagState> {
  final GetAccountsUseCase getAccountsUseCase;
  final UpdateAccountUseCase updateAccountUseCase;

  AccountManagCubit({
    required this.getAccountsUseCase,
    required this.updateAccountUseCase,
  }) : super(const AccountManagState());

  Future<void> getAccounts() async {
    debugPrint("============ AccountManagCubit.getAccounts ============");

    emit(
      state.copyWith(status: AccountManagStatus.loading, clearMessage: true),
    );

    final result = await getAccountsUseCase.call();

    result.fold(
      (failure) {
        debugPrint("✗ getAccounts failed: ${failure.errMessage}");
        debugPrint("=================================================");
        emit(
          state.copyWith(
            status: AccountManagStatus.error,
            message: failure.errMessage,
          ),
        );
      },
      (accounts) {
        debugPrint("✓ getAccounts success, count=${accounts.length}");
        debugPrint("=================================================");
        emit(
          state.copyWith(
            status: AccountManagStatus.success,
            accounts: accounts,
            clearMessage: true,
          ),
        );
      },
    );
  }

  Future<void> refreshAccounts() async {
    // نفس getAccounts بس منسميها refresh لتكون واضحة بالواجهة
    await getAccounts();
  }

  void clearError() {
    emit(state.copyWith(clearMessage: true));
  }

  void startEdit(AccountEntity acc) {
    emit(
      state.copyWith(
        editingAccountId: acc.id,
        editName: acc.name,
        editStatus: acc.status,
        editDescription: acc.description,
        clearMessage: true,
      ),
    );
  }

  void editNameChanged(String v) => emit(state.copyWith(editName: v));
  void editStatusChanged(String v) => emit(state.copyWith(editStatus: v));
  void editDescriptionChanged(String v) =>
      emit(state.copyWith(editDescription: v));

  Future<void> submitUpdateAccount() async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, updateSuccess: false, clearMessage: true));
    if (state.editingAccountId == null) {
      emit(state.copyWith(message: "لم يتم تحديد الحساب للتعديل"));
      return;
    }
    if (state.editStatus.isEmpty) {
      emit(state.copyWith(message: "اختر حالة الحساب"));
      return;
    }

    emit(state.copyWith(isSubmitting: true, updateSuccess: false,clearMessage: true));

    final params = UpdateAccountParams(
      accountId: state.editingAccountId!,
      name: state.editName,
      status: state.editStatus,
      description: state.editDescription,
    );

    final result = await updateAccountUseCase.call(params);

    result.fold(
      (failure) {
        emit(state.copyWith(isSubmitting: false,updateSuccess: false, message: failure.errMessage));
      },
      (success) {
        // ✅ تحديث الليستة محلياً
        final updated = state.accounts.map((a) {
          if (a.id == state.editingAccountId) {
            return AccountEntity(
              id: a.id,
              name: state.editName,
              accountNumber: a.accountNumber,
              description: state.editDescription,
              type: a.type,
              status: state.editStatus,
              balance: a.balance,
              createdAt: a.createdAt,
            );
          }
          return a;
        }).toList();

        emit(
          state.copyWith(
            accounts: updated,
            isSubmitting: false,
            updateSuccess: true,
            message: success.successMessage,
          ),
        );
      },
    );
  }
  void resetUpdateFlag() {
  emit(state.copyWith(updateSuccess: false, clearMessage: true));
}

}
