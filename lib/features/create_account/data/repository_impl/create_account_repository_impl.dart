import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/create_account/data/data_source/create_account_remote_data_source.dart';
import 'package:complaints_app/features/create_account/domain/enities/create_account_entity.dart';
import 'package:complaints_app/features/create_account/domain/repository/create_account_repository.dart';
import 'package:complaints_app/features/create_account/domain/use_case/params/create_account_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class CreateAccountRepositoryImpl implements CreateAccountRepository {
  final CreateAccountRemoteDataSource remoteDataSource;

  CreateAccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CreateAccountEntity>> createAccount({required CreateAccountParams params}) async{
   debugPrint(
      "============ CreateAccountManagRepositoryImpl.createAccount ============",
    );
    try {
      debugPrint("→ calling remoteDataSource.createAccount");
      final model = await remoteDataSource.createAccount(params: params);

      debugPrint("← remoteDataSource.createAccount success");
      debugPrint("=================================================");
      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ createAccount ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint("✗ createAccount CacheException: ${e.errorMessage}");
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ createAccount Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
}
