
import 'package:complaints_app/features/home/domain/entities/transaction_page_entity.dart';

import 'pagination_meta_model.dart';
import 'transaction_model.dart';

class TransactionPageModel {
  final List<TransactionModel> data;
  final PaginationMetaModel meta;

  const TransactionPageModel({
    required this.data,
    required this.meta,
  });

  factory TransactionPageModel.fromJson(Map<String, dynamic> json) {
    final list = (json['data'] as List<dynamic>? ?? [])
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final metaJson = (json['meta'] as Map<String, dynamic>? ?? {});

    return TransactionPageModel(
      data: list,
      meta: PaginationMetaModel.fromJson(metaJson),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
        'meta': meta.toJson(),
      };

  TransactionPageEntity toEntity() => TransactionPageEntity(
        transAction: data.map((e) => e.toEntity()).toList(),
        meta: meta.toEntity(),
      );
}
