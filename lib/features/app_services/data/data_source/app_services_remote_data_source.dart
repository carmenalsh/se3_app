import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/app_services/data/models/account_select_item_model.dart';
import 'package:complaints_app/features/app_services/data/models/deposit_result_model.dart';
import 'package:complaints_app/features/app_services/data/models/notification_model.dart';
import 'package:complaints_app/features/app_services/data/models/scheduled_result_model.dart';
import 'package:complaints_app/features/app_services/data/models/transfer_result_model.dart';
import 'package:complaints_app/features/app_services/data/models/withdraw_result_model.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/scheduled_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:complaints_app/features/auth/data/models/logout_model.dart';
import 'package:flutter/material.dart';

abstract class AppServicesRemoteDataSource {
  Future<List<AccountSelectItemModel>> getAccountsForSelect();
   Future<WithdrawResultModel> withdraw({
    required WithdrawParams params,
  });
    Future<DepositResultModel> deposit({
    required DepositParams params,
  });
   Future<TransferResultModel> transfer({required TransferParams params});
   Future<ScheduledResultModel> scheduledTransaction(ScheduledParams params);
    Future<List<NotificationModel>> getNotifications();
}

class AppServicesRemoteDataSourceImpl implements AppServicesRemoteDataSource {
  final ApiConsumer apiConsumer;

  AppServicesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<AccountSelectItemModel>> getAccountsForSelect() async {
    debugPrint("============ AppServicesRemoteDataSource.getAccountsForSelect ============");

    final response = await apiConsumer.get(
      EndPoints.accountsForSelect, // ✅ حطيه بالـ end_points.dart
    );

    debugPrint("← response (accountsForSelect): $response");
    debugPrint("=================================================");

    final map = response is Map<String, dynamic>
        ? response
        : (response.data as Map<String, dynamic>);

    final list = (map['data'] as List? ?? [])
        .map((e) => AccountSelectItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return list;
  }
@override
Future<WithdrawResultModel> withdraw({required WithdrawParams params}) async {
  debugPrint("============ AppServicesRemoteDataSource.withdraw ============");
  debugPrint("→ data: ${params.toMap()}");

  final response = await apiConsumer.post(
    EndPoints.withdraw,
    data: params.toMap(),
  );

  debugPrint("← response (withdraw): $response");
  debugPrint("=================================================");

  final map = response is Map<String, dynamic>
      ? response
      : (response.data as Map<String, dynamic>);

  return WithdrawResultModel.fromJson(map);
}
  @override
  Future<DepositResultModel> deposit({required DepositParams params}) async {
    debugPrint("============ AppServicesRemoteDataSourceImpl.deposit ============");

    final response = await apiConsumer.post(
      EndPoints.deposit, // ✅ رح نضيفها تحت
      data: params.toMap(),
    );

    debugPrint("← response (deposit): $response");
    debugPrint("=================================================");

    final map = response is Map<String, dynamic>
        ? response
        : (response.data as Map<String, dynamic>);

    return DepositResultModel.fromJson(map);
  }
  
  @override
  Future<TransferResultModel> transfer({required TransferParams params}) async {
    debugPrint("============ AppServicesRemoteDataSourceImpl.transfer ============");

    final response = await apiConsumer.post(
      EndPoints.transfer, // لازم تضيفه بالـ EndPoints
      data: params.toMap(),
    );

    debugPrint("← response (transfer): $response");
    debugPrint("=================================================");

    final map = response is Map<String, dynamic>
        ? response
        : (response.data as Map<String, dynamic>);

    return TransferResultModel.fromJson(map);
  }
  @override
Future<ScheduledResultModel> scheduledTransaction(ScheduledParams params) async {
  final response = await apiConsumer.post(
    EndPoints.scheduled,
    data: {
      "account_id": params.accountId,
      "type": params.type,
      "amount": params.amount,
      "scheduled_at": params.scheduledAt,
      "name": params.name,
    },
    // إذا عندك خيار form-data بمشروعك ضيفه هون حسب DioConsumer عندك
  );

  return ScheduledResultModel.fromJson(response);
}
 @override
  Future<List<NotificationModel>> getNotifications() async {
    debugPrint(
      "============ HomeRemoteDataSourceImpl.getNotifications ============",
    );

    final response = await apiConsumer.get(EndPoints.getNotifications);

    debugPrint("← response (getNotifications): $response");
    debugPrint("=================================================");

    final dataList = response['data'] as List<dynamic>;
    return dataList
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
