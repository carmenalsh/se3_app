import 'package:complaints_app/features/auth/domain/use_cases/params/register_params.dart';
import 'package:complaints_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:complaints_app/features/auth/presentation/manager/register%20cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(const RegisterState()) {
    debugPrint("============ RegisterCubit INIT ============");
  }

  void nameChanged(String value) {
    debugPrint("RegisterCubit.nameChanged -> $value");
    emit(state.copyWith(name: value, isSuccess: false, errorMessage: null));
  }

  void emailChanged(String value) {
    debugPrint("RegisterCubit.emailChanged -> $value");
    emit(state.copyWith(email: value, isSuccess: false, errorMessage: null));
  }

  void idNumberChanged(String value) {
    debugPrint("RegisterCubit.idNumberChanged -> $value");
    emit(state.copyWith(idNumber: value, isSuccess: false, errorMessage: null));
  }

  void passwordChanged(String value) {
    debugPrint("RegisterCubit.passwordChanged -> (length: ${value.length})");
    emit(state.copyWith(password: value, isSuccess: false, errorMessage: null));
  }

  void togglePasswordVisibility() {
    debugPrint(
      "RegisterCubit.togglePasswordVisibility -> ${!state.isPasswordObscure}",
    );
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  Future<void> registerSubmitted() async {
    debugPrint("============ RegisterCubit.registerSubmitted ============");
    debugPrint(
      "current state -> {name: ${state.name}, email: ${state.email}, idNumber: ${state.idNumber}}",
    );

    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.idNumber.isEmpty ||
        state.password.isEmpty) {
      debugPrint("registerSubmitted -> validation failed: empty fields");
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'الرجاء إدخال كل الحقول',
          successMessage: null,
          isSuccess: false,
        ),
      );
      return;
    }

    debugPrint("registerSubmitted -> calling RegisterUseCase...");
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await registerUseCase(
      RegisterParams(
        name: state.name,
        email: state.email,
        password: state.password,
        nationalNumber: state.idNumber,
      ),
    );

    result.fold(
      (failure) {
        debugPrint("registerSubmitted -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
            successMessage: null,
            isSuccess: false,
          ),
        );
      },
      (registerResponse) {
        debugPrint(
          "registerSubmitted -> SUCCESS: ${registerResponse.successMessage}",
        );
        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            errorMessage: null,
            successMessage: registerResponse.successMessage,
          ),
        );
      },
    );

    debugPrint("============ RegisterCubit.registerSubmitted END ============");
  }
}
