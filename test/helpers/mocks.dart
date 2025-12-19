import 'package:complaints_app/features/account_manag/domain/repository/account_manag_repository.dart';
import 'package:complaints_app/features/app_services/domain/entities/account_select_item_entity.dart';
import 'package:complaints_app/features/app_services/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/app_services/domain/repository/app_services_repository.dart';
import 'package:complaints_app/features/app_services/domain/use_case/get_accounts_for_select_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/notification_use_case.dart';
import 'package:complaints_app/features/create_account/domain/repository/create_account_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountManagRepository extends Mock
    implements AccountManagRepository {}

class MockCreateAccountRepository extends Mock
    implements CreateAccountRepository {}

class MockAppServicesRepository extends Mock implements AppServicesRepository {}

// ✅ UseCases for Cubit
class MockGetAccountsForSelectUseCase extends Mock
    implements GetAccountsForSelectUseCase {}

class MockGetNotificationsUseCase extends Mock
    implements GetNotificationsUseCase {}

// ✅ Entities (we’ll use mocks as dummy objects inside lists)
class MockAccountSelectItemEntity extends Mock
    implements AccountSelectItemEntity {}

class MockNotificationEntity extends Mock implements NotificationEntity {}
