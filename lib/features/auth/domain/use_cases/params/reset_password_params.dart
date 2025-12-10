class ResetPasswordParams {
  final String email;
  final String password;
  final String passwordConfirmation;

  ResetPasswordParams({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}
