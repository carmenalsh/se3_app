import '../../domain/entities/scheduled_result_entity.dart';

class ScheduledResultModel extends ScheduledResultEntity {
  const ScheduledResultModel({
    required super.successMessage,
    required super.statusCode,
  });

  factory ScheduledResultModel.fromJson(Map<String, dynamic> json) {
    return ScheduledResultModel(
      successMessage: (json['successMessage'] ?? '').toString(),
      statusCode: (json['statusCode'] ?? 0) is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode'].toString()) ?? 0,
    );
  }
}
