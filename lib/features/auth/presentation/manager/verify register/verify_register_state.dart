class VerifyRegisterState {
  final String otpCode;
  final int remainingSeconds;
  final bool isSubmitting;
  final String? errorMessage;
  final String? successMessage;
  final bool isSuccess;

  const VerifyRegisterState({
    this.otpCode = '',
    this.remainingSeconds = 300,
    this.isSubmitting = false,
    this.errorMessage,
    this.successMessage,
    this.isSuccess = false,
  });

  bool get isTimerFinished => remainingSeconds <= 0;

  VerifyRegisterState copyWith({
    String? otpCode,
    int? remainingSeconds,
    bool? isSubmitting,
    String? errorMessage,
    String? successMessage,
    bool? isSuccess,
  }) {
    return VerifyRegisterState(
      otpCode: otpCode ?? this.otpCode,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      successMessage: successMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
