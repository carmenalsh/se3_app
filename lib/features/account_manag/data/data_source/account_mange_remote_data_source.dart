import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/dio_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/account_manag/data/models/update_account_result_model.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:flutter/material.dart';

import '../models/account_model.dart';

abstract class AccountManagRemoteDataSource {
  AccountManagRemoteDataSource(DioConsumer apiConsumer);

  Future<List<AccountModel>> getAccounts();
  
  Future<UpdateAccountResultModel> updateAccount({
    required UpdateAccountParams params,
  });
}

class AccountRemoteDataSourceImpl implements AccountManagRemoteDataSource {
  final ApiConsumer apiConsumer;

  AccountRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<AccountModel>> getAccounts() async {
    debugPrint(
      "============ AccountManagRemoteDataSourceImpl.getAccounts ============",
    );

    final response = await apiConsumer.get(EndPoints.getAccounts);

    debugPrint("← response (getAccounts): $response");
    debugPrint("=================================================");
    final map = response as Map<String, dynamic>;

    final list = (map['data'] as List<dynamic>? ?? []);

    return list
        .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  
@override
Future<UpdateAccountResultModel> updateAccount({
  required UpdateAccountParams params,
}) async {
  debugPrint("============ AccountManagRemoteDataSourceImpl.updateAccount ============");

  final response = await apiConsumer.post(
    EndPoints.updateAccount, 
    data: params.toMap(),
  );

  debugPrint("← response (updateAccount): $response");
  debugPrint("=================================================");

  final map = response is Map<String, dynamic>
      ? response
      : (response.data as Map<String, dynamic>);

  return UpdateAccountResultModel.fromJson(map);
}
}
