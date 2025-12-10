import 'package:complaints_app/core/databases/cache/cache_helper.dart';
import 'package:complaints_app/core/databases/cache/token_storage.dart';
import 'package:complaints_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit({required this.logoutUseCase}) : super(LogoutState()) {
    debugPrint("============ LogoutCubit INIT ============");
  }

  final LogoutUseCase logoutUseCase;

  Future<void> logOutSubmitted() async {
    debugPrint("============ LogoutCubit.logOutSubmitted ============");
    debugPrint(
      "loginSubmitted -> token is: ${TokenStorage.getAccessToken()}, time expiry: ${TokenStorage.getAccessTokenExpiry()}",
    );

    emit(state.copyWith(status: LogoutStatusEnum.loading, message: null));

    final result = await logoutUseCase();

    result.fold(
      (failure) {
        debugPrint("logOutSubmitted -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            status: LogoutStatusEnum.error,
            message: failure.errMessage,
          ),
        );
      },
      (response) {
        debugPrint(
          "logOutSubmitted -> SUCCESS, , statusCode: ${response.statusCode}",
        );

        emit(
          state.copyWith(
            status: LogoutStatusEnum.success,
            message: state.message
          ),
        );
      },
    );

    debugPrint("============ logOutSubmitted.loginSubmitted END ============");
  }
}
