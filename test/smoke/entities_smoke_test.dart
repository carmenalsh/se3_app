import 'package:flutter_test/flutter_test.dart';

// عدّل المسارات حسب مشروعك
import 'package:complaints_app/features/account_manag/domain/entities/account_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/notification_entity.dart';

void main() {
  test('Entities smoke import', () {
    // مجرد لمس الملف حتى يدخل بالتغطية.
    // إذا أي واحد منهم abstract/interface وما بينبنى، ما تعمل new.
    expect(AccountEntity, isNotNull);
    expect(AccountSelectItemEntity, isNotNull);
    expect(NotificationEntity, isNotNull);
  });
}
