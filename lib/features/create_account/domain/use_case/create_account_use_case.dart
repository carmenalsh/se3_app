import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/create_account/domain/enities/create_account_entity.dart';
import 'package:complaints_app/features/create_account/domain/repository/create_account_repository.dart';
import 'package:complaints_app/features/create_account/domain/use_case/params/create_account_params.dart';
import 'package:dartz/dartz.dart';

class CreateAccountUseCase {
  final CreateAccountRepository repository;

  const CreateAccountUseCase({required this.repository});

  Future<Either<Failure, CreateAccountEntity>> call(
    CreateAccountParams params,
  ) {
    return repository.createAccount(params: params);
  }
}