import '../../domain/entities/login_response.dart';

class LoginResponseModel {
  final String token;
  final int expiresIn;
  final String name;
  final int statusCode;

  const LoginResponseModel({
    required this.token,
    required this.expiresIn,
    required this.name,
    required this.statusCode,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return LoginResponseModel(
      token: data['token']?.toString() ?? '',
      expiresIn: data['expires_in'] is int
          ? data['expires_in'] as int
          : int.tryParse(data['expires_in']?.toString() ?? '0') ?? 0,
      name: data['name']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '0') ?? 0,
    );
  }

  LoginResponse toEntity() {
    return LoginResponse(
      token: token,
      expiresIn: expiresIn,
      name: name,
      statusCode: statusCode,
    );
  }
}
