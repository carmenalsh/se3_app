import 'package:equatable/equatable.dart';

class ScheduledParams extends Equatable {
  final int accountId;
  final String type; // "سحب" أو "إيداع"
  final String amount;
  final String scheduledAt; // yyyy-mm-dd hh:mm:ss
  final String name;

  const ScheduledParams({
    required this.accountId,
    required this.type,
    required this.amount,
    required this.scheduledAt,
    required this.name,
  });

  @override
  List<Object?> get props => [accountId, type, amount, scheduledAt, name];
}
