import 'package:complaints_app/features/home/domain/entities/pagination_meta_entity.dart';

class PaginationMetaModel {
  final int currentPage;
  final int perPage;
  final int total;
  final int lastPage;

  const PaginationMetaModel({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.lastPage,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      lastPage: (json['last_page'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'per_page': perPage,
        'total': total,
        'last_page': lastPage,
      };

  PaginationMetaEntity toEntity() => PaginationMetaEntity(
        currentPage: currentPage,
        perPage: perPage,
        total: total,
        lastPage: lastPage,
      );
}
