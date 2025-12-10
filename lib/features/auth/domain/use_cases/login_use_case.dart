import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/login_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_app/features/auth/domain/use_cases/params/login_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, LoginResponse>> call(LoginParams params) {
    debugPrint("============ LoginUseCase.call ============");
    return repository.login(email: params.email, password: params.password);
  }
}
