import '../../domain/entities/update_account_result_entity.dart';

class UpdateAccountResultModel {
  final String successMessage;
  final int statusCode;

  const UpdateAccountResultModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory UpdateAccountResultModel.fromJson(Map<String, dynamic> json) {
    return UpdateAccountResultModel(
      successMessage: (json['successMessage'] ?? '') as String,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
    );
  }

  UpdateAccountResultEntity toEntity() =>
      UpdateAccountResultEntity(successMessage: successMessage);
}
