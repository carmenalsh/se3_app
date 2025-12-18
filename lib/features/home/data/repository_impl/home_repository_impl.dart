import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:complaints_app/features/home/domain/entities/transaction_page_entity.dart';
import 'package:complaints_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TransactionPageEntity>> gettransAction({
    required int page,
    required int perPage,
  }) async {
      debugPrint("============ HomeRepositoryImpl.gettransAction ============");
    debugPrint("→ params: {page: $page, perPage: $perPage }");
    try {
           debugPrint("→ calling remoteDataSource.gettransAction");
      final model = await remoteDataSource.getTransactions(
        page: page,
        perPage: perPage,
      );

           final entity = model.toEntity();
      debugPrint("← remoteDataSource.gettransAction success, mapped to entity");
      debugPrint("=================================================");

      return Right(entity);
    }  on ServerException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.gettransAction ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.gettransAction CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ HomeRepositoryImpl.gettransAction Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
 
}
