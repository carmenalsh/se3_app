import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/account_manag/domain/entities/update_account_result_entity.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/params/update_account_params.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/update_account_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import '../../helpers/fixtures.dart';

import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  late MockAccountManagRepository repo;
  late UpdateAccountUseCase useCase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    repo = MockAccountManagRepository();
    useCase = UpdateAccountUseCase(repository: repo);
  });

  test('يرجع Right عندما repository.updateAccount ينجح', () async {
    final params = tUpdateAccountParams();
    final resultEntity = tUpdateAccountResult();

    when(
      () => repo.updateAccount(params: any(named: 'params')),
    ).thenAnswer((_) async => Right(resultEntity));

    final result = await useCase(params);

    expect(result, Right(resultEntity));
    verify(() => repo.updateAccount(params: params)).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('يرجع Left عندما repository.updateAccount يفشل', () async {
    final params = UpdateAccountParams(
      accountId: 2,
      name: 'عند الفشل',
      status: 'نشط',
      description: 'وصف',
    );
    final failure = ServerFailure(errMessage: 'error'); // حسب Failure عندك

    when(
      () => repo.updateAccount(params: any(named: 'params')),
    ).thenAnswer((_) async => Left(failure));

    final result = await useCase(params);

    expect(result, Left(failure));
    verify(() => repo.updateAccount(params: params)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
