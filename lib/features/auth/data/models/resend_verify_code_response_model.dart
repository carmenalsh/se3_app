import '../../domain/entities/resend_verify_code_response.dart';

class ResendVerifyCodeResponseModel {
  final String successMessage;
  final int statusCode;

  const ResendVerifyCodeResponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory ResendVerifyCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return ResendVerifyCodeResponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  ResendVerifyCodeResponse toEntity() {
    return ResendVerifyCodeResponse(
      successMessage: successMessage,
      statusCode: statusCode.toString(),
    );
  }
}
