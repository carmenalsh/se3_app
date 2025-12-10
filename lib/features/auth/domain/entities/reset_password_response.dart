class ResetPasswordResponse {
  final String successMessage;
  final int statusCode;

  const ResetPasswordResponse({
    required this.successMessage,
    required this.statusCode,
  });
}
