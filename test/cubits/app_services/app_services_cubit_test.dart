import 'package:bloc_test/bloc_test.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_cubit.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';

// UseCases used by cubit constructor
import 'package:complaints_app/features/app_services/domain/use_case/deposit_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/scheduled_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/transfer_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/withdraw_use_case.dart';

import '../../helpers/mocks.dart';
void main() {
  late MockGetAccountsForSelectUseCase getAccountsForSelectUseCase;
  late MockGetNotificationsUseCase getNotificationsUseCase;

  // we won’t test submitOperation الآن, بس لازم نمررهم بالـ constructor
  late DepositUseCase depositUseCase;
  late WithdrawUseCase withdrawUseCase;
  late TransferUseCase transferUseCase;
  late ScheduledUseCase scheduledUseCase;

  // these usecases تحتاج repositories، فنعملها real مع repo mock (بدون ما نستعملها)
  late MockAppServicesRepository appRepo;

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

  group('loadAccountsForSelect', () {
    late List<AccountSelectItemEntity> accountsList;

    setUp(() {
      accountsList = [MockAccountSelectItemEntity()];
    });

    blocTest<AppServicesCubit, AppServicesState>(
      'success -> emits loading ثم success وفيها accountsForSelect',
      build: () => buildCubit(),
      setUp: () {
        when(() => getAccountsForSelectUseCase.call())
            .thenAnswer((_) async => Right(accountsList));
      },
      act: (cubit) => cubit.loadAccountsForSelect(),
      expect: () => [
        // loading state
        isA<AppServicesState>()
            .having((s) => s.status, 'status', AppServicesStatus.loading)
            .having((s) => s.isSubmitting, 'isSubmitting', true),

        // success state
        isA<AppServicesState>()
            .having((s) => s.status, 'status', AppServicesStatus.success)
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.accountsForSelect.length, 'accountsForSelect.length', 1),
      ],
      verify: (_) {
        verify(() => getAccountsForSelectUseCase.call()).called(1);
      },
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'failure -> emits loading ثم error مع message',
      build: () => buildCubit(),
      setUp: () {
        when(() => getAccountsForSelectUseCase.call())
            .thenAnswer((_) async => Left(ServerFailure(errMessage: 'fail')));
      },
      act: (cubit) => cubit.loadAccountsForSelect(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.status, 'status', AppServicesStatus.loading)
            .having((s) => s.isSubmitting, 'isSubmitting', true),

        isA<AppServicesState>()
            .having((s) => s.status, 'status', AppServicesStatus.error)
            .having((s) => s.isSubmitting, 'isSubmitting', false)
            .having((s) => s.message, 'message', 'fail'),
      ],
      verify: (_) {
        verify(() => getAccountsForSelectUseCase.call()).called(1);
      },
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'إذا accountsForSelect مو فاضي -> ما يعمل emit ولا ينادي usecase',
      build: () => buildCubit(),
      seed: () => const AppServicesState().copyWith(
        accountsForSelect: [MockAccountSelectItemEntity()],
      ),
      act: (cubit) => cubit.loadAccountsForSelect(),
      expect: () => <AppServicesState>[],
      verify: (_) {
        verifyNever(() => getAccountsForSelectUseCase.call());
      },
    );
  });

  group('loadNotifications', () {
    late List<NotificationEntity> notifList;

    setUp(() {
      notifList = [MockNotificationEntity()];
    });

    blocTest<AppServicesCubit, AppServicesState>(
      'success -> emits loading notifications ثم success list',
      build: () => buildCubit(),
      setUp: () {
        when(() => getNotificationsUseCase())
            .thenAnswer((_) async => Right(notifList));
      },
      act: (cubit) => cubit.loadNotifications(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isNotificationsLoading, 'isNotificationsLoading', true)
            .having((s) => s.notificationsErrorMessage, 'notificationsErrorMessage', null),

        isA<AppServicesState>()
            .having((s) => s.isNotificationsLoading, 'isNotificationsLoading', false)
            .having((s) => s.notifications.length, 'notifications.length', 1),
      ],
      verify: (_) {
        verify(() => getNotificationsUseCase()).called(1);
      },
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'failure -> emits loading notifications ثم errorMessage',
      build: () => buildCubit(),
      setUp: () {
        when(() => getNotificationsUseCase()).thenAnswer(
          (_) async => Left(ServerFailure(errMessage: 'notif fail')),
        );
      },
      act: (cubit) => cubit.loadNotifications(),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.isNotificationsLoading, 'isNotificationsLoading', true)
            .having((s) => s.notificationsErrorMessage, 'notificationsErrorMessage', null),

        isA<AppServicesState>()
            .having((s) => s.isNotificationsLoading, 'isNotificationsLoading', false)
            .having((s) => s.notificationsErrorMessage, 'notificationsErrorMessage', 'notif fail'),
      ],
      verify: (_) {
        verify(() => getNotificationsUseCase()).called(1);
      },
    );
  });

  group('simple state changes', () {
    blocTest<AppServicesCubit, AppServicesState>(
      'fromAccountIdChanged -> يحدّث selectedFromAccountId',
      build: () => buildCubit(),
      act: (cubit) => cubit.fromAccountIdChanged(7),
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.selectedFromAccountId, 'selectedFromAccountId', 7),
      ],
    );

    blocTest<AppServicesCubit, AppServicesState>(
      'operationNameChanged & amountChanged -> يحدّث القيم',
      build: () => buildCubit(),
      act: (cubit) {
        cubit.operationNameChanged('عملية');
        cubit.amountChanged('50');
      },
      expect: () => [
        isA<AppServicesState>()
            .having((s) => s.operationNameChanged, 'operationNameChanged', 'عملية'),

        // مهم: العملية تبقى "عملية" بالـ state الثاني
        isA<AppServicesState>()
            .having((s) => s.amountChanged, 'amountChanged', '50')
            .having((s) => s.operationNameChanged, 'operationNameChanged', 'عملية'),
      ],
    );
  });
}

