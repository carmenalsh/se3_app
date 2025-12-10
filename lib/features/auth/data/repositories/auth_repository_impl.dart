import 'package:complaints_app/core/databases/cache/token_storage.dart';
import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/core/network/network_info.dart';
import 'package:complaints_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:complaints_app/features/auth/domain/entities/forget_password_email_response.dart';
import 'package:complaints_app/features/auth/domain/entities/login_response.dart';
import 'package:complaints_app/features/auth/domain/entities/logout_response.dart';
import 'package:complaints_app/features/auth/domain/entities/register_response.dart';
import 'package:complaints_app/features/auth/domain/entities/resend_password_reset_otp_response.dart';
import 'package:complaints_app/features/auth/domain/entities/resend_verify_code_response.dart';
import 'package:complaints_app/features/auth/domain/entities/reset_password_response.dart';
import 'package:complaints_app/features/auth/domain/entities/verify_forget_password_response.dart';
import 'package:complaints_app/features/auth/domain/entities/verify_register_response.dart';
import 'package:complaints_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    required String nationalNumber,
  }) async {
    debugPrint("============ AuthRepositoryImpl.register ============");
    debugPrint(
      "→ params: {name: $name, email: $email, nationalNumber: $nationalNumber}",
    );

    // final isConnected = await networkInfo.isConnected;
    // if (!isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.register -> no internet");
    //   return Left(ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'));
    // }

    try {
      debugPrint("→ calling remoteDataSource.register");
      final model = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        nationalNumber: nationalNumber,
      );

      final entity = model.toEntity();
      debugPrint("← remoteDataSource.register success, mapped to entity");
      debugPrint("=================================================");

      return Right(entity);
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.register ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.register CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ AuthRepositoryImpl.register Unexpected error: $e");
      debugPrint("=================================================");
      return Left(
        ServerFailure(errMessage: ' at auth repo impl حدث خطأ غير متوقع'),
      );
    }
  }

  @override
  Future<Either<Failure, ResendVerifyCodeResponse>> resendVerifyCode({
    required String email,
  }) async {
    debugPrint("============ AuthRepositoryImpl.resendVerifyCode ============");
    debugPrint("→ params: {email: $email}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.resendVerifyCode -> no internet");
    //   return Left(ConnectionFailure(errMessage: 'تحقق من اتصال الإنترنت'));
    // }

    try {
      debugPrint("→ calling remoteDataSource.resendVerifyCode");
      final model = await remoteDataSource.resendVerifyCode(email: email);

      final entity = model.toEntity();
      debugPrint(
        "← remoteDataSource.resendVerifyCode success, mapped to entity",
      );
      debugPrint("=================================================");

      return Right(entity);
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resendVerifyCode ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resendVerifyCode CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ AuthRepositoryImpl.resendVerifyCode Unexpected error: $e");
      debugPrint("=================================================");
      return Left(
        ServerFailure(errMessage: ' at auth repo impl حدث خطأ غير متوقع'),
      );
    }
  }

  @override
  Future<Either<Failure, VerifyRegisterResponse>> verifyRegisterCode({
    required String email,
    required String code,
  }) async {
    debugPrint(
      "============ AuthRepositoryImpl.verifyRegisterCode ============",
    );
    debugPrint("→ params: {email: $email, code: $code}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.verifyRegisterCode -> no internet");
    //   return Left(ConnectionFailure(errMessage: 'تحقق من اتصال الإنترنت'));
    // }

    try {
      debugPrint("→ calling remoteDataSource.verifyRegisterCode");
      final model = await remoteDataSource.verifyRegisterCode(
        email: email,
        code: code,
      );

      debugPrint(
        "← remoteDataSource.verifyRegisterCode success, mapped to entity",
      );
      debugPrint("=================================================");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.verifyRegisterCode ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.verifyRegisterCode CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.verifyRegisterCode Unexpected error: $e",
      );
      debugPrint("=================================================");
      return Left(
        ServerFailure(errMessage: ' at auth repo impl حدث خطأ غير متوقع'),
      );
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordEmailResponse>> sendForgetPasswordEmail({
    required String email,
  }) async {
    debugPrint(
      "============ AuthRepositoryImpl.sendForgetPasswordEmail ============",
    );
    debugPrint("→ params: {email: $email}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.sendForgetPasswordEmail -> no internet");
    //   return Left(ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'));
    // }

    try {
      debugPrint("→ calling remoteDataSource.sendForgetPasswordEmail");
      final model = await remoteDataSource.sendForgetPasswordEmail(
        email: email,
      );

      debugPrint(
        "← remoteDataSource.sendForgetPasswordEmail success, mapped to entity",
      );
      debugPrint("=================================================");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.sendForgetPasswordEmail ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.sendForgetPasswordEmail CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.sendForgetPasswordEmail Unexpected error: $e",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, VerifyForgetPasswordResponse>>
  verifyForgetPasswordOtp({
    required String email,
    required String otpCode,
  }) async {
    debugPrint(
      "============ AuthRepositoryImpl.verifyForgetPasswordOtp ============",
    );
    debugPrint("→ params: {email: $email, otpCode: $otpCode}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.verifyForgetPasswordOtp -> no internet");
    //   return Left(
    //     ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
    //   );
    // }

    try {
      debugPrint("→ calling remoteDataSource.verifyForgotPasswordOtp");
      final model = await remoteDataSource.verifyForgotPasswordOtp(
        email: email,
        otpCode: otpCode,
      );

      debugPrint(
        "← remoteDataSource.verifyForgotPasswordOtp success, mapped to entity",
      );
      debugPrint("=================================================");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.verifyForgetPasswordOtp ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.verifyForgetPasswordOtp CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.verifyForgetPasswordOtp Unexpected error: $e",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, ResendPasswordResetOtpResponse>>
  resendPasswordResetOtp({required String email}) async {
    debugPrint(
      "============ AuthRepositoryImpl.resendPasswordResetOtp ============",
    );
    debugPrint("→ params: {email: $email}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.resendPasswordResetOtp -> no internet");
    //   return Left(
    //     ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
    //   );
    // }

    try {
      debugPrint("→ calling remoteDataSource.resendPasswordResetOtp");
      final model = await remoteDataSource.resendPasswordResetOtp(email: email);

      debugPrint(
        "← remoteDataSource.resendPasswordResetOtp success, mapped to entity",
      );
      debugPrint("=================================================");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resendPasswordResetOtp ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resendPasswordResetOtp CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resendPasswordResetOtp Unexpected error: $e",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    debugPrint("============ AuthRepositoryImpl.resetPassword ============");
    debugPrint("→ params: {email: $email}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.resendPasswordResetOtp -> no internet");
    //   return Left(
    //     ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
    //   );
    // }

    try {
      debugPrint("→ calling remoteDataSource.resetPassword");
      final model = await remoteDataSource.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      debugPrint("← remoteDataSource.resetPassword success, mapped to entity");
      debugPrint("=================================================");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resetPassword ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.resetPassword CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ AuthRepositoryImpl.resetPassword Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    debugPrint("============ AuthRepositoryImpl.login ============");
    debugPrint("→ params: {email: $email}");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.resendPasswordResetOtp -> no internet");
    //   return Left(
    //     ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
    //   );
    // }

    try {
      debugPrint("→ calling remoteDataSource.login");
      final model = await remoteDataSource.login(
        email: email,
        password: password,
      );

      debugPrint("← remoteDataSource.login success, mapped to entity");
      debugPrint("=================================================");
      await TokenStorage.saveAccessToken(
        token: model.token,
        expiresInSeconds: model.expiresIn,
      );
      debugPrint("token issssss  : ${TokenStorage.getAccessToken()}");
      debugPrint("expiry issssss  : ${TokenStorage.getAccessTokenExpiry()}");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.login ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.login CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ AuthRepositoryImpl.login Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }



    @override
  Future<Either<Failure, LogoutResponse>> logout() async {
    debugPrint("============ AuthRepositoryImpl.logout ============");

    // if (!await networkInfo.isConnected) {
    //   debugPrint("✗ AuthRepositoryImpl.resendPasswordResetOtp -> no internet");
    //   return Left(
    //     ConnectionFailure(errMessage: 'تحقق من اتصالك بالإنترنت'),
    //   );
    // }

    try {
      debugPrint("→ calling remoteDataSource.logout");
      final model = await remoteDataSource.logout();

      debugPrint("← remoteDataSource.logout success, mapped to entity");
      debugPrint("=================================================");
      await TokenStorage.clear();
      debugPrint("token issssss  : ${TokenStorage.getAccessToken()}");
      debugPrint("expiry issssss  : ${TokenStorage.getAccessTokenExpiry()}");

      return Right(model.toEntity());
    } on ServerException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.logout ServerException: ${e.errorModel.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } on CacheException catch (e) {
      debugPrint(
        "✗ AuthRepositoryImpl.logout CacheException: ${e.errorMessage}",
      );
      debugPrint("=================================================");
      return Left(CacheFailure(errMessage: e.errorMessage));
    } catch (e) {
      debugPrint("✗ AuthRepositoryImpl.logout Unexpected error: $e");
      debugPrint("=================================================");
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }


}
