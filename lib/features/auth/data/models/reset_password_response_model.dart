import 'package:complaints_app/features/auth/domain/entities/reset_password_response.dart';

class ResetPasswordResponseModel {
  final String successMessage;
  final int statusCode;

  const ResetPasswordResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  ResetPasswordResponse toEntity() {
    return ResetPasswordResponse(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}
