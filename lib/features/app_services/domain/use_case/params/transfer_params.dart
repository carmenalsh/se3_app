class TransferParams {
  final int accountId; // from account
  final String name;
  final String amount;
  final String toAccountNumber; // input field

  const TransferParams({
    required this.accountId,
    required this.name,
    required this.amount,
    required this.toAccountNumber,
  });

  Map<String, dynamic> toMap() => {
        "account_id": accountId,
        "name": name,
        "amount": amount,
        "to_account_number": toAccountNumber,
      };
}
