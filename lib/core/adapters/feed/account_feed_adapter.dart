import 'feed_item.dart';

import 'package:complaints_app/features/account_manag/domain/entities/account_entity.dart';

class AccountToFeedAdapter {
  static FeedItem adapt(AccountEntity acc) {
    return FeedItem(
      id: acc.accountNumber, 
      kind: FeedItemKind.account,
      title: acc.name,
      subtitle: "${acc.balance} ألف ليرة سورية",
      dateText: acc.createdAt,

      accountNumber: acc.accountNumber,
      statusText: acc.status,       
      typeText: acc.type,          
      description: acc.description,
    );
  }
}
