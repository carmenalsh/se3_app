import 'package:complaints_app/features/home/domain/entities/transaction_entity.dart';

class TransactionModel {
  final int transactionId;
  final String name;
  final String? fromAccountNumber;
  final String? toAccountNumber;
  final String amount;
  final String type;
  final String executedAt;

  const TransactionModel({
    required this.transactionId,
    required this.name,
    required this.fromAccountNumber,
    required this.toAccountNumber,
    required this.amount,
    required this.type,
    required this.executedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: (json['transaction_id'] as num).toInt(),
      name: (json['name'] ?? '') as String,
      fromAccountNumber: json['from_account_number'] as String?,
      toAccountNumber: json['to_account_number'] as String?,
      amount: (json['amount'] ?? '') as String,
      type: (json['type'] ?? '') as String,
      executedAt: (json['executed_at'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'transaction_id': transactionId,
        'name': name,
        'from_account_number': fromAccountNumber,
        'to_account_number': toAccountNumber,
        'amount': amount,
        'type': type,
        'executed_at': executedAt,
      };

  TransactionEntity toEntity() => TransactionEntity(
        transactionId: transactionId,
        name: name,
        fromAccountNumber: fromAccountNumber,
        toAccountNumber: toAccountNumber,
        amount: amount,
        type: type,
        executedAt: executedAt,
      );
}
