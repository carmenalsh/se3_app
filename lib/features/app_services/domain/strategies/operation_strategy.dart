import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';

/// نتيجة التحقق (بدون رمي Exceptions)
class StrategyValidationResult {
  final bool isValid;
  final String? message;

  const StrategyValidationResult.valid() : isValid = true, message = null;
  const StrategyValidationResult.invalid(this.message) : isValid = false;
}

/// Context: بيعطي الاستراتيجية كل ما تحتاجه من الـ Cubit state
class OperationContext {
  final AppServicesState state;

  const OperationContext(this.state);

  int? get fromAccountId => state.selectedFromAccountId;
  String get name => state.operationNameChanged.trim();
  String get amount => state.amountChanged.trim();
  String get toAccountNumber => state.toAccountNumberChanged.trim();
}

/// Strategy Interface
abstract class OperationStrategy {
  OperationType get type;

  /// تحقق من المدخلات قبل استدعاء الـ API
  StrategyValidationResult validate(OperationContext ctx);

  /// تنفيذ العملية (يرجع Either داخل الـ Cubit عبر تمرير execute callback)
  Future<void> execute({
    required OperationContext ctx,
    required Future<void> Function() runUseCase, // الـ Cubit رح يمررها
  });
}

