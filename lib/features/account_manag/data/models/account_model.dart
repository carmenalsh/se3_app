import '../../domain/entities/account_entity.dart';

class AccountModel {
  final int id;
  final String name;
  final String accountNumber;
  final String description;
  final String type;
  final String status;
  final String balance;
  final String createdAt;

  const AccountModel({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.description,
    required this.type,
    required this.status,
    required this.balance,
    required this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] ?? '') as String,
      accountNumber: (json['account_number'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      type: (json['type'] ?? '') as String,
      status: (json['status'] ?? '') as String,
      balance: (json['balance'] ?? '') as String,
      createdAt: (json['created_at'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'account_number': accountNumber,
        'description': description,
        'type': type,
        'status': status,
        'balance': balance,
        'created_at': createdAt,
      };

  AccountEntity toEntity() => AccountEntity(
        id: id,
        name: name,
        accountNumber: accountNumber,
        description: description,
        type: type,
        status: status,
        balance: balance,
        createdAt: createdAt,
      );
}
