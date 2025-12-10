import '../../domain/entities/complaint_entity.dart';

class ComplaintModel {
  final int id;
  final String title;
  final String description;
  final int number;
  final String currentStatus;
  final DateTime createdAt;

  const ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    required this.number,
    required this.currentStatus,
    required this.createdAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      number: json['number'] as int,
      currentStatus: json['current_status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  ComplaintEntity toEntity() {
    return ComplaintEntity(
      id: id,
      title: title,
      description: description,
      number: number,
      currentStatus: currentStatus,
      createdAt: createdAt,
    );
  }
}
