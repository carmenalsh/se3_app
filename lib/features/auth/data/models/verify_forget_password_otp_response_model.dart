import 'package:complaints_app/features/auth/domain/entities/verify_forget_password_response.dart';

class VerifyForgetPasswordOtpResponseModel {
  final String successMessage;
  final int statusCode;

  const VerifyForgetPasswordOtpResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory VerifyForgetPasswordOtpResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VerifyForgetPasswordOtpResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  VerifyForgetPasswordResponse toEntity() {
    return VerifyForgetPasswordResponse(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}
