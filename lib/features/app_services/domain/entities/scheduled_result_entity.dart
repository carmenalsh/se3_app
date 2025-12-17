import 'package:equatable/equatable.dart';

class ScheduledResultEntity extends Equatable {
  final String successMessage;
  final int statusCode;

  const ScheduledResultEntity({
    required this.successMessage,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [successMessage, statusCode];
}
