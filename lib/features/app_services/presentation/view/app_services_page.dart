import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/operation_bottom_sheet.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_cubit.dart';
import 'package:complaints_app/features/app_services/presentation/manager/app_services_state.dart';
import 'package:complaints_app/features/app_services/presentation/widget/divider_widget.dart';
import 'package:complaints_app/features/app_services/presentation/widget/services_types.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppServicesPage extends StatelessWidget {
  const AppServicesPage({super.key});

//   Future<void> _openOperationWithAccounts(
//     BuildContext context, {
//     required OperationType type,
//   }) async {
//     final cubit = context.read<AppServicesCubit>();
//     await cubit.loadAccountsForSelect();

//     final state = cubit.state;

//     if (state.status == AppServicesStatus.error && state.message != null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(state.message!)));
//       return;
//     }

//     final accounts = state.accountsForSelect;
//     if (accounts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('No accounts available right now')),
//       );
//       return;
//     }

//     final names = accounts.map((e) => e.name).toList();
//     final map = {for (final a in accounts) a.name: a.id};

//     final config = operationConfigs[type]!;

//     // showModalBottomSheet(
//     //   context: context,
//     //   isScrollControlled: true,
//     //   builder: (_) => OperationBottomSheet(
//     //     config: config,
//     //     dropdownItems: names,
//     //     nameToId: map,
//     //     isSubmitting: state.isSubmitting,
//         // onFromAccountIdChanged: cubit.fromAccountIdChanged,
//     //     onSubmit: () {
//     //       // TODO: connect submit action for this operation
//     //     },
//     //   ),
//     // );
//     showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   builder: (_) => BlocListener<AppServicesCubit, AppServicesState>(
//     listenWhen: (p, c) =>
//         p.message != c.message && c.message != null,
//     listener: (context, state) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(state.message!)),
//       );

//       // ✅ سكّر البوتم شيت عند نجاح السحب فقط
//       if (state.withdrawSuccess) {
//         Navigator.pop(context);
//         context.read<AppServicesCubit>().resetWithdrawSuccess();
//       }
//     },
//     child: OperationBottomSheet(
//       config: config,
//       dropdownItems: names,
//       nameToId: map,
//       isSubmitting: context.watch<AppServicesCubit>().state.isSubmitting,

//       // ✅ ربط الحساب
//       onFromAccountIdChanged: cubit.fromAccountIdChanged,

//       // ✅ ربط اسم العملية
//       onOperationNameChanged: cubit.withdrawNameChanged,

//       // ✅ ربط المبلغ
//       onAmountChanged: cubit.withdrawAmountChanged,

//       // ✅ زر الإرسال (سحب فقط)
//       onSubmit: () {
//         cubit.submitWithdraw();
//       },
//     ),
//   ),
// );

//   }
Future<void> _openOperationWithAccounts(
  BuildContext context, {
  required OperationType type,
}) async {
  final cubit = context.read<AppServicesCubit>();
  await cubit.loadAccountsForSelect();

  final state = cubit.state;

  if (state.status == AppServicesStatus.error && state.message != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.message!)),
    );
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
      listenWhen: (p, c) =>
          (p.message != c.message && c.message != null) ||
          (p.withdrawSuccess != c.withdrawSuccess) ||
          (p.depositSuccess != c.depositSuccess),
      listener: (ctx, st) {
        if (st.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(st.message!)),
          );
        }

        final isSuccess = (type == OperationType.withdraw && st.withdrawSuccess)
            || (type == OperationType.deposit && st.depositSuccess);

        if (isSuccess) {
          Navigator.pop(sheetContext, true);

          if (type == OperationType.withdraw) {
            ctx.read<AppServicesCubit>().resetWithdrawSuccess();
          } else if (type == OperationType.deposit) {
            ctx.read<AppServicesCubit>().resetDepositSuccess();
          }
        }
      },
      child: OperationBottomSheet(
        config: config,
        dropdownItems: names,
        nameToId: map,
        isSubmitting: cubit.state.isSubmitting,
        onFromAccountIdChanged: cubit.fromAccountIdChanged,
        onOperationNameChanged: cubit.operationNameChanged, // (اسمها عام عندك)
        onAmountChanged: cubit.amountChanged,       // (اسمها عام عندك)
        onSubmit: () {
          if (type == OperationType.withdraw) {
            cubit.submitWithdraw();
          } else if (type == OperationType.deposit) {
            cubit.submitDeposit();
          }
        },
      ),
    ),
  ),
);

  if (result == true) {
    Navigator.pop(context, true);
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
                            onTap: () {
                              final config =
                                  operationConfigs[OperationType.transfer]!;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => OperationBottomSheet(
                                  config: config,
                                  isSubmitting: false,
                                  onSubmit: () {},
                                ),
                              );
                            },
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
                        ComplaintInformationWidget(
                          titleColor: AppColor.black,
                          image: AppImage.generateFile,
                          title: "توليد ملف",
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
                        ComplaintInformationWidget(
                          titleColor: AppColor.black,
                          image: AppImage.logout,
                          title: "تسجيل خروج",
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(width: 28),
                        ComplaintInformationWidget(
                          titleColor: AppColor.black,
                          image: AppImage.scheduling,
                          title: "جدولة",
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
