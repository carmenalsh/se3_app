import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/account_manag/domain/repository/account_manag_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/account_entity.dart';

class GetAccountsUseCase {
  final AccountManagRepository repository;

  const GetAccountsUseCase({required this.repository});

  Future<Either<Failure, List<AccountEntity>>> call() {
    return repository.getAccounts();
  }
}
