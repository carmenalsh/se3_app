import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/app_services/data/models/account_select_item_model.dart';
import 'package:complaints_app/features/app_services/data/models/deposit_result_model.dart';
import 'package:complaints_app/features/app_services/data/models/withdraw_result_model.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:flutter/material.dart';

abstract class AppServicesRemoteDataSource {
  Future<List<AccountSelectItemModel>> getAccountsForSelect();
   Future<WithdrawResultModel> withdraw({
    required WithdrawParams params,
  });
    Future<DepositResultModel> deposit({
    required DepositParams params,
  });
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
}
