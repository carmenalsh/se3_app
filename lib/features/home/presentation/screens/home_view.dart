import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:complaints_app/features/home/presentation/widgets/card_details_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_Card_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/complaint_card_shimmer_widget.dart';
import 'package:complaints_app/features/home/presentation/widgets/show_notification_bottom_sheet.dart';
import 'package:complaints_app/features/home/presentation/widgets/top_part_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: BlocListener<LogoutCubit, LogoutState>(
        //   listenWhen: (prev, curr) => prev.status != curr.status,
        //   listener: (context, state) {
        //     if (state.status == LogoutStatusEnum.success) {
        //       context.goNamed(AppRouteRName.welcomeView);
        //     }

        //     if (state.status == LogoutStatusEnum.error) {
        //       showTopSnackBar(
        //         context,
        //         message: state.message ?? 'حدث خطأ أثناء تسجيل الخروج',
        //         isSuccess: false,
        //       );
        //     }
        //   },
        child: HomeViewBody(),
        //),
      ),
    );
  }
}

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopPartHome(
          onChangedSearch: (value) {
            // context.read<HomeCubit>().searchTextChanged(value);
          },
          onTapServices: () {
            // debugPrint("loggg outtttt");
            // context.read<LogoutCubit>().logOutSubmitted();
             context.pushNamed(AppRouteRName.showServices);
          },

          onTapNotification: () {
            // final dummyNotifications = <NotificationItem>[
            //   const NotificationItem(
            //     title: 'تم تسجيل شكوى جديدة',
            //     body:
            //         'تم استلام شكواك وسيتم تحويلها إلى الجهة المختصة للمعالجة.',
            //     date: 'منذ دقيقة',
            //   ),
            //   const NotificationItem(
            //     title: 'تحديث حالة الشكوى رقم 11',
            //     body: 'تم تغيير حالة الشكوى إلى: قيد المعالجة.',
            //     date: 'قبل 10 دقائق',
            //   ),
            //   const NotificationItem(
            //     title: 'تم إغلاق الشكوى رقم 8',
            //     body: 'تمت معالجة الشكوى وإغلاقها. شكراً لتعاونك.',
            //     date: 'اليوم - 10:30 ص',
            //   ),
            // ];

            // showNotificationsBottomSheet(parentContext: context);
          },

          onSearchTap: (query) {
            // context.read<HomeCubit>().searchComplaint(query);
          },
          onTapCancel: () {
            // context.read<HomeCubit>().cancelSearch();
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

        SizedBox(height: SizeConfig.height * .01),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              GestureDetector(
                onTap:
                    ()
                    // async
                    {
                      // final complaintId = complaint.id;

                      // final result = await context.pushNamed<bool>(
                      //   AppRouteRName.complaintDetailsView,
                      //   pathParameters: {'id': complaintId.toString()},
                      // );

                      // if (result == true) {
                      //   context.read<HomeCubit>().loadComplaints();
                      // }
                    },

                // child: ComplaintCard(
                //   title: complaint.title,
                //   statusText: statusText,
                //   statusColor: statusColor,
                //   number: complaint.number.toString(),
                //   description: complaint.description,
                // ),
                child: CardDetaisWidget(
                  title: 'مشتريات منزل',
                  status: 'سحب',
                  numberAccount: '129002',
                  // descreption: '129002',
                  titleLocation: 'المبلغ',
                  location: '',
                  statusColor: AppColor.statusGrey,
                  fontSize: SizeConfig.diagonal * .024,
                  amount: '200.00 ألف ليرة سورية',
                  date: '12/04/2025',
                ),
              ),

              // ;
              //   },
              // ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: CardDetaisWidget(
                  title: 'مشتريات منزل',
                  status: 'تحويل',
                  //titleDescreption: 'رقم الحساب',
                  //descreption: '129002',
                  titleLocation: 'المبلغ',
                  numberAccount: '129002',
                  location: '',
                  statusColor: AppColor.green,
                  fontSize: SizeConfig.diagonal * .024,
                  amount: '200.00 ألف ليرة سورية',
                  date: '12/04/2025',
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: CardDetaisWidget(
                  title: 'مشتريات منزل',
                  status: 'ايداع',
                  //titleDescreption: 'رقم الحساب',
                  // descreption: '129002',
                  numberAccount: '129002',
                  titleLocation: 'المبلغ',
                  location: '',
                  statusColor: AppColor.blue,
                  fontSize: SizeConfig.diagonal * .024,
                  amount: '200.00 ألف ليرة سورية',
                  date: '12/04/2025',
                  toAccount: '229002',
                ),
              ),
            ],
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

Color _mapStatusColor(String status) {
  switch (status) {
    case 'معلقة':
      return AppColor.middleGrey;
    case 'قيد المعالجة':
      return AppColor.blue;
    case 'تم معالجتها':
      return AppColor.green;
    case 'تم رفضها':
      return AppColor.red;
    default:
      return AppColor.middleGrey;
  }
}
