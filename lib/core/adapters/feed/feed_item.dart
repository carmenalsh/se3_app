enum FeedItemKind { transaction, notification, account }

class FeedItem {
  final String id;
  final FeedItemKind kind;

  final String title;
  final String subtitle;
  final String dateText;

  final String? amountText;
  final String? typeText; 
  final String? fromAccountNumber;
  final String? toAccountNumber;

  final String? accountNumber;
  final String? statusText;
  final String? description;

  const FeedItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.dateText,
    this.amountText,
    this.typeText,
    this.fromAccountNumber,
    this.toAccountNumber,
    this.accountNumber,
    this.statusText,
    this.description,
  });
}
