import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/create_account/domain/enities/create_account_entity.dart';
import 'package:complaints_app/features/create_account/domain/use_case/params/create_account_params.dart';
import 'package:dartz/dartz.dart';

abstract class CreateAccountRepository {
  Future<Either<Failure, CreateAccountEntity>> createAccount({
  required CreateAccountParams params,
});
}