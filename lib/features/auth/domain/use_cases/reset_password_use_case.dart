import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/reset_password_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/reset_password_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<Either<Failure, ResetPasswordResponse>> call(
    ResetPasswordParams params,
  ) {
    debugPrint("============ ResetPasswordUseCase.call ============");
    return repository.resetPassword(
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
    );
  }
}
