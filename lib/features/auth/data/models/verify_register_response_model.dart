import 'package:complaints_app/features/auth/domain/entities/verify_register_response.dart';

class VerifyRegisterResponseModel {
  final String successMessage;
  final int statusCode;

  const VerifyRegisterResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory VerifyRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyRegisterResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  VerifyRegisterResponse toEntity() {
    return VerifyRegisterResponse(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}
