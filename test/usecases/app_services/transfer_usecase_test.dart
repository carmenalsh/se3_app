import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:complaints_app/core/errors/failure.dart';
import 'package:complaints_app/features/app_services/domain/entities/transfer_result_entity.dart';
import 'package:complaints_app/features/app_services/domain/use_case/transfer_use_case.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/mocks.dart';
import '../../helpers/register_fallbacks.dart';

void main() {
  late MockAppServicesRepository repo;
  late TransferUseCase useCase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    repo = MockAppServicesRepository();
    useCase = TransferUseCase(repository: repo);
  });

  test('يرجع Right عندما repository.transfer ينجح', () async {
    final params = tTransferParams();
    final entity = tTransferResult();

    when(() => repo.transfer(params: any(named: 'params')))
        .thenAnswer((_) async => Right(entity));

    final result = await useCase(params);

    expect(result, Right(entity));
    verify(() => repo.transfer(params: params)).called(1);
  });

  test('يرجع Left عندما repository.transfer يفشل', () async {
    final params = tTransferParams();
    final failure = ServerFailure(errMessage: 'error');

    when(() => repo.transfer(params: any(named: 'params')))
        .thenAnswer((_) async => Left(failure));

    final result = await useCase(params);

    expect(result, Left(failure));
    verify(() => repo.transfer(params: params)).called(1);
  });
}
