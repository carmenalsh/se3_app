import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/resend_password_reset_otp_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ResendPasswordResetOtpUseCase {
  final AuthRepository repository;

  ResendPasswordResetOtpUseCase(this.repository);

  Future<Either<Failure, ResendPasswordResetOtpResponse>> call(String email) {
    debugPrint("============ ResendPasswordResetOtpUseCase.call ============");

    return repository.resendPasswordResetOtp(email: email);
  }
}
