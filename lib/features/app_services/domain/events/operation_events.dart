import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/events/app_event.dart';

class OperationSucceeded extends AppEvent {
  final OperationType type;
  final String message;

  const OperationSucceeded({required this.type, required this.message});
}

class OperationFailed extends AppEvent {
  final OperationType type;
  final String message;

  const OperationFailed({required this.type, required this.message});
}
