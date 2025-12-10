import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/features/app_services/presentation/widget/divider_widget.dart';
import 'package:complaints_app/features/app_services/presentation/widget/operation_bottom_sheet.dart';
import 'package:complaints_app/features/app_services/presentation/widget/services_types.dart';
import 'package:flutter/material.dart';

class AppServicesPage extends StatelessWidget {
  const AppServicesPage({super.key});

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
                            onTap: () {
                              final config =
                                  operationConfigs[OperationType.withdraw]!;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) =>
                                    OperationBottomSheet(config: config),
                              );
                            },
                            child: ComplaintInformationWidget(
                              titleColor: AppColor.black,
                              image: AppImage.withdraw,
                              title: 'سحب',
                            ),
                          ),
                          SizedBox(width: 25),
                          DividerWidget(),
                          SizedBox(width: 25),
                          InkWell(
                            onTap: () {
                              final config =
                                  operationConfigs[OperationType.deposit]!;
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) =>
                                    OperationBottomSheet(config: config),
                              );
                            },
                            child: ComplaintInformationWidget(
                              titleColor: AppColor.black,
                              image: AppImage.desposit,
                              title: 'ايداع',
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
                                builder: (_) =>
                                    OperationBottomSheet(config: config),
                              );
                            },
                            child: ComplaintInformationWidget(
                              titleColor: AppColor.black,
                              image: AppImage.transformation,
                              title: 'تحويل',
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
                          title: 'توليد ملف',
                        ),
                        SizedBox(width: 16),
                        DividerWidget(),
                        SizedBox(width: 23),
                        ComplaintInformationWidget(
                          titleColor: AppColor.black,
                          image: AppImage.notification,
                          title: 'اشعارات',
                        ),
                        SizedBox(width: 24),
                        DividerWidget(),
                        SizedBox(width: 12),
                        ComplaintInformationWidget(
                          titleColor: AppColor.black,
                          image: AppImage.logout,
                          title: 'تسجيل خروج',
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
                          title: 'جدولة',
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
