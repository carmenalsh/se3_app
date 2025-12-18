import 'package:complaints_app/features/home/domain/entities/transaction_entity.dart';
import 'feed_item.dart';

class TransactionToFeedAdapter {
  static FeedItem adapt(TransactionEntity t) {
    // subtitle للعرض فقط (معلومة لطيفة)، بس ما عاد نعتمد عليه لاستخراج الحسابات
    final parts = <String>[];
    if (t.fromAccountNumber != null && t.fromAccountNumber!.isNotEmpty) {
      parts.add("من: ${t.fromAccountNumber}");
    }
    if (t.toAccountNumber != null && t.toAccountNumber!.isNotEmpty) {
      parts.add("إلى: ${t.toAccountNumber}");
    }
    final subtitle = parts.isEmpty ? "عملية مالية" : parts.join("  •  ");

    return FeedItem(
      id: t.transactionId.toString(),
      kind: FeedItemKind.transaction,

      title: t.name,
      subtitle: subtitle,
      dateText: t.executedAt,

      amountText: t.amount,
      typeText: t.type, // نفس اللي جاي من الباك (deposit|withdraw|transfer) أو النص اللي عندك
      fromAccountNumber: t.fromAccountNumber,
      toAccountNumber: t.toAccountNumber,
    );
  }
}
