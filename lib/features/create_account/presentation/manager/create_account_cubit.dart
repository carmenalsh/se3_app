import 'package:complaints_app/features/create_account/presentation/manager/create_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  final descriptionController = TextEditingController();
  CreateAccountCubit()
    : super(
        const CreateAccountState(
          accounts: [
            "حساب جاري - 1234",
            "حساب توفير - 5678",
            "حساب استثمار - 9999",
          ],
        ),
      );
  @override
  Future<void> close() {
    descriptionController.dispose();
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
    emit(state.copyWith(selectedAccount: value));
  }
}
