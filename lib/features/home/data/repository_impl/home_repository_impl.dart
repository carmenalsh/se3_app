import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:complaints_app/features/home/domain/entities/complaint_entity.dart';
import 'package:complaints_app/features/home/domain/entities/complaints_page_entity.dart';
import 'package:complaints_app/features/home/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ComplaintsPageEntity>> getComplaints({
    required int page,
    required int perPage,
  }) async {
    debugPrint("============ HomeRepositoryImpl.getComplaints ============");
    debugPrint("→ params: {page: $page, perPage: $perPage }");
    try {
      debugPrint("→ calling remoteDataSource.getComplaints");
      final model = await remoteDataSource.getComplaints(
        page: page,
        perPage: perPage,
      );

      final entity = model.toEntity();
      debugPrint("← remoteDataSource.getComplaints success, mapped to entity");
      debugPrint("=================================================");

      return Right(entity);
    } on ServerException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.getComplaints ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.getComplaints CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ HomeRepositoryImpl.getComplaints Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, ComplaintEntity?>> searchComplaint({
    required String search,
  }) async {
    debugPrint("============ HomeRepositoryImpl.searchComplaint ============");
    debugPrint("→ search: $search");
    try {
      debugPrint("→ calling remoteDataSource.searchComplaint");
      final model = await remoteDataSource.searchComplaint(search: search);

      final entity = model?.toEntity();
      debugPrint(
        "← remoteDataSource.searchComplaint success, mapped to entity",
      );
      debugPrint("=================================================");

      return Right(entity);
    } on ServerException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.searchComplaint ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.searchComplaint CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ HomeRepositoryImpl.searchComplaint Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    debugPrint("============ HomeRepositoryImpl.getNotifications ============");
    try {
      debugPrint("→ calling remoteDataSource.getNotifications");
      final models = await remoteDataSource.getNotifications();

      final entities = models.map((m) => m.toEntity()).toList();

      debugPrint("← remoteDataSource.getNotifications success");
      debugPrint("=================================================");

      return Right(entities);
    } on ServerException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.getNotifications ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ HomeRepositoryImpl.getNotifications CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ HomeRepositoryImpl.getNotifications Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
}
