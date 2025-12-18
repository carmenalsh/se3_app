import 'package:complaints_app/core/enums/operation_type.dart';

import 'operation_strategy.dart';

class TransferStrategy implements OperationStrategy {
  @override
  OperationType get type => OperationType.transfer;

  @override
  StrategyValidationResult validate(OperationContext ctx) {
    if (ctx.fromAccountId == null) {
      return const StrategyValidationResult.invalid("اختر الحساب");
    }
    if (ctx.name.isEmpty) {
      return const StrategyValidationResult.invalid("اكتب عنوان العملية");
    }
    if (ctx.amount.isEmpty) {
      return const StrategyValidationResult.invalid("ادخل المبلغ");
    }
    if (ctx.toAccountNumber.isEmpty) {
      return const StrategyValidationResult.invalid("ادخل رقم الحساب المستقبِل");
    }
    return const StrategyValidationResult.valid();
  }

  @override
  Future<void> execute({
    required OperationContext ctx,
    required Future<void> Function() runUseCase,
  }) async {
    await runUseCase();
  }
}
