import 'package:flutter_test/flutter_test.dart';

import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/features/app_services/domain/strategies/withdraw_strategy.dart';
import 'package:complaints_app/features/app_services/domain/strategies/operation_strategy.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';

void main() {
  group('WithdrawStrategy', () {
    test('type يجب أن يكون withdraw', () {
      final strategy = WithdrawStrategy();
      expect(strategy.type, OperationType.withdraw);
    });

    test('validate يرجع invalid إذا fromAccountId null', () {
      final strategy = WithdrawStrategy();

      const state = AppServicesState(
        selectedFromAccountId: null,
        operationNameChanged: 'سحب',
        amountChanged: '10',
      );
      final ctx = OperationContext(state);

      final result = strategy.validate(ctx);

      expect(result.isValid, false);
      expect(result.message, 'اختر الحساب');
    });

    test('validate يرجع invalid إذا name فاضي', () {
      final strategy = WithdrawStrategy();

      const state = AppServicesState(
        selectedFromAccountId: 1,
        operationNameChanged: '',
        amountChanged: '10',
      );
      final ctx = OperationContext(state);

      final result = strategy.validate(ctx);

      expect(result.isValid, false);
      expect(result.message, 'اكتب عنوان العملية');
    });

    test('validate يرجع invalid إذا amount فاضي', () {
      final strategy = WithdrawStrategy();

      const state = AppServicesState(
        selectedFromAccountId: 1,
        operationNameChanged: 'سحب',
        amountChanged: '',
      );
      final ctx = OperationContext(state);

      final result = strategy.validate(ctx);

      expect(result.isValid, false);
      expect(result.message, 'ادخل المبلغ');
    });

    test('validate يرجع valid إذا كل شيء موجود', () {
      final strategy = WithdrawStrategy();

      const state = AppServicesState(
        selectedFromAccountId: 1,
        operationNameChanged: 'سحب',
        amountChanged: '10',
      );
      final ctx = OperationContext(state);

      final result = strategy.validate(ctx);

      expect(result.isValid, true);
      expect(result.message, isNull);
    });

    test('execute ينادي runUseCase مرة واحدة', () async {
      final strategy = WithdrawStrategy();

      const state = AppServicesState(
        selectedFromAccountId: 1,
        operationNameChanged: 'سحب',
        amountChanged: '10',
      );
      final ctx = OperationContext(state);

      var called = 0;

      await strategy.execute(
        ctx: ctx,
        runUseCase: () async {
          called++;
        },
      );

      expect(called, 1);
    });
  });
}
