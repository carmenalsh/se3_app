// import 'package:complaints_app/core/common widget/custom_background_with_child.dart';
// import 'package:complaints_app/core/common widget/custom_text_widget.dart';
// import 'package:complaints_app/core/theme/color/app_color.dart';
// import 'package:complaints_app/core/utils/media_query_config.dart';
// import 'package:complaints_app/features/home/domain/entities/complaint_entity/notification_entity.dart';
// import 'package:complaints_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void showNotificationsBottomSheet({
//   required BuildContext parentContext,
//   String title = 'الإشعارات',
// }) {
//   final homeCubit = parentContext.read<HomeCubit>();

//   homeCubit.loadNotifications();

//   showModalBottomSheet(
//     context: parentContext,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black.withOpacity(0.2),
//     elevation: 0,
//     builder: (ctx) {
//       final height = SizeConfig.height * 0.6;

//       return BlocProvider.value(
//         value: homeCubit,
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: SafeArea(
//             top: false,
//             child: Container(
//               height: height,
//               padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
//               decoration: BoxDecoration(
//                 color: AppColor.white,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(32),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     width: SizeConfig.width * .17,
//                     height: 5,
//                     decoration: BoxDecoration(
//                       color: Colors.black12,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),

//                   SizedBox(height: SizeConfig.height * .01),

//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColor.lightGreen.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: CustomTextWidget(
//                       title,
//                       fontSize: SizeConfig.diagonal * .028,
//                       color: AppColor.primary,
//                     ),
//                   ),

//                   const SizedBox(height: 8),
//                   const Divider(thickness: 1, color: Colors.black12),

//                   Expanded(
//                     child: BlocBuilder<HomeCubit, HomeState>(
//                       builder: (context, state) {
//                         if (state.isNotificationsLoading) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         if (state.notificationsErrorMessage != null) {
//                           return Center(
//                             child: CustomTextWidget(
//                               state.notificationsErrorMessage!,
//                               color: AppColor.red,
//                             ),
//                           );
//                         }

//                         final list = state.notifications;
//                         if (list.isEmpty) {
//                           return Center(
//                             child: CustomTextWidget(
//                               "لا توجد إشعارات حالياً",
//                               color: AppColor.middleGrey,
//                               fontSize: SizeConfig.diagonal * .026,
//                             ),
//                           );
//                         }

//                         return _buildNotificationsBody(context, list);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// Widget _buildNotificationsBody(
//   BuildContext context,
//   List<NotificationEntity> list,
// ) {
//   return ListView.separated(
//     padding: const EdgeInsets.symmetric(vertical: 8),
//     itemCount: list.length,
//     separatorBuilder: (_, __) => Padding(
//       padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * .15),
//       child: Divider(color: AppColor.grey, thickness: 1),
//     ),
//     itemBuilder: (context, index) {
//       final n = list[index];

//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomBackgroundWithChild(
//             borderRadius: BorderRadius.circular(30),
//             height: SizeConfig.width * .12,
//             width: SizeConfig.width * .12,
//             backgroundColor: const Color(0xFFF5F8FF),
//             child: Icon(
//               Icons.notifications_none,
//               color: AppColor.primary,
//               size: SizeConfig.width * .07,
//             ),
//           ),

//           SizedBox(width: SizeConfig.width * .03),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextWidget(
//                   n.title,
//                   fontSize: SizeConfig.diagonal * .025,
//                   color: AppColor.black,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 SizedBox(height: SizeConfig.height * .003),

//                 CustomTextWidget(
//                   n.body,
//                   fontSize: SizeConfig.diagonal * .021,
//                   color: AppColor.middleGrey,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.right,
//                 ),

//                 SizedBox(height: SizeConfig.height * .004),

//                 Row(
//                   children: [
//                     Icon(
//                       Icons.access_time,
//                       size: SizeConfig.diagonal * .018,
//                       color: AppColor.middleGrey,
//                     ),
//                     SizedBox(width: SizeConfig.width * .01),
//                     CustomTextWidget(
//                       n.date,
//                       fontSize: SizeConfig.diagonal * .019,
//                       color: AppColor.middleGrey,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
