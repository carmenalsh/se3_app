import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';


class AccountSelectItemModel {
  final int id;
  final String name;

  const AccountSelectItemModel({
    required this.id,
    required this.name,
  });

  factory AccountSelectItemModel.fromJson(Map<String, dynamic> json) {
    return AccountSelectItemModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] ?? '') as String,
    );
  }

  AccountSelectItemEntity toEntity() => AccountSelectItemEntity(
        id: id,
        name: name,
      );
}
