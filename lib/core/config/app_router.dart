import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/databases/api/api_factory.dart';
import 'package:complaints_app/core/network/network_info.dart';
import 'package:complaints_app/features/account_manag/data/data_source/account_mange_remote_data_source.dart';
import 'package:complaints_app/features/account_manag/data/repository_impl/account_manag_repository_impl.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/get_accounts_use_case.dart';
import 'package:complaints_app/features/account_manag/domain/use_case/update_account_use_case.dart';
import 'package:complaints_app/features/account_manag/presentation/manager/account_manag_cubit.dart';
import 'package:complaints_app/features/account_manag/presentation/view/account_manag_page.dart';
import 'package:complaints_app/features/app_services/data/data_source/app_services_remote_data_source.dart';
import 'package:complaints_app/features/app_services/data/repository_impl/app_services_repository_impl.dart';
import 'package:complaints_app/features/app_services/domain/use_case/deposit_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/get_accounts_for_select_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/notification_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/scheduled_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/transfer_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/withdraw_use_case.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_cubit.dart';
import 'package:complaints_app/features/app_services/presentation/view/app_services_page.dart';
import 'package:complaints_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:complaints_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:complaints_app/features/auth/domain/use_cases/foget_password_email_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/resend_code_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/resend_password_reset_otp_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/verify_forget_password_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/verify_register_use_case.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/register%20cubit/register_cubit.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_email_view.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_new_password_view.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_otp_code_view.dart';
import 'package:complaints_app/features/auth/presentation/view/login_view.dart';
import 'package:complaints_app/features/auth/presentation/view/register_view.dart';
import 'package:complaints_app/features/auth/presentation/view/verify_register_view.dart';
import 'package:complaints_app/features/create_account/data/data_source/create_account_remote_data_source.dart';
import 'package:complaints_app/features/create_account/data/repository_impl/create_account_repository_impl.dart';
import 'package:complaints_app/features/create_account/domain/use_case/create_account_use_case.dart';
import 'package:complaints_app/features/create_account/presentation/manager/create_account_cubit.dart';
import 'package:complaints_app/features/create_account/presentation/view/create_account_page.dart';
import 'package:complaints_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:complaints_app/features/home/data/repository_impl/home_repository_impl.dart';
import 'package:complaints_app/features/home/domain/use_cases/get_transaction_use_case.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit.dart';
import 'package:complaints_app/features/home/presentation/screens/home_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/splash_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/auth/presentation/manager/verify register/verify_register_cubit.dart';


