import '../../domain/entities/complaint_entity.dart';

class SearchComplaintModel {
  final int complaintNumber;
  final String title;
  final String description;
  final String status;

  const SearchComplaintModel({
    required this.complaintNumber,
    required this.title,
    required this.description,
    required this.status,
  });

  factory SearchComplaintModel.fromJson(Map<String, dynamic> json) {
    return SearchComplaintModel(
      complaintNumber: json['complaint_number'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }

  ComplaintEntity toEntity() {
    return ComplaintEntity(
      id: complaintNumber,
      title: title,
      description: description,
      number: complaintNumber,
      currentStatus: status,
      createdAt: DateTime.now(), 
    );
  }
}
