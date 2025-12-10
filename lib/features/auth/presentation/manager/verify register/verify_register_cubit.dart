import 'dart:async';
import 'package:complaints_app/features/auth/domain/use_cases/params/resend_code_params.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/verify_register_params.dart';
import 'package:complaints_app/features/auth/domain/use_cases/resend_code_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/verify_register_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_register_state.dart';

class VerifyRegisterCubit extends Cubit<VerifyRegisterState> {
  final VerifyRegisterUseCase verifyRegisterUseCase;
  final ResendCodeUseCase resendCodeUseCase;
  final String email;
  Timer? _timer;

  VerifyRegisterCubit({
    required this.email,
    required this.verifyRegisterUseCase,
    required this.resendCodeUseCase,
  }) : super(const VerifyRegisterState()) {
    debugPrint("============ VerifyRegisterCubit INIT ============");
    debugPrint("VerifyRegisterCubit created for email: $email");
    _startTimer();
  }

  void _startTimer() {
    debugPrint("VerifyRegisterCubit._startTimer() -> reset to 300s");
    _timer?.cancel();
    emit(state.copyWith(remainingSeconds: 300));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        debugPrint("VerifyRegisterCubit timer finished (0s left)");
        timer.cancel();
        emit(state.copyWith(remainingSeconds: 0));
      } else {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      }
    });
  }

  void otpChanged(String value) {
    debugPrint("VerifyRegisterCubit.otpChanged() -> value: $value");
    emit(
      state.copyWith(
        otpCode: value,
        isSuccess: false,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }

  Future<void> submitOtp() async {
    debugPrint("============ VerifyRegisterCubit.submitOtp ============");

    if (state.otpCode.length != 6) {
      debugPrint(
        "submitOtp -> invalid otp length: ${state.otpCode.length} (must be 6)",
      );
      emit(
        state.copyWith(
          errorMessage: 'الرجاء إدخال الرمز المؤلف من 6 أرقام',
          isSuccess: false,
        ),
      );
      return;
    }

    debugPrint(
      "submitOtp -> calling verifyRegisterUseCase with email: $email, otp: ${state.otpCode}",
    );

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await verifyRegisterUseCase.call(
      VerifyRegisterParams(email: email, code: state.otpCode),
    );

    result.fold(
      (failure) {
        debugPrint("submitOtp -> FAILURE: ${failure.errMessage}");
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
        debugPrint(
          "submitOtp -> SUCCESS: ${response.successMessage}, stopping timer",
        );
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.successMessage,
            isSuccess: true,
          ),
        );
        _timer?.cancel();
      },
    );
    debugPrint("============ submitOtp END ============");
  }

  Future<void> resendCode() async {
    debugPrint("============ VerifyRegisterCubit.resendCode ============");
    debugPrint("resendCode -> for email: $email");

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        successMessage: null,
        isSuccess: false,
      ),
    );

    final result = await resendCodeUseCase(ResendCodeParams(email: email));

    result.fold(
      (failure) {
        debugPrint("resendCode -> FAILURE: ${failure.errMessage}");
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
        debugPrint(
          "resendCode -> SUCCESS: ${response.successMessage}, restarting timer",
        );
        _startTimer();
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: null,
            successMessage: response.successMessage,
            isSuccess: false,
          ),
        );
      },
    );
    debugPrint("============ resendCode END ============");
  }

  @override
  Future<void> close() {
    debugPrint("VerifyRegisterCubit.close() -> cancel timer & dispose");
    _timer?.cancel();
    return super.close();
  }
}
