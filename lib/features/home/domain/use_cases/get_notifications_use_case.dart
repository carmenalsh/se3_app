import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class GetNotificationsUseCase {
  final HomeRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<NotificationEntity>>> call() {
    debugPrint("============ GetNotificationsUseCase.call ============");
    return repository.getNotifications();
  }
}
