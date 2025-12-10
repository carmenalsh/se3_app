import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/domain/entities/complaint_entity.dart';
import 'package:complaints_app/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SearchComplaintUseCase {
  final HomeRepository repository;

  SearchComplaintUseCase({required this.repository});

  Future<Either<Failure, ComplaintEntity?>> call(String search) {
    debugPrint("============ SearchComplaintUseCase.call ============");
    return repository.searchComplaint(search: search);
  }
}
