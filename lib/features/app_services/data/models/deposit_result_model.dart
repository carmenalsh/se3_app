import 'package:complaints_app/features/app_services/domain/entities/deposit_result_entity.dart';

class DepositResultModel {
  final String successMessage;
  final int statusCode;

  const DepositResultModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory DepositResultModel.fromJson(Map<String, dynamic> json) {
    return DepositResultModel(
      successMessage: (json['successMessage'] ?? '') as String,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
    );
  }

  DepositResultEntity toEntity() =>
      DepositResultEntity(successMessage: successMessage);
}
