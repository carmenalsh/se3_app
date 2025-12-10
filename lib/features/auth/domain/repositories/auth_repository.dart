import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/auth/domain/entities/forget_password_email_response.dart';
import 'package:complaints_app/features/auth/domain/entities/login_response.dart';
import 'package:complaints_app/features/auth/domain/entities/logout_response.dart';
import 'package:complaints_app/features/auth/domain/entities/register_response.dart';
import 'package:complaints_app/features/auth/domain/entities/resend_password_reset_otp_response.dart';
import 'package:complaints_app/features/auth/domain/entities/resend_verify_code_response.dart';
import 'package:complaints_app/features/auth/domain/entities/reset_password_response.dart';
import 'package:complaints_app/features/auth/domain/entities/verify_forget_password_response.dart';
import 'package:complaints_app/features/auth/domain/entities/verify_register_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    required String nationalNumber,
  });

  Future<Either<Failure, VerifyRegisterResponse>> verifyRegisterCode({
    required String email,
    required String code,
  });

  Future<Either<Failure, ResendVerifyCodeResponse>> resendVerifyCode({
    required String email,
  });

  Future<Either<Failure, ForgetPasswordEmailResponse>> sendForgetPasswordEmail({
    required String email,
  });

  Future<Either<Failure, VerifyForgetPasswordResponse>>
  verifyForgetPasswordOtp({required String email, required String otpCode});

  Future<Either<Failure, ResendPasswordResetOtpResponse>>
  resendPasswordResetOtp({required String email});

  Future<Either<Failure, ResetPasswordResponse>> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, LogoutResponse>> logout();
}
