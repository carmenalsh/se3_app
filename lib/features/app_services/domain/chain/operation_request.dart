import 'package:complaints_app/core/enums/operation_type.dart';

class OperationRequest {
  final OperationType type;

  final int? fromAccountId;
  final String name;
  final String amount;
  final String toAccountNumber;

  // scheduled
  final String? scheduledType; // مثل Withdraw/Deposit/Transfer أو أي قيمة عندك
  final String? scheduledAt;   // التاريخ

  OperationRequest({
    required this.type,
    required this.fromAccountId,
    required this.name,
    required this.amount,
    required this.toAccountNumber,
    this.scheduledType,
    this.scheduledAt,
  });
}
