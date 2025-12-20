import 'package:complaints_app/core/enums/operation_type.dart';

import 'operation_handler.dart';
import 'handlers/require_account_handler.dart';
import 'handlers/require_name_handler.dart';
import 'handlers/require_amount_handler.dart';
import 'handlers/require_to_account_handler.dart';
import 'handlers/require_scheduled_fields_handler.dart';

class OperationChainFactory {
  static OperationHandler buildFor(OperationType type) {
    //base chain: account-> name-> amount
    final head = RequireAccountHandler();
    OperationHandler tail = head;

    tail = tail.setNext(RequireNameHandler());
    tail = tail.setNext(RequireAmountHandler());

    //transfer: add to-account check
    if (type == OperationType.transfer) {
      tail = tail.setNext(RequireToAccountHandler());
    }

    //scheduled: add scheduled fields check
    if (type == OperationType.scheduled) {
      tail = tail.setNext(RequireScheduledFieldsHandler());
    }

    return head;
  }
}
