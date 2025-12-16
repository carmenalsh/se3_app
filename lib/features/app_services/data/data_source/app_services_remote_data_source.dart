import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/app_services/data/models/account_select_item_model.dart';
import 'package:flutter/material.dart';

abstract class AppServicesRemoteDataSource {
  Future<List<AccountSelectItemModel>> getAccountsForSelect();
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
}
