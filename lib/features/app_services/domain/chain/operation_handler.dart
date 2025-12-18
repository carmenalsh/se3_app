import 'operation_request.dart';
import 'operation_result.dart';

abstract class OperationHandler {
  OperationHandler? _next;

  OperationHandler setNext(OperationHandler next) {
    _next = next;
    return next;
  }

  OperationResult handle(OperationRequest req) {
    final res = check(req);
    if (!res.ok) return res;
    return _next?.handle(req) ?? const OperationResult.ok();
  }

  OperationResult check(OperationRequest req);
}
