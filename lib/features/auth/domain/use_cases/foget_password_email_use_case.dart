import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/forget_password_email_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/forget_password_email_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class FogretPasswordEmailUseCase {
  final AuthRepository repository;

  FogretPasswordEmailUseCase({required this.repository});

  Future<Either<Failure, ForgetPasswordEmailResponse>> call(
    ForgetPasswordEmailParams params,
  ) {
    debugPrint("============ FogretPasswordEmailUseCase.call ============");
    return repository.sendForgetPasswordEmail(email: params.email);
  }
}
