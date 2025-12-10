class RegisterState {
  final String name;
  final String email;
  final String idNumber;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final bool isSuccess;
  final bool isPasswordObscure;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.idNumber = '',
    this.password = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.isSuccess = false,
    this.isPasswordObscure = true,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? idNumber,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    bool? isSuccess,
    bool? isPasswordObscure,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      idNumber: idNumber ?? this.idNumber,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}
