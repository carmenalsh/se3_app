import 'package:complaints_app/core/enums/operation_type.dart';
import 'operation_strategy.dart';
import 'deposit_strategy.dart';
import 'withdraw_strategy.dart';
import 'transfer_strategy.dart';

class OperationStrategyFactory {
  static OperationStrategy create(OperationType type) {
    switch (type) {
      case OperationType.deposit:
        return DepositStrategy();

      case OperationType.withdraw:
        return WithdrawStrategy();

      case OperationType.transfer:
        return TransferStrategy();

      default:
        // لأن enum عندك فيه قيم زيادة مثل editAccount / scheduled ...
        throw UnimplementedError('No strategy implemented for $type');
    }
  }
}
