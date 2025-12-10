part of 'logout_cubit.dart';

enum LogoutStatusEnum { initial, loading, success, error }

class LogoutState {
  final LogoutStatusEnum status;
  final String? message;

  const LogoutState({this.status = LogoutStatusEnum.initial, this.message});

  LogoutState copyWith({LogoutStatusEnum? status, String? message}) {
    return LogoutState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
