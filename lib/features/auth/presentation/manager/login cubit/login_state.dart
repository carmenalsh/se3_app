class LoginState {
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final bool isSuccess;
  final bool isPasswordObscure;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.isSuccess = false,
    this.isPasswordObscure = true,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    bool? isSuccess,
    bool? isPasswordObscure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
