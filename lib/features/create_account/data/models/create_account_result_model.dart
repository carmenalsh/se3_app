import 'package:complaints_app/features/create_account/domain/enities/create_account_entity.dart';


class CreateAccountResultModel {
  final String successMessage;
  final int statusCode;

  const CreateAccountResultModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory CreateAccountResultModel.fromJson(Map<String, dynamic> json) {
    return CreateAccountResultModel(
      successMessage: (json['successMessage'] ?? '') as String,
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
    );
  }

  CreateAccountEntity toEntity() =>
      CreateAccountEntity(successMessage: successMessage);
}
