import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:dartz/dartz.dart';

class GetAccountsForSelectUseCase {
  final AppServicesRepository repository;

  const GetAccountsForSelectUseCase({required this.repository});

  Future<Either<Failure, List<AccountSelectItemEntity>>> call() {
    return repository.getAccountsForSelect();
  }
}
