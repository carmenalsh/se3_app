import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/core/common%20widget/card_details_widget.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_card_shimmer_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/top_part_home.dart';
import 'package:complaints_app/features/home/presentation/widgets/type_transaction_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: HomeViewBody()));
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopPartHome(
          
          onTapServices: () async {
            final changed = await context.pushNamed<bool>(
              AppRouteRName.showServices,
            );

            if (changed == true) {
              context.read<HomeCubit>().refreshTransactions();
            }
          },

          onTapAccountsManag: () {
            context.pushNamed(AppRouteRName.accountManag);
          },
        ),

        SizedBox(height: SizeConfig.height * .016),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextWidget(
                "سجل المعاملات المالية",
                fontSize: SizeConfig.diagonal * .038,
                color: AppColor.black,
              ),
            ],
          ),
        ),

        SizedBox(height: SizeConfig.height * .001),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.status == HomeStatusEnum.loading &&
                  state.transActions.isEmpty) {
                return const Center(child: ComplaintsShimmerList());
              }
              if (state.status == HomeStatusEnum.error &&
                  state.transActions.isEmpty) {
                return Center(
                  child: CustomTextWidget(
                    state.message ?? 'حدث خطأ ما',
                    color: AppColor.red,
                  ),
                );
              }
              if (state.transActions.isEmpty) {
                return Center(
                  child: CustomTextWidget(
                    'لا توجد معاملات مالية حالياً',
                    color: AppColor.middleGrey,
                  ),
                );
              }
              final transActions = state.transActions;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                itemCount: transActions.length + (state.canLoadMore ? 1 : 0),
                separatorBuilder: (_, _) =>
                    SizedBox(height: SizeConfig.height * .005),
                itemBuilder: (context, index) {
                  if (state.canLoadMore && index == transActions.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButtonWidget(
                          onTap: () {
                            context.read<HomeCubit>().loadMoreTransAction();
                          },
                          backgroundColor: AppColor.primary,
                          borderRadius: 10,
                          childVerticalPad: 4,
                          childHorizontalPad: 12,
                          child: state.isLoadingMore
                              ? const SizedBox(
                                  // height: 20,
                                  // width: 20,
                                  child: CircularProgressIndicator(
                                    padding: EdgeInsets.symmetric(
                                      //vertical: 10,
                                      horizontal: 20,
                                    ),
                                    strokeWidth: 2,
                                    color: AppColor.white,
                                  ),
                                )
                              : CustomTextWidget(
                                  'عرض المزيد',
                                  color: AppColor.white,
                                  fontSize: SizeConfig.diagonal * .025,
                                ),
                        ),
                      ),
                    );
                  }
                  final transAction = transActions[index];

                  final statusText = transAction.type;
                  final statusColor = typeTransActionColor(statusText);
                  return GestureDetector(
                    onTap: () {},
                    child: CardDetaisWidget(
                      onTapEditAccount: () {},
                      title: transAction.name,
                      status: statusText,
                      numberAccount:
                          statusText == "سحب" || statusText == "تحويل"
                          ? transAction.fromAccountNumber!
                          : transAction.toAccountNumber!,
                      statusColor: statusColor,
                      toAccount: statusText == "تحويل"
                          ? transAction.toAccountNumber
                          : null,
                      fontSize: SizeConfig.diagonal * .024,
                      amount: transAction.amount,
                      date: transAction.executedAt,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class LabelColumnTitleValue extends StatelessWidget {
  const LabelColumnTitleValue({
    super.key,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  final String label;
  final String value;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          label,
          fontSize: SizeConfig.diagonal * .02,
          color: AppColor.middleGrey,
        ),
        CustomTextWidget(
          value,
          textAlign: TextAlign.right,
          fontSize: SizeConfig.diagonal * .022,
          color: AppColor.black,
          maxLines: maxLines,
          overflow: maxLines != null ? TextOverflow.ellipsis : null,
        ),
      ],
    );
  }
}


