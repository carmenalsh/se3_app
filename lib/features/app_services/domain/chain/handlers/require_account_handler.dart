import '../operation_handler.dart';
import '../operation_request.dart';
import '../operation_result.dart';

class RequireAccountHandler extends OperationHandler {
  @override
  OperationResult check(OperationRequest req) {
    if (req.fromAccountId == null) {
      return const OperationResult.fail("اختر الحساب");
    }
    return const OperationResult.ok();
  }
}
