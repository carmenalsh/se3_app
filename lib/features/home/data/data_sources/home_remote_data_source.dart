import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/home/data/models/transaction_page_model.dart';
import 'package:flutter/material.dart';


abstract class HomeRemoteDataSource {
  Future<TransactionPageModel> getTransactions({
    required int page,
    required int perPage,
  });

}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  HomeRemoteDataSourceImpl(this.apiConsumer);
  @override
  Future<TransactionPageModel> getTransactions({
    required int page,
    required int perPage,
  }) async {
      debugPrint(
      "============ HomeRemoteDataSourceImpl.getTransactions ============",
    );
    final response = await apiConsumer.post(
      EndPoints.getTransactions, 
      data: {'page': page, 'per_page': perPage},
    );

    debugPrint("← response (gettransAction): $response");
    debugPrint("=================================================");
      return TransactionPageModel.fromJson(response);

  }

}
