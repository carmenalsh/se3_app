
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/deposit_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:dartz/dartz.dart';

class DepositUseCase {
  final AppServicesRepository repository;

  const DepositUseCase({required this.repository});

  Future<Either<Failure, DepositResultEntity>> call(DepositParams params) {
    return repository.deposit(params: params);
  }
}