abstract class AppRourer {
  static final router = GoRouter(
    routes: [
      ////////////////////// auth////////////////////////////////////
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/welcomeView',
        name: AppRouteRName.welcomeView,
        builder: (context, state) => const WelcomeView(),
      ),

      GoRoute(
        path: '/loginView',
        name: AppRouteRName.loginView,
        pageBuilder: (context, state) {
          
         final api = buildApiConsumer();

          // 2) NetworkInfo
          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          // 3) RemoteDataSource
          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: api,
          );

          // 4) Repository
          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          // 5) UseCase
          final loginUseCase = LoginUseCase(repository: authRepository);

          // 6) BlocProvider + نفس الـ transition الجميل اللي عندك
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => LoginCubit(loginUseCase: loginUseCase),
              child: const LoginView(),
            ),
            transitionDuration: const Duration(milliseconds: 350),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeOutCubic));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          );
        },
      ),

      // GoRoute(
      //   path: '/loginView',
      //   name: AppRouteRName.loginView,
      //   pageBuilder: (context, state) {
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       child: const LoginView(),
      //       transitionDuration: const Duration(milliseconds: 350),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //             final tween = Tween<Offset>(
      //               begin: const Offset(0, 1),
      //               end: Offset.zero,
      //             ).chain(CurveTween(curve: Curves.easeOutCubic));

      //             return SlideTransition(
      //               position: animation.drive(tween),
      //               child: child,
      //             );
      //           },
      //     );
      //   },
      // ),
      GoRoute(
        path: '/registerView',
        name: AppRouteRName.registerView,
        builder: (context, state) {
          
         final api = buildApiConsumer();

          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: api,
          );

          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          final registerUseCase = RegisterUseCase(authRepository);

          return BlocProvider(
            create: (_) => RegisterCubit(registerUseCase),
            child: const RegisterView(),
          );
        },
      ),

      GoRoute(
        path: '/verifyRegisterView',
        name: AppRouteRName.verifyRegisterView,
        builder: (context, state) {
          final email = state.extra as String;

          
          final api = buildApiConsumer();
          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: api,
          );

          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          final verifyUseCase = VerifyRegisterUseCase(authRepository);
          final resendUseCase = ResendCodeUseCase(authRepository);

          return BlocProvider(
            create: (_) => VerifyRegisterCubit(
              email: email,
              verifyRegisterUseCase: verifyUseCase,
              resendCodeUseCase: resendUseCase,
            ),
            child: VerifyRegisterView(email: email),
          );
        },
      ),

      ShellRoute(
        builder: (context, state, child) {
        
         final api = buildApiConsumer();
          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: api,
          );

          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          final forgetPasswordEmailUseCase = FogretPasswordEmailUseCase(
            repository: authRepository,
          );

          final verifyForgotPasswordOtpUseCase = VerifyForgetPasswordUseCase(
            repository: authRepository,
          );

          final resendPasswordResetOtpUseCase = ResendPasswordResetOtpUseCase(
            authRepository,
          );

          final resetPasswordUseCase = ResetPasswordUseCase(
            repository: authRepository,
          );

          return BlocProvider(
            create: (_) => ForgotPasswordCubit(
              forgetPasswordEmailUseCase: forgetPasswordEmailUseCase,
              verifyForgotPasswordOtpUseCase: verifyForgotPasswordOtpUseCase,
              resendPasswordResetOtpUseCase: resendPasswordResetOtpUseCase,
              resetPasswordUseCase: resetPasswordUseCase,
            ),
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/forgotPasswordEmailView',
            name: AppRouteRName.forgotPasswordEmailView,
            builder: (context, state) => const ForgotPasswordEmailView(),
          ),
          GoRoute(
            path: '/forgotPasswordOtpCodeView',
            name: AppRouteRName.forgotPasswordOtpCodeView,
            builder: (context, state) => const ForgetPasswordOtpCodeView(),
          ),
          GoRoute(
            path: '/forgetPasswordNewPasswordView',
            name: AppRouteRName.forgotPasswordNewPasswordView,
            builder: (context, state) => const ForgotPasswordNewPasswordView(),
          ),
        ],
      ),

      // GoRoute(
      //       path: '/homeView',
      //       name: AppRouteRName.homeView,
      //       builder: (context, state) => const HomeView(),
      //     ),
      GoRoute(
        path: '/homeView',
        name: AppRouteRName.homeView,
        builder: (context, state) {
          
          final api = buildApiConsumer();

          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);
          final homeRemoteDataSource = HomeRemoteDataSourceImpl(api);
          final homeRepository = HomeRepositoryImpl(homeRemoteDataSource);

          final getTransActionUseCase = GetTransActionUseCase(
            repository: homeRepository,
          );

          // final searchComplaintUseCase = SearchComplaintUseCase(
          //   repository: homeRepository,
          // );

          final authRemoreDataSourcev = AuthRemoteDataSourceImpl(
            apiConsumer: api,
          );
          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoreDataSourcev,
            networkInfo: networkInfo,
          );
         // final logoutUseCase = LogoutUseCase(repository: authRepository);

          // final notificationUseCase = GetNotificationsUseCase(
          //   repository: homeRepository,
          // );

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomeCubit(getTransActionUseCase)),

              // BlocProvider(
              //   create: (_) => LogoutCubit(logoutUseCase: logoutUseCase),
              // ),
            ],
            child: const HomeView(),
          );
        },
      ),
      GoRoute(
        path: '/accountManag',
        name: AppRouteRName.accountManag,
        builder: (context, state) {
          
          final api = buildApiConsumer();

          final remoteDataSource = AccountRemoteDataSourceImpl(
            apiConsumer: api,
          );
          final repository = AccountManagRepositoryImpl(
            remoteDataSource: remoteDataSource,
          );
          final getAccounts = GetAccountsUseCase(repository: repository);
          final editAccount = UpdateAccountUseCase(repository: repository);
          return MultiBlocProvider(
            providers: [
              BlocProvider<AccountManagCubit>(
                create: (context) => AccountManagCubit(
                  getAccountsUseCase: getAccounts,
                  updateAccountUseCase: editAccount,
                )..getAccounts(),
              ),

              // إذا عندك Cubits ثانية للصفحة ضيفها هون
              // BlocProvider<SomethingCubit>(
              //   create: (context) => sl<SomethingCubit>(),
              // ),
            ],
            child: const AccountManagPage(),
          );
        },
      ),

      GoRoute(
        path: '/showServices',
        name: AppRouteRName.showServices,
        builder: (context, state) {
          
          final api = buildApiConsumer();
          final remoteDataSource = AppServicesRemoteDataSourceImpl(
            apiConsumer: api,
          );
          final repository = AppServicesRepositoryImpl(
            remoteDataSource: remoteDataSource,
          );
          final getAccounts = GetAccountsForSelectUseCase(
            repository: repository,
          );
          final withdrawUseCase = WithdrawUseCase(repository: repository);
          final depositUseCase = DepositUseCase(repository: repository);
          final transferUseCase = TransferUseCase(repository: repository);
          final scheduledUseCase = ScheduledUseCase(repository: repository);
          final getNotificationsUseCase = GetNotificationsUseCase(repository: repository);

          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);
         final authRemoreDataSourcev = AuthRemoteDataSourceImpl(
            apiConsumer: api,
          );
          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoreDataSourcev,
            networkInfo: networkInfo,
          );
          final logoutUseCase = LogoutUseCase(repository: authRepository);
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppServicesCubit>(
                create: (_) => AppServicesCubit(
                  getAccountsForSelectUseCase: getAccounts,
                  withdrawUseCase: withdrawUseCase,
                  depositUseCase: depositUseCase,
                  transferUseCase: transferUseCase, 
                  scheduledUseCase: scheduledUseCase,
                   getNotificationsUseCase: getNotificationsUseCase,
                 
                ),
              ),
               BlocProvider(
                create: (_) => LogoutCubit(logoutUseCase: logoutUseCase),
              ),
            ],
            child: const AppServicesPage(),
          );
        },
      ),

      GoRoute(
        path: '/createAccount',
        name: AppRouteRName.createAccount,
        builder: (context, state) {
         
         final api = buildApiConsumer();
          final remoteDataSource = CreateAccountRemoteDataSourceImpl(
            apiConsumer: api,
          );
          final repository = CreateAccountRepositoryImpl(
            remoteDataSource: remoteDataSource,
          );
          final createAccount = CreateAccountUseCase(repository: repository);
          return BlocProvider<CreateAccountCubit>(
            create: (_) =>
                CreateAccountCubit(createAccountUseCase: createAccount),
            child: CreateAccountPage(),
          );
        },
      ),
    ],
  );
}
