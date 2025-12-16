import 'package:complaints_app/features/app_services/domain/use_case/get_accounts_for_select_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_services_state.dart';

class AppServicesCubit extends Cubit<AppServicesState> {
  final GetAccountsForSelectUseCase getAccountsForSelectUseCase;

  AppServicesCubit({
    required this.getAccountsForSelectUseCase,
  }) : super(const AppServicesState());

  /// تحميل قائمة الحسابات (للاستخدام في السحب/الإيداع...)
  Future<void> loadAccountsForSelect() async {
    debugPrint("============ AppServicesCubit.loadAccountsForSelect ============");

    // إذا كانت القائمة موجودة مسبقاً لا نعيد الطلب
    if (state.accountsForSelect.isNotEmpty) {
      debugPrint("ƒo: accountsForSelect already loaded, skip fetch");
      debugPrint("=================================================");
      return;
    }

    emit(state.copyWith(
      status: AppServicesStatus.loading,
      isSubmitting: true,
      clearMessage: true,
    ));

    final result = await getAccountsForSelectUseCase.call();

    result.fold(
      (failure) {
        debugPrint("ƒo- loadAccountsForSelect failed: ${failure.errMessage}");
        emit(state.copyWith(
          status: AppServicesStatus.error,
          isSubmitting: false,
          message: failure.errMessage,
        ));
      },
      (accounts) {
        debugPrint(
          "ƒo: loadAccountsForSelect success: ${accounts.length} items",
        );
        emit(state.copyWith(
          status: AppServicesStatus.success,
          accountsForSelect: accounts,
          isSubmitting: false,
        ));
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
}
