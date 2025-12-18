import 'package:complaints_app/core/enums/operation_type.dart';
import '../operation_handler.dart';
import '../operation_request.dart';
import '../operation_result.dart';

class RequireScheduledFieldsHandler extends OperationHandler {
  @override
  OperationResult check(OperationRequest req) {
    if (req.type != OperationType.scheduled) return const OperationResult.ok();

    if ((req.scheduledType ?? '').trim().isEmpty) {
      return const OperationResult.fail("اختر نوع المعاملة للجدولة");
    }
    if ((req.scheduledAt ?? '').trim().isEmpty) {
      return const OperationResult.fail("اختر تاريخ الجدولة");
    }
    return const OperationResult.ok();
  }
}
