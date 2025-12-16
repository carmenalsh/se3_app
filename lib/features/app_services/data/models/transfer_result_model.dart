import 'package:complaints_app/features/app_services/domain/entities/transfer_result_entity.dart';

class TransferResultModel {
  final String successMessage;
  final int statusCode;

  const TransferResultModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory TransferResultModel.fromJson(Map<String, dynamic> json) {
    return TransferResultModel(
      successMessage: (json['successMessage'] ?? '') as String,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
    );
  }

  TransferResultEntity toEntity() =>
      TransferResultEntity(successMessage: successMessage);
}
