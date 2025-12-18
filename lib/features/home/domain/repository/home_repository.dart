import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/home/domain/entities/transaction_page_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, TransactionPageEntity>> gettransAction({
    required int page,
    required int perPage,
  });
}
