import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/account_manag/domain/repository/account_manag_repository.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:dartz/dartz.dart';
import '../entities/update_account_result_entity.dart';

class UpdateAccountUseCase {
  final AccountManagRepository repository;

  const UpdateAccountUseCase({required this.repository});

  Future<Either<Failure, UpdateAccountResultEntity>> call(
    UpdateAccountParams params,
  ) {
    return repository.updateAccount(params: params);
  }
}
