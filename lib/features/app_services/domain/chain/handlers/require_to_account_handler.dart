import 'package:complaints_app/core/enums/operation_type.dart';
import '../operation_handler.dart';
import '../operation_request.dart';
import '../operation_result.dart';

class RequireToAccountHandler extends OperationHandler {
  @override
  OperationResult check(OperationRequest req) {
    if (req.type == OperationType.transfer &&
        req.toAccountNumber.trim().isEmpty) {
      return const OperationResult.fail("ادخل رقم الحساب المستقبِل");
    }
    return const OperationResult.ok();
  }
}
