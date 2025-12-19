import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/create_account/domain/use_case/create_account_use_case.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  late MockCreateAccountRepository repo;
  late CreateAccountUseCase useCase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    repo = MockCreateAccountRepository();
    useCase = CreateAccountUseCase(repository: repo);
  });

  test('يرجع Right عندما repository.createAccount ينجح', () async {
    final params = tCreateAccountParams();
    final entity = tCreateAccountEntity();

    when(() => repo.createAccount(params: any(named: 'params')))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => repo.createAccount(params: params)).called(1);
  });

  test('يرجع Left عندما repository.createAccount يفشل', () async {
    final params = tCreateAccountParams();
    final failure = ServerFailure(errMessage: 'error');

    when(() => repo.createAccount(params: any(named: 'params')))
        .thenAnswer((_) async => Left(failure));

    final result = await useCase(params);

    expect(result, Left(failure));
    verify(() => repo.createAccount(params: params)).called(1);
  });
}
