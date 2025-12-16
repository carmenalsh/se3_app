class CreateAccountParams {
  final String name;
  final String accountType;
  final String initialAmount;
  final String description;

  const CreateAccountParams({
    required this.name,
    required this.accountType,
    required this.initialAmount,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'account_type': accountType,
    'description': description,
    'initial_amount': initialAmount,
  };
}
