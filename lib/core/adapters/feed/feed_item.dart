enum FeedItemKind { transaction, notification, account }

class FeedItem {
  final String id;
  final FeedItemKind kind;

  // مشترك
  final String title;
  final String subtitle;
  final String dateText;

  // للمعاملات (اختياري)
  final String? amountText;
  final String? typeText; // deposit/withdraw/transfer أو النص العربي اللي عندك
  final String? fromAccountNumber;
  final String? toAccountNumber;

  // للحسابات (اختياري)
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
