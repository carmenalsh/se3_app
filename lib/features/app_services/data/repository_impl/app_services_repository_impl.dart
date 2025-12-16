import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/data/data_source/app_services_remote_data_source.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/deposit_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/transfer_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/withdraw_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class AppServicesRepositoryImpl implements AppServicesRepository {
  final AppServicesRemoteDataSource remoteDataSource;

  AppServicesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AccountSelectItemEntity>>> getAccountsForSelect() async {
    debugPrint("============ AppServicesRepositoryImpl.getAccountsForSelect ============");
    try {
      final models = await remoteDataSource.getAccountsForSelect();
      final entities = models.map((m) => m.toEntity()).toList();
      debugPrint("← getAccountsForSelect success: ${entities.length} items");
      debugPrint("=================================================");
      return Right(entities);
    } on ServerException catch (e) {
      debugPrint("✗ ServerException: ${e.errorModel.errorMessage}");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint("✗ CacheException: ${e.errorMessage}");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ Unexpected error: $e");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
  
@override
Future<Either<Failure, WithdrawResultEntity>> withdraw({
  required WithdrawParams params,
}) async {
  debugPrint("============ AppServicesRepositoryImpl.withdraw ============");
  try {
    debugPrint("→ calling remoteDataSource.withdraw");
    final model = await remoteDataSource.withdraw(params: params);

    debugPrint("← remoteDataSource.withdraw success");
    debugPrint("=================================================");
    return Right(model.toEntity());
  } on ServerException catch (e) {
    debugPrint("✗ withdraw ServerException: ${e.errorModel.errorMessage}");
    debugPrint("=================================================");
    return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
  } on CacheException catch (e) {
    debugPrint("✗ withdraw CacheException: ${e.errorMessage}");
    debugPrint("=================================================");
    return Left(CacheFailure(errMessage: e.errorMessage));
  } catch (e) {
    debugPrint("✗ withdraw Unexpected error: $e");
    debugPrint("=================================================");
    return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
  }
}
 @override
  Future<Either<Failure, DepositResultEntity>> deposit({
    required DepositParams params,
  }) async {
    debugPrint("============ AppServicesRepositoryImpl.deposit ============");
    debugPrint("→ calling remoteDataSource.deposit");

    try {
      final model = await remoteDataSource.deposit(params: params);

      debugPrint("← remoteDataSource.deposit success");
      debugPrint("=================================================");
      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint("✗ deposit ServerException: ${e.errorModel.errorMessage}");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint("✗ deposit CacheException: ${e.errorMessage}");
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ deposit Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
   @override
  Future<Either<Failure, TransferResultEntity>> transfer({
    required TransferParams params,
  }) async {
    debugPrint("============ AppServicesRepositoryImpl.transfer ============");
    try {
      debugPrint("→ calling remoteDataSource.transfer");
      final model = await remoteDataSource.transfer(params: params);

      debugPrint("← remoteDataSource.transfer success");
      debugPrint("=================================================");
      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint("✗ transfer ServerException: ${e.errorModel.errorMessage}");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint("✗ transfer CacheException: ${e.errorMessage}");
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ transfer Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

}
