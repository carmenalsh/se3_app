import 'feed_item.dart';

// ⚠️ عدّل الاستيراد حسب مكان AccountEntity عندك
import 'package:complaints_app/features/account_manag/domain/entities/account_entity.dart';

class AccountToFeedAdapter {
  static FeedItem adapt(AccountEntity acc) {
    return FeedItem(
      id: acc.accountNumber, // أو acc.id إذا موجود
      kind: FeedItemKind.account,
      title: acc.name,
      subtitle: "${acc.balance} ألف ليرة سورية",
      dateText: acc.createdAt,

      // account extras (اختياري)
      accountNumber: acc.accountNumber,
      statusText: acc.status,       // نشط/مجمد/...
      typeText: acc.type,           // جاري/استثماري/قرض
      description: acc.description,
    );
  }
}
