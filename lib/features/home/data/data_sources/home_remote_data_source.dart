import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/home/data/models/transaction_page_model.dart';
import 'package:flutter/material.dart';


abstract class HomeRemoteDataSource {
  // Future<ComplaintsPageModel> getComplaints({
  //   required int page,
  //   required int perPage,
  // });

  Future<TransactionPageModel> getTransactions({
    required int page,
    required int perPage,
  });

  // Future<SearchComplaintModel?> searchComplaint({required String search});

  // Future<List<NotificationModel>> getNotifications();
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

  // @override
  // Future<SearchComplaintModel?> searchComplaint({
  //   required String search,
  // }) async {
  //   debugPrint(
  //     "============ HomeRemoteDataSourceImpl.searchComplaint ============",
  //   );
  //   final response = await apiConsumer.post(
  //     EndPoints.searchComplaint,
  //     data: {'search': search},
  //   );
  //   debugPrint("← response (searchComplaint): $response");
  //   debugPrint("=================================================");
  //   final data = response['data'];
  //   if (data is List && data.isEmpty) {
  //     return null;
  //   }
  //   if (data is Map<String, dynamic>) {
  //     return SearchComplaintModel.fromJson(data);
  //   }
  //   return null;
  // }

  // @override
  // Future<List<NotificationModel>> getNotifications() async {
  //   debugPrint(
  //     "============ HomeRemoteDataSourceImpl.getNotifications ============",
  //   );

  //   final response = await apiConsumer.get(EndPoints.getNotifications);

  //   debugPrint("← response (getNotifications): $response");
  //   debugPrint("=================================================");

  //   final dataList = response['data'] as List<dynamic>;
  //   return dataList
  //       .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }
}
