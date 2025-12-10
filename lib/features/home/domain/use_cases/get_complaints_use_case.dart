import 'package:complaints_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../entities/complaints_page_entity.dart';
import '../repository/home_repository.dart';

class GetComplaintsUseCase {
  final HomeRepository repository;

  GetComplaintsUseCase({required this.repository});


  Future<Either<Failure, ComplaintsPageEntity>> call(
    GetComplaintsParams params,
  ) {
    debugPrint("============ GetComplaintsUseCase.call ============");

    return repository.getComplaints(page: params.page, perPage: params.perPage);
  }
}

class GetComplaintsParams {
  final int page;
  final int perPage;

  const GetComplaintsParams({required this.page, required this.perPage});
}
