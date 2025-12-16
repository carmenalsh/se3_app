class DepositParams {
  final int accountId;
  final String name;
  final String amount;

  const DepositParams({
    required this.accountId,
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toMap() => {
        'account_id': accountId,
        'name': name,
        'amount': amount,
      };
}
