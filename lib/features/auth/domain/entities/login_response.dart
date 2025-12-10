class LoginResponse {
  final String token;
  final int expiresIn;
  final String name;
  final int statusCode;

  const LoginResponse({
    required this.token,
    required this.expiresIn,
    required this.name,
    required this.statusCode,
  });
}
