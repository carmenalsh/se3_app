import 'package:complaints_app/features/app_services/domain/entities/notification_entity.dart';
import 'feed_item.dart';

class NotificationToFeedAdapter {
  static FeedItem adapt(NotificationEntity n) {
    return FeedItem(
      id: n.id,
      kind: FeedItemKind.notification,
      title: n.title,
      subtitle: n.body,
      dateText: n.date,
    );
  }
}
