import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/domain/entities/transaction_page_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../repository/home_repository.dart';


class GetTransActionUseCase {
  final HomeRepository repository;

  const GetTransActionUseCase({required this.repository});

  Future<Either<Failure, TransactionPageEntity>> call(
    GetTransActionParams params,
  ) {
        debugPrint("============ GetTransActionUseCase.call ============");
    return repository.gettransAction(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
// class GetComplaintsUseCase {
//   final HomeRepository repository;

//   GetComplaintsUseCase({required this.repository});


//   Future<Either<Failure, ComplaintsPageEntity>> call(
//     GetComplaintsParams params,
//   ) {
    // debugPrint("============ GetComplaintsUseCase.call ============");

//     return repository.getComplaints(page: params.page, perPage: params.perPage);
//   }
// }

class GetTransActionParams {
  final int page;
  final int perPage;

  const GetTransActionParams({required this.page, required this.perPage});
}