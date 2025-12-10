import 'package:complaints_app/features/home/data/models/complaits_model.dart';
import '../../domain/entities/complaints_page_entity.dart';
import 'pagination_meta_model.dart';

class ComplaintsPageModel {
  final List<ComplaintModel> complaints;
  final PaginationMetaModel meta;

  const ComplaintsPageModel({
    required this.complaints,
    required this.meta,
  });

  factory ComplaintsPageModel.fromJson(Map<String, dynamic> json) {
    final dataList = json['data'] as List<dynamic>;
    final complaints = dataList
        .map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final meta = PaginationMetaModel.fromJson(
      json['meta'] as Map<String, dynamic>,
    );

    return ComplaintsPageModel(complaints: complaints, meta: meta);
  }

  ComplaintsPageEntity toEntity() {
    return ComplaintsPageEntity(
      complaints: complaints.map((c) => c.toEntity()).toList(),
      meta: meta.toEntity(),
    );
  }
}
