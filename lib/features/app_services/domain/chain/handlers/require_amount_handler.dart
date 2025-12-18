import '../operation_handler.dart';
import '../operation_request.dart';
import '../operation_result.dart';

class RequireAmountHandler extends OperationHandler {
  @override
  OperationResult check(OperationRequest req) {
    if (req.amount.trim().isEmpty) {
      return const OperationResult.fail("ادخل المبلغ");
    }
    return const OperationResult.ok();
  }
}
