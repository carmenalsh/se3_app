import 'package:bloc_test/bloc_test.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_cubit.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:complaints_app/core/errors/failure.dart';

import 'package:complaints_app/features/app_services/domain/use_case/deposit_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/scheduled_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/transfer_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/withdraw_use_case.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  setUpAll(registerFallbacks);

  late MockGetAccountsForSelectUseCase getAccountsForSelectUseCase;
  late MockGetNotificationsUseCase getNotificationsUseCase;

  late MockAppServicesRepository appRepo;

  late DepositUseCase depositUseCase;
  late WithdrawUseCase withdrawUseCase;
  late TransferUseCase transferUseCase;
  late ScheduledUseCase scheduledUseCase;

  setUp(() {
    getAccountsForSelectUseCase = MockGetAccountsForSelectUseCase();
    getNotificationsUseCase = MockGetNotificationsUseCase();

    appRepo = MockAppServicesRepository();
    depositUseCase = DepositUseCase(repository: appRepo);
    withdrawUseCase = WithdrawUseCase(repository: appRepo);
    transferUseCase = TransferUseCase(repository: appRepo);
    scheduledUseCase = ScheduledUseCase(repository: appRepo);
  });

  AppServicesCubit buildCubit() {
    return AppServicesCubit(
      getAccountsForSelectUseCase: getAccountsForSelectUseCase,
      withdrawUseCase: withdrawUseCase,
      depositUseCase: depositUseCase,
      transferUseCase: transferUseCase,
      scheduledUseCase: scheduledUseCase,
      getNotificationsUseCase: getNotificationsUseCase,
    );
  }

  group('submitDeposit', () {
    blocTest<AppServicesCubit, AppServicesState>(
      'success -> isSubmitting true ثم depositSuccess true + message',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        selectedFromAccountId: 3,
        operationNameChanged: 'ايداع',
        amountChanged: '10',
      ),
      setUp: () {
        when(() => appRepo.deposit(params: any(named: 'params')))
            .thenAnswer((_) async => Right(tDepositResult()));
      },
      act: (cubit) => cubit.submitDeposit(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true)
            .having((s) => s.depositSuccess, 'depositSuccess', false),

        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.depositSuccess, 'depositSuccess', true)
            .having((s) => s.didChange, 'didChange', true)
            .having((s) => s.message, 'message', isNotNull),
      ],
      verify: (_) {
        verify(() => appRepo.deposit(params: any(named: 'params'))).called(1);
      },
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'failure -> isSubmitting true ثم message خطأ',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        selectedFromAccountId: 3,
        operationNameChanged: 'ايداع',
        amountChanged: '10',
      ),
      setUp: () {
        when(() => appRepo.deposit(params: any(named: 'params'))).thenAnswer(
          (_) async => Left(ServerFailure(errMessage: 'deposit failed')),
        );
      },
      act: (cubit) => cubit.submitDeposit(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true),

        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.message, 'message', 'deposit failed')
            .having((s) => s.depositSuccess, 'depositSuccess', false),
      ],
      verify: (_) {
        verify(() => appRepo.deposit(params: any(named: 'params'))).called(1);
      },
    );
  });

  group('submitTransfer', () {
    blocTest<AppServicesCubit, AppServicesState>(
      'success -> isSubmitting true ثم transferSuccess true + message',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        selectedFromAccountId: 3,
        operationNameChanged: 'تحويل',
        amountChanged: '5',
        toAccountNumberChanged: '123',
      ),
      setUp: () {
        when(() => appRepo.transfer(params: any(named: 'params')))
            .thenAnswer((_) async => Right(tTransferResult()));
      },
      act: (cubit) => cubit.submitTransfer(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true)
            .having((s) => s.transferSuccess, 'transferSuccess', false),

        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.transferSuccess, 'transferSuccess', true)
            .having((s) => s.didChange, 'didChange', true)
            .having((s) => s.message, 'message', isNotNull),
      ],
      verify: (_) {
        verify(() => appRepo.transfer(params: any(named: 'params'))).called(1);
      },
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'failure -> isSubmitting true ثم message خطأ',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        selectedFromAccountId: 3,
        operationNameChanged: 'تحويل',
        amountChanged: '5',
        toAccountNumberChanged: '123',
      ),
      setUp: () {
        when(() => appRepo.transfer(params: any(named: 'params'))).thenAnswer(
          (_) async => Left(ServerFailure(errMessage: 'transfer failed')),
        );
      },
      act: (cubit) => cubit.submitTransfer(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true),

        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.message, 'message', 'transfer failed')
            .having((s) => s.transferSuccess, 'transferSuccess', false),
      ],
      verify: (_) {
        verify(() => appRepo.transfer(params: any(named: 'params'))).called(1);
      },
    );
  });

  group('submitScheduled', () {
    blocTest<AppServicesCubit, AppServicesState>(
      'success -> isSubmitting true ثم scheduledSuccess true + message',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        selectedFromAccountId: 3,
        operationNameChanged: 'جدولة',
        amountChanged: '2',
        selectedOperationType: 'جدولة',
        sectectDate: '2025-12-19 17:50:00',
      ),
      setUp: () {
        when(() => appRepo.scheduledTransaction(any()))
            .thenAnswer((_) async => Right(tScheduledResult()));
      },
      act: (cubit) => cubit.submitScheduled(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true)
            .having((s) => s.scheduledSuccess, 'scheduledSuccess', false),

        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.scheduledSuccess, 'scheduledSuccess', true)
            .having((s) => s.didChange, 'didChange', true)
            .having((s) => s.message, 'message', isNotNull),
      ],
      verify: (_) {
        verify(() => appRepo.scheduledTransaction(any())).called(1);
      },
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'failure -> isSubmitting true ثم message خطأ',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        selectedFromAccountId: 3,
        operationNameChanged: 'جدولة',
        amountChanged: '2',
        selectedOperationType: 'جدولة',
        sectectDate: '2025-12-19 17:50:00',
      ),
      setUp: () {
        when(() => appRepo.scheduledTransaction(any())).thenAnswer(
          (_) async => Left(ServerFailure(errMessage: 'scheduled failed')),
        );
      },
      act: (cubit) => cubit.submitScheduled(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', true),

        isA<AppServicesState>()
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.message, 'message', 'scheduled failed')
            .having((s) => s.scheduledSuccess, 'scheduledSuccess', false),
      ],
      verify: (_) {
        verify(() => appRepo.scheduledTransaction(any())).called(1);
      },
    );
  });
}
