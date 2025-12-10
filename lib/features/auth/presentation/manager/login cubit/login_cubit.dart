import 'package:complaints_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/login_params.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_state.dart'
    show LoginState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:complaints_app/core/databases/cache/cache_helper.dart';


class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginState()) {
    debugPrint("============ LoginCubit INIT ============");
  }

  void emailChanged(String value) {
    debugPrint("LoginCubit.emailChanged -> $value");
    emit(state.copyWith(email: value, errorMessage: null, isSuccess: false));
  }

  void passwordChanged(String value) {
    debugPrint("LoginCubit.passwordChanged -> (length: ${value.length})");
    emit(state.copyWith(password: value, errorMessage: null, isSuccess: false));
  }

  void togglePasswordVisibility() {
    debugPrint(
      "LoginCubit.togglePasswordVisibility -> ${!state.isPasswordObscure}",
    );
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  Future<void> loginSubmitted() async {
    debugPrint("============ LoginCubit.loginSubmitted ============");
    debugPrint(
      "loginSubmitted -> email: ${state.email}, passwordLength: ${state.password.length}",
    );

    if (state.email.isEmpty || state.password.isEmpty) {
      debugPrint("loginSubmitted -> validation failed: empty fields");
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال البريد وكلمة المرور',
          isSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await loginUseCase(
      LoginParams(email: state.email, password: state.password),
    );

    result.fold(
      (failure) {
        debugPrint("loginSubmitted -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: failure.errMessage,
            successMessage: null,
            isSuccess: false,
          ),
        );
      },
      (response) {
        CacheHelper.saveData(key: "welcomeMessage" , value: response.name);
        debugPrint(
          "loginSubmitted -> SUCCESS, name: ${response.name}, statusCode: ${response.statusCode}",
        );

        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.name,
            isSuccess: true,
          ),
        );
      },
    );

    debugPrint("============ LoginCubit.loginSubmitted END ============");
  }
}
