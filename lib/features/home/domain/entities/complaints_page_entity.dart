import 'package:complaints_app/features/home/domain/entities/complaint_entity.dart';
import 'package:complaints_app/features/home/domain/entities/pagination_meta_entity.dart';

class ComplaintsPageEntity {
  final List<ComplaintEntity> complaints;
  final PaginationMetaEntity meta;

  const ComplaintsPageEntity({required this.complaints, required this.meta});
}
