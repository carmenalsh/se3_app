import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/use_case/withdraw_use_case.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  late MockAppServicesRepository repo;
  late WithdrawUseCase useCase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    repo = MockAppServicesRepository();
    useCase = WithdrawUseCase(repository: repo);
  });

  test('يرجع Right عندما repository.withdraw ينجح', () async {
    final params = tWithdrawParams();
    final entity = tWithdrawResult();

    when(() => repo.withdraw(params: any(named: 'params')))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => repo.withdraw(params: params)).called(1);
  });

  test('يرجع Left عندما repository.withdraw يفشل', () async {
    final params = tWithdrawParams();
    final failure = ServerFailure(errMessage: 'error');

    when(() => repo.withdraw(params: any(named: 'params')))
        .thenAnswer((_) async => Left(failure));

    final result = await useCase(params);

    expect(result, Left(failure));
    verify(() => repo.withdraw(params: params)).called(1);
  });
}
