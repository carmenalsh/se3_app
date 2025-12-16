import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/create_account/data/models/create_account_result_model.dart';
import 'package:complaints_app/features/create_account/domain/use_case/params/create_account_params.dart';
import 'package:flutter/material.dart';

abstract class CreateAccountRemoteDataSource {
  Future<CreateAccountResultModel> createAccount({
    required CreateAccountParams params,
  });
}

class CreateAccountRemoteDataSourceImpl
    implements CreateAccountRemoteDataSource {
  final ApiConsumer apiConsumer;

  CreateAccountRemoteDataSourceImpl({required this.apiConsumer});
  
  @override
  Future<CreateAccountResultModel> createAccount({required CreateAccountParams params}) async{
  debugPrint("============ CreateAccountRemoteDataSourceImpl.createAccount ============");

  final response = await apiConsumer.post(
    EndPoints.createAccount, //*
    data: params.toMap(),
  );

  debugPrint("← response (createAccount): $response");
  debugPrint("=================================================");
  final map = response is Map<String, dynamic>
      ? response
      : (response.data as Map<String, dynamic>);

  return CreateAccountResultModel.fromJson(map);
  }

  
}
