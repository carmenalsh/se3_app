import '../operation_handler.dart';
import '../operation_request.dart';
import '../operation_result.dart';

class RequireNameHandler extends OperationHandler {
  @override
  OperationResult check(OperationRequest req) {
    if (req.name.trim().isEmpty) {
      return const OperationResult.fail("اكتب عنوان العملية");
    }
    return const OperationResult.ok();
  }
}
