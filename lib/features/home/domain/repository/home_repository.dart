import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/domain/entities/complaint_entity.dart';
import 'package:complaints_app/features/home/domain/entities/notification_entity.dart';
import 'package:dartz/dartz.dart';
import '../entities/complaints_page_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, ComplaintsPageEntity>> getComplaints({
    required int page,
    required int perPage,
  });

  Future<Either<Failure, ComplaintEntity?>> searchComplaint({
    required String search,
  });

  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
}
