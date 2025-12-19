
import 'package:complaints_app/features/account_manag/domain/entities/update_account_result_entity.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:complaints_app/features/app_services/domain/entities/deposit_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/scheduled_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/transfer_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/withdraw_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/scheduled_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:complaints_app/features/create_account/domain/enities/create_account_entity.dart';
import 'package:complaints_app/features/create_account/domain/use_case/params/create_account_params.dart';

UpdateAccountParams tUpdateAccountParams() => UpdateAccountParams(
  accountId: 4,
  name: 'اي شي',
  status: 'نشط',
  description: 'اي شي تي شي اي ',
);

UpdateAccountResultEntity tUpdateAccountResult() =>
    UpdateAccountResultEntity(successMessage: 'نجاح التعديل');

CreateAccountParams tCreateAccountParams() => CreateAccountParams(
  name: 'اسم الحساب الجديد',
  accountType: 'توفير',
  initialAmount: '233',
  description: 'عم انشئ حساب جديد ',
);

CreateAccountEntity tCreateAccountEntity() =>
    CreateAccountEntity(successMessage: 'نجاح انشاء حساب');

DepositParams tDepositParams() =>
    DepositParams(accountId: 3, name: 'ايداع', amount: '1');

DepositResultEntity tDepositResult() => DepositResultEntity(successMessage: 'تم الايداع');

WithdrawParams tWithdrawParams() =>
    WithdrawParams(accountId: 3, name: 'سحب', amount: '1');

WithdrawResultEntity tWithdrawResult() =>
    WithdrawResultEntity(successMessage: 'تم السحب');

TransferParams tTransferParams() => TransferParams(
  accountId: 3,
  name: 'تحويل',
  amount: '1',
  toAccountNumber: '1',
);

TransferResultEntity tTransferResult() =>
    TransferResultEntity(successMessage: 'تم التحويل');

ScheduledParams tScheduledParams() => ScheduledParams(
  accountId: 3,
  type: 'جدولة',
  amount: '2',
  scheduledAt: '2025-12-19 17:50:00',
  name: 'جدولة',
);

ScheduledResultEntity tScheduledResult() =>
    ScheduledResultEntity(successMessage: 'تمت الجدولة', statusCode: 200);
