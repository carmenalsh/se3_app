import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/register_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/register_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, RegisterResponse>> call(RegisterParams params) {
    debugPrint("============ RegisterUseCase.call ============");

    return repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      nationalNumber: params.nationalNumber,
    );
  }
}
