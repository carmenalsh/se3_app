import 'pagination_meta_entity.dart';
import 'transaction_entity.dart';

class TransactionPageEntity {
  final List<TransactionEntity> transAction;
  final PaginationMetaEntity meta;

  const TransactionPageEntity({
    required this.transAction,
    required this.meta,
  });
}
