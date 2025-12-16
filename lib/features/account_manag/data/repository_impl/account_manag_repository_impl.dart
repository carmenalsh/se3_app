import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/account_manag/data/data_source/account_mange_remote_data_source.dart';
import 'package:complaints_app/features/account_manag/domain/entities/account_entity.dart';
import 'package:complaints_app/features/account_manag/domain/entities/update_account_result_entity.dart';
import 'package:complaints_app/features/account_manag/domain/repository/account_manag_repository.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class AccountManagRepositoryImpl implements AccountManagRepository {
  final AccountManagRemoteDataSource remoteDataSource;

  AccountManagRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AccountEntity>>> getAccounts() async {
    debugPrint(
      "============ AccountManagRepositoryImpl.getAccounts ============",
    );
    try {
      debugPrint("→ calling remoteDataSource.getAccounts");
      final models = await remoteDataSource.getAccounts();

      final entities = models.map((m) => m.toEntity()).toList();

      debugPrint("← remoteDataSource.getAccounts success, mapped to entities");
      debugPrint("=================================================");
      return Right(entities);
    } on ServerException catch (e) {
      debugPrint(
        "✗ AccountManagRepositoryImpl.getAccounts ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AccountManagRepositoryImpl.getAccounts CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint(
        "✗ AccountManagRepositoryImpl.getAccounts Unexpected error: $e",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, UpdateAccountResultEntity>> updateAccount({
    required UpdateAccountParams params,
  }) async {
    debugPrint(
      "============ AccountManagRepositoryImpl.updateAccount ============",
    );
    try {
      debugPrint("→ calling remoteDataSource.updateAccount");
      final model = await remoteDataSource.updateAccount(params: params);

      debugPrint("← remoteDataSource.updateAccount success");
      debugPrint("=================================================");
      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ updateAccount ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint("✗ updateAccount CacheException: ${e.errorMessage}");
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ updateAccount Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
}
