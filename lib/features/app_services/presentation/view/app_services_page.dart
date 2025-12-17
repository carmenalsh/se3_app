import 'dart:io';

import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/operation_bottom_sheet.dart';
import 'package:complaints_app/core/databases/api/dio_consumer.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/features/app_services/data/data_source/download_file_remote_data_source.dart';
import 'package:complaints_app/features/app_services/data/repository_impl/download_file_repository_impl.dart';
import 'package:complaints_app/features/app_services/domain/use_case/download_file_use_case.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_cubit.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';
import 'package:complaints_app/features/app_services/presentation/manager/download_manager/download_file_cubit.dart';
import 'package:complaints_app/features/app_services/presentation/manager/download_manager/download_file_state.dart';
import 'package:complaints_app/features/app_services/presentation/widget/divider_widget.dart';
import 'package:complaints_app/features/app_services/presentation/widget/services_types.dart';
import 'package:complaints_app/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

class AppServicesPage extends StatelessWidget {
  const AppServicesPage({super.key});

  Future<void> _openDownloadSheet(BuildContext context) async {
    final appCubit = context.read<AppServicesCubit>();

    await appCubit.loadAccountsForSelect();

    final accounts = appCubit.state.accountsForSelect;
    if (accounts.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('لا يوجد حسابات حالياً')));
      return;
    }

    final names = accounts.map((e) => e.name).toList();
    final map = {for (final a in accounts) a.name: a.id};

    final dioConsumer = DioConsumer(dio: Dio());
    final remoteDataSource = DownloadFileRemoteDataSourceImpl(
      dio: dioConsumer.dio,
    );
    final repository = DownloadFileRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    final downloadUseCase = DownloadFileUseCase(repository: repository);

    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: appCubit), // لاختيار الحساب
            BlocProvider(
              create: (_) =>
                  DownloadFileCubit(downloadFileUseCase: downloadUseCase),
            ),
          ],
          child: Builder(
            builder: (innerCtx) {
              return BlocListener<DownloadFileCubit, DownloadFileState>(
                listenWhen: (p, c) =>
                    p.message != c.message && c.message != null,
                listener: (ctx, st) async {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(st.message!)));

                  if (st.downloadSuccess) {
                    final path = st.savedFilePath;

                    Navigator.pop(sheetContext, true);
                    ctx.read<DownloadFileCubit>().resetSuccess();

                    // فتح الملف فقط إذا PDF
                    final selectedType = ctx
                        .read<DownloadFileCubit>()
                        .state
                        .selectedFileType;
                    if (path != null && selectedType == 'pdf') {
                      final exists = await File(path).exists();
                      if (exists) {
                        await OpenFilex.open(path);
                      }
                    }
                  }
                },
                child: OperationBottomSheet(
                  config: operationConfigs[OperationType.download]!,
                  dropdownItems: names,
                  nameToId: map,

                  // ✅ هون صار context تحت الـ Provider
                  isSubmitting: innerCtx
                      .watch<DownloadFileCubit>()
                      .state
                      .isSubmitting,

                  onFromAccountIdChanged: appCubit.fromAccountIdChanged,

                  onFileTypeChanged: (v) =>
                      innerCtx.read<DownloadFileCubit>().fileTypeChanged(v),

                  onPeriodChanged: (v) =>
                      innerCtx.read<DownloadFileCubit>().periodChanged(v),

                  onSubmit: () =>
                      innerCtx.read<DownloadFileCubit>().submitDownload(
                        accountId: appCubit.state.selectedFromAccountId,
                      ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _openOperationWithAccounts(
    BuildContext context, {
    required OperationType type,
  }) async {
    final cubit = context.read<AppServicesCubit>();
    await cubit.loadAccountsForSelect();

    final state = cubit.state;

    if (state.status == AppServicesStatus.error && state.message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message!)));
      return;
    }

    final accounts = state.accountsForSelect;
    if (accounts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No accounts available right now')),
      );
      return;
    }
   

    final names = accounts.map((e) => e.name).toList();
    final map = {for (final a in accounts) a.name: a.id};

    final config = operationConfigs[type]!;

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: BlocListener<AppServicesCubit, AppServicesState>(
          listenWhen: (p, c) => p.message != c.message && c.message != null,
          listener: (ctx, st) {
            // ✅ 1) رسالة نجاح/فشل
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(st.message!)));

            final success =
                st.withdrawSuccess ||
                st.depositSuccess ||
                st.transferSuccess ||
                st.scheduledSuccess;

            if (success) {
              // ✅ 2) سكّر البوتم شيت + ارجع true
              Navigator.pop(sheetContext, true);

              // ✅ reset flags حسب العملية (مهم)
              if (st.withdrawSuccess) cubit.resetWithdrawSuccess();
              if (st.depositSuccess) cubit.resetDepositSuccess();
              if (st.transferSuccess) cubit.resetTransferSuccess();
              if (st.scheduledSuccess) cubit.resetScheduledSuccess();
            }
          },

          child: BlocBuilder<AppServicesCubit, AppServicesState>(
            builder: (_, st) {
              return OperationBottomSheet(
                config: config,
                dropdownItems: names,
                nameToId: map,
                isSubmitting: st.isSubmitting,
                onFromAccountIdChanged: cubit.fromAccountIdChanged,
                onOperationNameChanged: cubit.operationNameChanged,
                onAmountChanged: cubit.amountChanged,
                onToAccountNumberChanged: (type == OperationType.transfer)
                    ? cubit.toAccountNumberChanged
                    : null,
                onScheduledTypeChanged: (type == OperationType.scheduled)
                    ? cubit.scheduledTypeChanged
                    : null,
                onScheduledAtChanged: (type == OperationType.scheduled)
                    ? cubit.scheduledDateChanged
                    : null,

                onSubmit: () {
                  if (type == OperationType.withdraw) cubit.submitWithdraw();
                  if (type == OperationType.deposit) cubit.submitDeposit();
                  if (type == OperationType.transfer) cubit.submitTransfer();
                  if (type == OperationType.scheduled) cubit.submitScheduled();
                },
              );
            },
          ),
        ),
      ),
    );

    // ✅ 3) إذا نجحت العملية ارجع true للي فوقك (الصفحة السابقة)
    if (result == true) {
      Navigator.pop(context, true); // يعني AppServicesPage رجّع true للـ Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: "خدمات نقد"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () => _openOperationWithAccounts(
                              context,
                              type: OperationType.withdraw,
                            ),
                            child: ComplaintInformationWidget(
                              titleColor: AppColor.black,
                              image: AppImage.withdraw,
                              title: "سحب",
                            ),
                          ),
                          SizedBox(width: 25),
                          DividerWidget(),
                          SizedBox(width: 25),
                          InkWell(
                            onTap: () => _openOperationWithAccounts(
                              context,
                              type: OperationType.deposit,
                            ),
                            child: ComplaintInformationWidget(
                              titleColor: AppColor.black,
                              image: AppImage.desposit,
                              title: "ايداع",
                            ),
                          ),
                          SizedBox(width: 25),
                          DividerWidget(),
                          SizedBox(width: 25),
                          InkWell(
                            onTap: () => _openOperationWithAccounts(
                              context,
                              type: OperationType.transfer,
                            ),
                            child: ComplaintInformationWidget(
                              titleColor: AppColor.black,
                              image: AppImage.transformation,
                              title: "تحويل",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 30),
                        InkWell(
                          onTap: () => _openDownloadSheet(context),

                          child: ComplaintInformationWidget(
                            titleColor: AppColor.black,
                            image: AppImage.generateFile,
                            title: "توليد ملف",
                          ),
                        ),
                        SizedBox(width: 16),
                        DividerWidget(),
                        SizedBox(width: 23),
                        ComplaintInformationWidget(
                          titleColor: AppColor.black,
                          image: AppImage.notification,
                          title: "اشعارات",
                        ),
                        SizedBox(width: 24),
                        DividerWidget(),
                        SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            debugPrint("loggg outtttt");
                            context.read<LogoutCubit>().logOutSubmitted();
                          },
                          child: ComplaintInformationWidget(
                            titleColor: AppColor.black,
                            image: AppImage.logout,
                            title: "تسجيل خروج",
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(width: 28),
                        InkWell(
                          onTap: () => _openOperationWithAccounts(
                            context,
                            type: OperationType.scheduled,
                          ),

                          child: ComplaintInformationWidget(
                            titleColor: AppColor.black,
                            image: AppImage.scheduling,
                            title: "جدولة",
                          ),
                        ),
                        SizedBox(width: 36),
                        DividerWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
