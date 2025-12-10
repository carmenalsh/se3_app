import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/features/auth/data/models/foret_password_email_response_model.dart';
import 'package:complaints_app/features/auth/data/models/login_response_model.dart';
import 'package:complaints_app/features/auth/data/models/logout_model.dart';
import 'package:complaints_app/features/auth/data/models/register_response_model.dart';
import 'package:complaints_app/features/auth/data/models/resend_password_reset_otp_response_model.dart';
import 'package:complaints_app/features/auth/data/models/resend_verify_code_response_model.dart';
import 'package:complaints_app/features/auth/data/models/reset_password_response_model.dart';
import 'package:complaints_app/features/auth/data/models/verify_forget_password_otp_response_model.dart';
import 'package:complaints_app/features/auth/data/models/verify_register_response_model.dart';
import 'package:flutter/material.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String nationalNumber,
  });

  Future<VerifyRegisterResponseModel> verifyRegisterCode({
    required String email,
    required String code,
  });

  Future<ResendVerifyCodeResponseModel> resendVerifyCode({
    required String email,
  });

  Future<ForgetPasswordEmailResponseModel> sendForgetPasswordEmail({
    required String email,
  });

  Future<VerifyForgetPasswordOtpResponseModel> verifyForgotPasswordOtp({
    required String email,
    required String otpCode,
  });

  Future<ResendPasswordResetOtpResponseModel> resendPasswordResetOtp({
    required String email,
  });

  Future<ResetPasswordResponseModel> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });


  Future<LogoutREsponseModel> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  //////////////////////// registet////////////////////////////
  @override
  Future<RegisterResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String nationalNumber,
  }) async {
    debugPrint("============ AuthRemoteDataSourceImpl.register ============");
    debugPrint(
      "→ endpoint: ${EndPoints.registerCitizen} | data: {name: $name, email: $email, national_number: $nationalNumber}",
    );

    final response = await apiConsumer.post(
      EndPoints.registerCitizen,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'national_number': nationalNumber,
      },
    );

    debugPrint("← response (register): $response");
    debugPrint("=================================================");

    return RegisterResponseModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<ResendVerifyCodeResponseModel> resendVerifyCode({
    required String email,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.resendVerifyCode ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.resendVerifyCode} | data: {email: $email}",
    );

    final response = await apiConsumer.post(
      EndPoints.resendVerifyCode,
      data: {"email": email},
    );

    debugPrint("← response (resendVerifyCode): $response");
    debugPrint("=================================================");

    return ResendVerifyCodeResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }

  ////////////////////////////verify regg/////////////////////////////////
  @override
  Future<VerifyRegisterResponseModel> verifyRegisterCode({
    required String email,
    required String code,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.verifyRegisterCode ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.verifyRegisterCode} | data: {email: $email, otp_code: $code}",
    );

    final response = await apiConsumer.post(
      EndPoints.verifyRegisterCode,
      data: {"email": email, "otp_code": code},
    );

    debugPrint("← response (verifyRegisterCode): $response");
    debugPrint("=================================================");

    return VerifyRegisterResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }

  ///////////////////////forget password/////////////////////////////
  @override
  Future<ForgetPasswordEmailResponseModel> sendForgetPasswordEmail({
    required String email,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.sendForgetPasswordEmail ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.forgotPasswordEmail} | data: {email: $email}",
    );

    final response = await apiConsumer.post(
      EndPoints.forgotPasswordEmail,
      data: {"email": email},
    );

    debugPrint("← response (sendForgetPasswordEmail): $response");
    debugPrint("=================================================");

    return ForgetPasswordEmailResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }

  @override
  Future<VerifyForgetPasswordOtpResponseModel> verifyForgotPasswordOtp({
    required String email,
    required String otpCode,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.verifyForgotPasswordOtp ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.verifyForgotPasswordEmail} | data: {email: $email, otp_code: $otpCode}",
    );

    final response = await apiConsumer.post(
      EndPoints.verifyForgotPasswordEmail,
      data: {'email': email, 'otp_code': otpCode},
    );

    debugPrint("← response (verifyForgotPasswordOtp): $response");
    debugPrint("=================================================");

    return VerifyForgetPasswordOtpResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }

  @override
  Future<ResendPasswordResetOtpResponseModel> resendPasswordResetOtp({
    required String email,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.resendPasswordResetOtp ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.resendPasswordResetOtp} | data: {email: $email}",
    );

    final response = await apiConsumer.post(
      EndPoints.resendPasswordResetOtp,
      data: {'email': email},
    );

    debugPrint("← response (resendPasswordResetOtp): $response");
    debugPrint("=================================================");

    return ResendPasswordResetOtpResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }

  @override
  Future<ResetPasswordResponseModel> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.resendPasswordResetOtp ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.resendPasswordResetOtp} | data: {email: $email}",
    );

    final response = await apiConsumer.post(
      EndPoints.resetPassword,
      data: {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    debugPrint("← response (resendPasswordResetOtp): $response");
    debugPrint("=================================================");

    return ResetPasswordResponseModel.fromJson(
      response as Map<String, dynamic>,
    );
  }

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.login ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.resendPasswordResetOtp} | data: {email: $email}",
    );

    final response = await apiConsumer.post(
      EndPoints.loginCitizen,
      data: {"email": email, "password": password},
    );

    debugPrint("← response (login): $response");
    debugPrint("=================================================");

    return LoginResponseModel.fromJson(response as Map<String, dynamic>);
  }


  @override
  Future<LogoutREsponseModel> logout() async {
    debugPrint(
      "============ AuthRemoteDataSourceImpl.logout ============",
    );
    debugPrint(
      "→ endpoint: ${EndPoints.logout} ",
    );

    final response = await apiConsumer.get(
      EndPoints.logout,
    );

    debugPrint("← response (logout): $response");
    debugPrint("=================================================");

    return LogoutREsponseModel.fromJson(response as Map<String, dynamic>);
  }




}
