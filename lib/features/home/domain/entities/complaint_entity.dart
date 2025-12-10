class ComplaintEntity {
  final int id;
  final String title;
  final String description;
  final int number;
  final String currentStatus;
  final DateTime createdAt;

  const ComplaintEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.number,
    required this.currentStatus,
    required this.createdAt,
  });
}
