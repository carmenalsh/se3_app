import '../../domain/entities/resend_password_reset_otp_response.dart';

class ResendPasswordResetOtpResponseModel {
  final String successMessage;
  final int statusCode;

  const ResendPasswordResetOtpResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory ResendPasswordResetOtpResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResendPasswordResetOtpResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  ResendPasswordResetOtpResponse toEntity() {
    return ResendPasswordResetOtpResponse(
      successMessage: successMessage,
      statusCode: statusCode,
    );
  }
}
