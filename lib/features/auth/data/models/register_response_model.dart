import 'package:complaints_app/features/auth/domain/entities/register_response.dart';

class RegisterResponseModel {
  final String successMessage;
  final int statusCode;

  const RegisterResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  RegisterResponse toEntity() {
    return RegisterResponse(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}
