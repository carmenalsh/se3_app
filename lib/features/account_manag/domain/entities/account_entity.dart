class AccountEntity {
  final int id;
  final String name;
  final String accountNumber;
  final String description;
  final String type;
  final String status;
  final String balance;
  final String createdAt;

  const AccountEntity({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.description,
    required this.type,
    required this.status,
    required this.balance,
    required this.createdAt,
  });
}
