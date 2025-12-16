import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/account_manag/domain/entities/update_account_result_entity.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:dartz/dartz.dart';
import '../entities/account_entity.dart';

abstract class AccountManagRepository {
  Future<Either<Failure, List<AccountEntity>>> getAccounts();
  Future<Either<Failure, UpdateAccountResultEntity>> updateAccount({
  required UpdateAccountParams params,
});
}