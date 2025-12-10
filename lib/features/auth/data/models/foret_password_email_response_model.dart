import 'package:complaints_app/features/auth/domain/entities/forget_password_email_response.dart';

class ForgetPasswordEmailResponseModel {
  final String successMessage;
  final int statusCode;

  const ForgetPasswordEmailResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory ForgetPasswordEmailResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordEmailResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

 ForgetPasswordEmailResponse toEntity() {
    return ForgetPasswordEmailResponse(
      successMessage: successMessage,
      statusCode: statusCode.toString(),
    );
  }
}
