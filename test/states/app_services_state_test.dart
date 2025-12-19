import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('copyWith يغيّر الحقول المطلوبة فقط', () {
    const s0 = AppServicesState();

    final s1 = s0.copyWith(
      status: AppServicesStatus.loading,
      isSubmitting: true,
      message: 'msg',
      operationNameChanged: 'op',
      amountChanged: '10',
      transferSuccess: true,
      didChange: true,
    );

    expect(s1.status, AppServicesStatus.loading);
    expect(s1.isSubmitting, true);
    expect(s1.message, 'msg');
    expect(s1.operationNameChanged, 'op');
    expect(s1.amountChanged, '10');
    expect(s1.transferSuccess, true);
    expect(s1.didChange, true);

    // وتأكد الباقي ما تغير
    expect(s1.accountsForSelect, isEmpty);
    expect(s1.depositSuccess, false);
    expect(s1.withdrawSuccess, false);
    expect(s1.scheduledSuccess, false);
  });

  test('copyWith مع clearMessage=true يمسح message', () {
    const s0 = AppServicesState(message: 'hello');

    final s1 = s0.copyWith(clearMessage: true);

    expect(s1.message, isNull);
  });
}
