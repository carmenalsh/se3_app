import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/events/app_event_bus.dart';
import 'package:complaints_app/features/app_services/domain/events/operation_events.dart';
import 'package:complaints_app/features/app_services/domain/strategies/operation_strategy.dart';
import 'package:complaints_app/features/app_services/domain/strategies/operation_strategy_factory.dart';
import 'package:complaints_app/features/app_services/domain/use_case/deposit_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/get_accounts_for_select_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/notification_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/deposit_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/scheduled_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/transfer_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/withdraw_params.dart';
import 'package:complaints_app/features/app_services/domain/use_case/scheduled_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/transfer_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/withdraw_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_services_state.dart';

class AppServicesCubit extends Cubit<AppServicesState> {
  final GetAccountsForSelectUseCase getAccountsForSelectUseCase;
  final WithdrawUseCase withdrawUseCase;
  final DepositUseCase depositUseCase;
  final TransferUseCase transferUseCase;
  final ScheduledUseCase scheduledUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  AppServicesCubit({
    required this.getAccountsForSelectUseCase,
    required this.withdrawUseCase,
    required this.depositUseCase,
    required this.transferUseCase,
    required this.scheduledUseCase,
    required this.getNotificationsUseCase,
  }) : super(const AppServicesState());

  Future<void> loadAccountsForSelect() async {
    debugPrint(
      "============ AppServicesCubit.loadAccountsForSelect ============",
    );

    if (state.accountsForSelect.isNotEmpty) {
      debugPrint("Æ’o: accountsForSelect already loaded, skip fetch");
      debugPrint("=================================================");
      return;
    }

    emit(
      state.copyWith(
        status: AppServicesStatus.loading,
        isSubmitting: true,
        clearMessage: true,
      ),
    );

    final result = await getAccountsForSelectUseCase.call();

    result.fold(
      (failure) {
        debugPrint("Æ’o- loadAccountsForSelect failed: ${failure.errMessage}");
        emit(
          state.copyWith(
            status: AppServicesStatus.error,
            isSubmitting: false,
            message: failure.errMessage,
          ),
        );
      },
      (accounts) {
        debugPrint(
          "Æ’o: loadAccountsForSelect success: ${accounts.length} items",
        );
        emit(
          state.copyWith(
            status: AppServicesStatus.success,
            accountsForSelect: accounts,
            isSubmitting: false,
          ),
        );
      },
    );

    debugPrint("=================================================");
  }

  Future<void> submitWithdraw() => submitOperation(OperationType.withdraw);
  Future<void> submitDeposit() => submitOperation(OperationType.deposit);
  Future<void> submitTransfer() => submitOperation(OperationType.transfer);

