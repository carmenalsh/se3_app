import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/scheduled_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/use_case/scheduled_use_case.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  late MockAppServicesRepository repo;
  late ScheduledUseCase useCase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    repo = MockAppServicesRepository();
    useCase = ScheduledUseCase(repository: repo);
  });

  test('يرجع Right عندما repository.scheduledTransaction ينجح', () async {
    final params = tScheduledParams();
    final entity = tScheduledResult();

    when(() => repo.scheduledTransaction(any()))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => repo.scheduledTransaction(params)).called(1);
  });

  test('يرجع Left عندما repository.scheduledTransaction يفشل', () async {
    final params = tScheduledParams();
    final failure = ServerFailure(errMessage: 'error');

    when(() => repo.scheduledTransaction(any()))
        .thenAnswer((_) async => Left(failure));

    final result = await useCase(params);

    expect(result, Left(failure));
    verify(() => repo.scheduledTransaction(params)).called(1);
  });
}
