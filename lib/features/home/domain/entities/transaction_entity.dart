class TransactionEntity {
  final int transactionId;
  final String name;
  final String? fromAccountNumber;
  final String? toAccountNumber;
  final String amount;     // جاي من الباك سترينغ "150.00"
  final String type;       // deposit | withdraw | transfer
  final String executedAt; // "منذ 34 دقيقة"

  const TransactionEntity({
    required this.transactionId,
    required this.name,
    required this.fromAccountNumber,
    required this.toAccountNumber,
    required this.amount,
    required this.type,
    required this.executedAt,
  });
}