  Future<void> loadNotifications() async {
    debugPrint("============ HomeCubit.loadNotifications ============");

    emit(
      state.copyWith(
        isNotificationsLoading: true,
        notificationsErrorMessage: null,
      ),
    );

    final result = await getNotificationsUseCase();

    result.fold(
      (failure) {
        debugPrint("loadNotifications -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isNotificationsLoading: false,
            notificationsErrorMessage: failure.errMessage,
          ),
        );
      },
      (list) {
        debugPrint("loadNotifications -> SUCCESS, count: ${list.length}");
        emit(
          state.copyWith(isNotificationsLoading: false, notifications: list),
        );
      },
    );
  }

  Future<void> submitScheduled() async {
    debugPrint("============ AppServicesCubit.submitScheduled ============");

    if (state.isSubmitting) return;
    final fromAccountId = state.selectedFromAccountId;
    final selectedOperationType = state.selectedOperationType;
    final selectedDate = state.sectectDate;
    final amount = state.amountChanged.trim();
    final name = state.operationNameChanged.trim();
    if (fromAccountId == null) {
      emit(
        state.copyWith(message: 'O15OrO¦Oñ O15U,O-O3O15O', clearMessage: false),
      );
      return;
    }
    if (name.isEmpty) {
      emit(
        state.copyWith(
          message: 'O15UŸO¦O O1U+U^O15U+ O15U,O1U.U,USOc',
          clearMessage: false,
        ),
      );
      return;
    }
    if (amount.isEmpty) {
      emit(
        state.copyWith(message: 'O15O_OrU, O15U,U.OU,O§', clearMessage: false),
      );
      return;
    }
    if (selectedOperationType == null) {
      emit(
        state.copyWith(
          message: "Ø§Ø®ØªØ± Ù†ÙˆØ¹ Ø§Ù„Ø¹Ù…Ù„ÙŠØ©",
          clearMessage: false,
        ),
      );
      return;
    }
    if (selectedDate == null) {
      emit(
        state.copyWith(
          message: "Ø§Ù„Ø±Ø¬Ø§Ø¡ Ø­Ø¯Ø¯ Ø§Ù„ØªØ§Ø±ÙŠØ®",
          clearMessage: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        isSubmitting: true,
        scheduledSuccess: false,
        clearMessage: true,
      ),
    );
    final params = ScheduledParams(
      accountId: fromAccountId,
      type: selectedOperationType,
      amount: amount,
      scheduledAt: selectedDate,
      name: name,
    );
    final result = await scheduledUseCase.call(params);
    result.fold(
      (failure) {
        debugPrint("submitScheduled failed: ${failure.errMessage}");
        emit(state.copyWith(isSubmitting: false, message: failure.errMessage));
        AppEventBus.instance.emit(
          OperationFailed(
            type: OperationType.scheduled,
            message: failure.errMessage,
          ),
        );
      },
      (success) {
        debugPrint("submitScheduled success: ${success.successMessage}");
        emit(
          state.copyWith(
            isSubmitting: false,
            message: success.successMessage,
            scheduledSuccess: true,
            didChange: true,
          ),
        );
        AppEventBus.instance.emit(
          OperationSucceeded(
            type: OperationType.scheduled,
            message: success.successMessage,
          ),
        );
      },
    );

    debugPrint("=================================================");
  }

  Future<void> submitOperation(OperationType type) async {
    debugPrint(
      "============ AppServicesCubit.submitOperation ($type) ============",
    );

    if (state.isSubmitting) return;

    final strategy = OperationStrategyFactory.create(type);
    final ctx = OperationContext(state);

    // 1) validate Ø¹Ø¨Ø± strategy
    final validation = strategy.validate(ctx);
    if (!validation.isValid) {
      emit(state.copyWith(message: validation.message, clearMessage: false));
      return;
    }

    // 2) set submitting + reset success flags Ø§Ù„Ø®Ø§ØµØ© Ø¨Ø§Ù„Ù†ÙˆØ¹
    emit(
      state.copyWith(
        isSubmitting: true,
        clearMessage: true,
        withdrawSuccess: type == OperationType.withdraw
            ? false
            : state.withdrawSuccess,
        depositSuccess: type == OperationType.deposit
            ? false
            : state.depositSuccess,
        transferSuccess: type == OperationType.transfer
            ? false
            : state.transferSuccess,
      ),
    );

    // 3) Ù†ÙÙ‘Ø° usecase Ø§Ù„Ù…Ù†Ø§Ø³Ø¨ (Ù‡ÙˆÙ† Ø§Ù„Ù‚Ø±Ø§Ø± Ø¹Ù†Ø¯ cubitâ€”Ø§Ù„Ø§Ø³ØªØ±Ø§ØªÙŠØ¬ÙŠØ© Ø¨Ø³ Ø±ØªÙ‘Ø¨Øª Ø§Ù„ØªØ­Ù‚Ù‚ ÙˆØ§Ù„Ø³Ù„ÙˆÙƒ)
    Future<void> run() async {
      switch (type) {
        case OperationType.withdraw:
          final params = WithdrawParams(
            accountId: ctx.fromAccountId!,
            name: ctx.name,
            amount: ctx.amount,
          );
          final result = await withdrawUseCase.call(params);
          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  message: failure.errMessage,
                ),
              );

              AppEventBus.instance.emit(
                OperationFailed(type: type, message: failure.errMessage),
              );
            },
            (success) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  message: success.successMessage,
                  withdrawSuccess: true,
                  didChange: true,
                ),
              );

              AppEventBus.instance.emit(
                OperationSucceeded(
                  type: OperationType.withdraw,
                  message: success.successMessage,
                ),
              );
            },
          );
          break;

        case OperationType.deposit:
          final params = DepositParams(
            accountId: ctx.fromAccountId!,
            name: ctx.name,
            amount: ctx.amount,
          );
          final result = await depositUseCase.call(params);
          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  message: failure.errMessage,
                ),
              );

              AppEventBus.instance.emit(
                OperationFailed(type: type, message: failure.errMessage),
              );
            },
            (success) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  message: success.successMessage,
                  depositSuccess: true,
                  didChange: true,
                ),
              );

              AppEventBus.instance.emit(
                OperationSucceeded(
                  type: OperationType.deposit,
                  message: success.successMessage,
                ),
              );
            },
          );
          break;

        case OperationType.transfer:
          final params = TransferParams(
            accountId: ctx.fromAccountId!,
            name: ctx.name,
            amount: ctx.amount,
            toAccountNumber: ctx.toAccountNumber,
          );
          final result = await transferUseCase.call(params);
          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  message: failure.errMessage,
                ),
              );

              AppEventBus.instance.emit(
                OperationFailed(type: type, message: failure.errMessage),
              );
            },
            (success) {
              emit(
                state.copyWith(
                  isSubmitting: false,
                  message: success.successMessage,
                  transferSuccess: true,
                  didChange: true,
                ),
              );

              AppEventBus.instance.emit(
                OperationSucceeded(
                  type: OperationType.transfer,
                  message: success.successMessage,
                ),
              );
            },
          );
          break;
        default:
          emit(
            state.copyWith(
              isSubmitting: false,
              message:
                  'O+U^O1 O15U,O1U.U,USOc O15USO¤ U.O_O1U^U. O14U.U+ OrO_U.O15OÝ O15U,OÝO£OUSU,',
            ),
          );
          break;
      }
    }

    await strategy.execute(ctx: ctx, runUseCase: run);

    debugPrint("=================================================");
  }

  /// ØªØ­Ø¯ÙŠØ« Ø§Ù„Ø­Ø³Ø§Ø¨ Ø§Ù„Ù…Ø®ØªØ§Ø± Ù…Ù† Ø§Ù„Ù‚Ø§Ø¦Ù…Ø©
  void fromAccountIdChanged(int? id) {
    emit(state.copyWith(selectedFromAccountId: id));
  }

  /// ØªØ­Ø¯ÙŠØ« Ø§Ø³Ù… Ø§Ù„Ø­Ø³Ø§Ø¨ Ø§Ù„Ù…Ø®ØªØ§Ø± (ÙÙŠ Ø­Ø§Ù„ Ø§Ù„Ø­Ø§Ø¬Ø©)
  void fromAccountNameChanged(String? name) {
    emit(state.copyWith(selectedFromAccountName: name));
  }

  void operationNameChanged(String value) {
    emit(state.copyWith(operationNameChanged: value));
  }

  void amountChanged(String value) {
    emit(state.copyWith(amountChanged: value));
  }

  void resetWithdrawSuccess() {
    if (!state.withdrawSuccess) return;
    emit(state.copyWith(withdrawSuccess: false));
  }

  void resetDepositSuccess() {
    if (!state.depositSuccess) return;
    emit(state.copyWith(depositSuccess: false));
  }

  void toAccountNumberChanged(String value) {
    emit(state.copyWith(toAccountNumberChanged: value));
  }

  void resetTransferSuccess() {
    if (!state.transferSuccess) return;
    emit(state.copyWith(transferSuccess: false));
  }

  void resetScheduledSuccess() {
    if (!state.scheduledSuccess) return;
    emit(state.copyWith(scheduledSuccess: false));
  }

  void scheduledTypeChanged(String v) {
    emit(state.copyWith(selectedOperationType: v));
  }

  void scheduledDateChanged(String v) {
    emit(state.copyWith(sectectDate: v));
  }
}
