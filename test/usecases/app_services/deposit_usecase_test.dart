import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/use_case/deposit_use_case.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  late MockAppServicesRepository repo;
  late DepositUseCase useCase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    repo = MockAppServicesRepository();
    useCase = DepositUseCase(repository: repo);
  });

  test('يرجع Right عندما repository.deposit ينجح', () async {
    final params = tDepositParams();
    final entity = tDepositResult();

    when(() => repo.deposit(params: any(named: 'params')))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => repo.deposit(params: params)).called(1);
  });

  test('يرجع Left عندما repository.deposit يفشل', () async {
    final params = tDepositParams();
    final failure = ServerFailure(errMessage: 'error');

    when(() => repo.deposit(params: any(named: 'params')))
        .thenAnswer((_) async => Left(failure));

    final result = await useCase(params);

    expect(result, Left(failure));
    verify(() => repo.deposit(params: params)).called(1);
  });
}
