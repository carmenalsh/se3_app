import 'package:complaints_app/features/app_services/domain/entities/withdraw_result_entity.dart';

class WithdrawResultModel {
  final String successMessage;
  final int statusCode;

  const WithdrawResultModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory WithdrawResultModel.fromJson(Map<String, dynamic> json) {
    return WithdrawResultModel(
      successMessage: (json['successMessage'] ?? '') as String,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
    );
  }

  WithdrawResultEntity toEntity() =>
      WithdrawResultEntity(successMessage: successMessage);
}
