class PaginationMetaEntity {
  final int currentPage;
  final int perPage;
  final int total;
  final int lastPage;

  const PaginationMetaEntity({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.lastPage,
  });
}
