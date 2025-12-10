import '../../domain/entities/pagination_meta_entity.dart';

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
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
      total: json['total'] as int,
      lastPage: json['last_page'] as int,
    );
  }

  PaginationMetaEntity toEntity() {
    return PaginationMetaEntity(
      currentPage: currentPage,
      perPage: perPage,
      total: total,
      lastPage: lastPage,
    );
  }
}
