class UpdateAccountParams {
  final int accountId;
  final String name;
  final String status;
  final String description;

  const UpdateAccountParams({
    required this.accountId,
    required this.name,
    required this.status,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
        'account_id': accountId,
        'name': name,
        'status': status,
        'description': description,
      };
}
