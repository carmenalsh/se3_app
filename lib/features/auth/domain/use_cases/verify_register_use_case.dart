import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/verify_register_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/verify_register_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class VerifyRegisterUseCase {
  final AuthRepository repository;

  VerifyRegisterUseCase(this.repository);

  Future<Either<Failure, VerifyRegisterResponse>> call(
    VerifyRegisterParams params,
  ) {
    debugPrint("============ VerifyRegisterUseCase.call ============");

    return repository.verifyRegisterCode(
      email: params.email,
      code: params.code,
    );
  }
}
