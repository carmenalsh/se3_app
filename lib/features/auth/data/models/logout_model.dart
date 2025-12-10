import 'package:complaints_app/features/auth/domain/entities/logout_response.dart';

class LogoutREsponseModel {
  final String successMessage;
  final int statusCode;

  const LogoutREsponseModel({
    required this.successMessage,
    required this.statusCode,
  });

  factory LogoutREsponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutREsponseModel(
      successMessage: json['successMessage']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  LogoutResponse toEntity() {
    return LogoutResponse(
      successMessage: successMessage,
      statusCode: statusCode.toString(),
    );
  }
}
