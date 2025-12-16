import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/withdraw_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:dartz/dartz.dart';

class WithdrawUseCase {
  final AppServicesRepository repository;

  const WithdrawUseCase({required this.repository});

  Future<Either<Failure, WithdrawResultEntity>> call(WithdrawParams params) {
    return repository.withdraw(params: params);
  }
}
