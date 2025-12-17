import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/scheduled_result_entity.dart';
import 'params/scheduled_params.dart';

class ScheduledUseCase {
  final AppServicesRepository repository;

  ScheduledUseCase({required this.repository});

  Future<Either<Failure, ScheduledResultEntity>> call(ScheduledParams params) {
    return repository.scheduledTransaction(params);
  }
}
