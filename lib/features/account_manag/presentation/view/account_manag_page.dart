import 'package:complaints_app/core/adapters/feed/account_feed_adapter.dart';
import 'package:complaints_app/core/common%20widget/card_details_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/account_manag/presentation/manager/account_manag_cubit.dart';
import 'package:complaints_app/features/account_manag/presentation/manager/account_manag_state.dart';
import 'package:complaints_app/core/common%20widget/operation_bottom_sheet.dart';
import 'package:complaints_app/core/common%20widget/type_transaction_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountManagPage extends StatelessWidget {
  const AccountManagPage({super.key});
  final accountStatusItems = const ["نشط", "مجمد", "موقوف", "مغلق"];
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountManagCubit, AccountManagState>(
      listenWhen: (p, c) =>
          p.updateSuccess != c.updateSuccess && c.updateSuccess,
      listener: (context, state) {
        // Navigator.pop(context);
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: "ادارة حساباتك",
              onPressed: () {
                context.pop(true);
              },
            ),
            SizedBox(height: SizeConfig.height * .01),
            Expanded(
              child: BlocBuilder<AccountManagCubit, AccountManagState>(
                builder: (context, state) {
                  if (state.status == AccountManagStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == AccountManagStatus.error) {
                    return Center(child: Text(state.message ?? 'حدث خطأ ما'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    itemCount: state.accounts.length,
                    itemBuilder: (context, index) {
                      final acc = state.accounts[index];
                      final item = AccountToFeedAdapter.adapt(acc);

                      return CardDetaisWidget(
                        title: item.title,
                        status: item.typeText ?? '',
                        amount: item.subtitle,
                        date: item.dateText,
                        numberAccount: item.accountNumber ?? '',
                        accountState: item.statusText ?? '',
                        accountDescreption: item.description ?? '',
                        accountStateColor: stutesAccountColor(
                          item.statusText ?? '',
                        ),
                        statusColor: accountTypeColor(item.typeText ?? ''),
                        editIcon: Icons.edit_document,
                        fontSize: SizeConfig.diagonal * .024,
                        onTapEditAccount: () {
                          final config =
                              operationConfigs[OperationType.editAccount]!;
                          const accountStatusItems = [
                            "نشط",
                            "مجمد",
                            "موقوف",
                            "مغلق",
                          ];

                          final cubit = context.read<AccountManagCubit>();
                          cubit.startEdit(acc);

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (sheetContext) {
                              return BlocProvider.value(
                                value: cubit,
                                child:
                                    BlocListener<
                                      AccountManagCubit,
                                      AccountManagState
                                    >(
                                      listenWhen: (p, c) =>
                                          p.updateSuccess != c.updateSuccess ||
                                          p.message != c.message,
                                      listener: (ctx, state) {
                                        if (state.message != null) {
                                          showTopSnackBar(
                                            context,
                                            message: state.message!,
                                            isSuccess: false,
                                          );
                                        }

                                        if (state.updateSuccess) {
                                          showTopSnackBar(
                                            context,
                                            message: state.message!,
                                            isSuccess: true,
                                          );
                                          Navigator.of(sheetContext).pop();
                                          cubit.resetUpdateFlag();
                                        }
                                      },
                                      child:
                                          BlocBuilder<
                                            AccountManagCubit,
                                            AccountManagState
                                          >(
                                            builder: (ctx, state) {
                                              return OperationBottomSheet(
                                                config: config,
                                                dropdownItems:
                                                    accountStatusItems,
                                                initialAccountName: acc.name,
                                                initialStatus: acc.status,
                                                initialDescription:
                                                    acc.description,

                                                isSubmitting:
                                                    state.isSubmitting,
                                                onSubmit: () =>
                                                    cubit.submitUpdateAccount(),
                                                onNameChanged:
                                                    cubit.editNameChanged,
                                                onDescriptionChanged: cubit
                                                    .editDescriptionChanged,
                                                onDropdownChanged: (v) {
                                                  if (v != null)
                                                    cubit.editStatusChanged(v);
                                                },
                                              );
                                            },
                                          ),
                                    ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButtonWidget(
                width: double.infinity,
                backgroundColor: AppColor.primary,
                childHorizontalPad: SizeConfig.width * .07,
                childVerticalPad: SizeConfig.height * .011,
                borderRadius: 10,
                onTap: () async {
                  final result = await context.pushNamed(
                    AppRouteRName.createAccount,
                  );

                  if (result == true && context.mounted) {
                    context
                        .read<AccountManagCubit>()
                        .getAccounts(); // refresh فوري
                  }
                },

                child: CustomTextWidget(
                  "انشاء حساب",
                  fontSize: SizeConfig.height * .027,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
