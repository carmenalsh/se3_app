import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/verify_forget_password_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/forget_password_verify_otp_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class VerifyForgetPasswordUseCase {
  final AuthRepository repository;

  VerifyForgetPasswordUseCase({required this.repository});

  Future<Either<Failure, VerifyForgetPasswordResponse>> call(
    VerifyForgetPasswordOtpParams params,
  ) {
    debugPrint("============ VerifyForgetPasswordUseCase.call ============");

    return repository.verifyForgetPasswordOtp(
      email: params.email,
      otpCode: params.otpCode,
    );
  }
}
