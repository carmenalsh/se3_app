import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';

class StrategyValidationResult {
  final bool isValid;
  final String? message;

  const StrategyValidationResult.valid() : isValid = true, message = null;
  const StrategyValidationResult.invalid(this.message) : isValid = false;
}

class OperationContext {
  final AppServicesState state;

  const OperationContext(this.state);

  int? get fromAccountId => state.selectedFromAccountId;
  String get name => state.operationNameChanged.trim();
  String get amount => state.amountChanged.trim();
  String get toAccountNumber => state.toAccountNumberChanged.trim();
}

abstract class OperationStrategy {
  OperationType get type;

  StrategyValidationResult validate(OperationContext ctx);


  Future<void> execute({
    required OperationContext ctx,
    required Future<void> Function() runUseCase,
  });
}

