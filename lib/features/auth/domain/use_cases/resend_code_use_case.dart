import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/resend_verify_code_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/resend_code_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ResendCodeUseCase {
  final AuthRepository repository;

  ResendCodeUseCase(this.repository);

  Future<Either<Failure, ResendVerifyCodeResponse>> call(
    ResendCodeParams params,
  ) {
    debugPrint("============ ResendCodeUseCase.call ============");
    return repository.resendVerifyCode(email: params.email);
  }
}
