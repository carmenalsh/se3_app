import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/data/data_source/app_services_remote_data_source.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
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
}
