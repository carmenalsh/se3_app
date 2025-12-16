import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/transfer_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:dartz/dartz.dart';

class TransferUseCase {
  final AppServicesRepository repository;

  const TransferUseCase({required this.repository});

  Future<Either<Failure, TransferResultEntity>> call(TransferParams params) {
    return repository.transfer(params: params);
  }
}