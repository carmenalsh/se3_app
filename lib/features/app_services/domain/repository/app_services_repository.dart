import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/deposit_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/transfer_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/withdraw_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:dartz/dartz.dart';

abstract class AppServicesRepository {
  Future<Either<Failure, List<AccountSelectItemEntity>>> getAccountsForSelect();
   Future<Either<Failure, WithdrawResultEntity>> withdraw({
    required WithdrawParams params,
  });
  Future<Either<Failure, DepositResultEntity>> deposit({
    required DepositParams params,
  });
   Future<Either<Failure, TransferResultEntity>> transfer({
    required TransferParams params,
  });
}
