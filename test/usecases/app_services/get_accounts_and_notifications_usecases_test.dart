import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';

import 'package:complaints_app/features/app_services/domain/use_case/get_accounts_for_select_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/notification_use_case.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockAppServicesRepository repo;

  setUp(() {
    repo = MockAppServicesRepository();
  });

  group('GetAccountsForSelectUseCase', () {
    test('يرجع Right عندما repo.getAccountsForSelect ينجح', () async {
      final useCase = GetAccountsForSelectUseCase(repository: repo);

      when(() => repo.getAccountsForSelect())
          .thenAnswer((_) async => Right([MockAccountSelectItemEntity()]));

      final result = await useCase.call();

      expect(result.isRight(), true);
      verify(() => repo.getAccountsForSelect()).called(1);
    });

    test('يرجع Left عندما repo.getAccountsForSelect يفشل', () async {
      final useCase = GetAccountsForSelectUseCase(repository: repo);

      when(() => repo.getAccountsForSelect())
          .thenAnswer((_) async => Left(ServerFailure(errMessage: 'fail')));

      final result = await useCase.call();

      expect(result, isA<Left>());
      verify(() => repo.getAccountsForSelect()).called(1);
    });
  });

  group('GetNotificationsUseCase', () {
    test('يرجع Right عندما repo.getNotifications ينجح', () async {
      final useCase = GetNotificationsUseCase(repository: repo);

      when(() => repo.getNotifications())
          .thenAnswer((_) async => Right([MockNotificationEntity()]));

      final result = await useCase();

      expect(result.isRight(), true);
      verify(() => repo.getNotifications()).called(1);
    });

    test('يرجع Left عندما repo.getNotifications يفشل', () async {
      final useCase = GetNotificationsUseCase(repository: repo);

      when(() => repo.getNotifications())
          .thenAnswer((_) async => Left(ServerFailure(errMessage: 'fail')));

      final result = await useCase();

      expect(result, isA<Left>());
      verify(() => repo.getNotifications()).called(1);
    });
  });
}
