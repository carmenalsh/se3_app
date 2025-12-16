import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AppServicesRepository {
  Future<Either<Failure, List<AccountSelectItemEntity>>> getAccountsForSelect();
}
