import 'package:complaints_app/core/common%20widget/card_details_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/enums/operation_type.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/app_services/presentation/widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountManagPage extends StatelessWidget {
  const AccountManagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: "ادارة حساباتك"),
          SizedBox(height: SizeConfig.height * .01),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              children: [
                CardDetaisWidget(
                  title: "حسابي الاساسي",
                  status: "توفير",
                  editIcon: Icons.edit_document,
                  fontSize: SizeConfig.diagonal * .024,
                  amount: "200.00 ألف ليرة سورية",
                  date: "12/04/2025",
                  numberAccount: "129002",
                  statusColor: AppColor.blue,
                  accountState: "نشط",
                  accountDescreption:
                      "هذا الحساب مخصص لمدفوعات المنزل للعام الحالي وفيه كل شيء يخص المشتريات",
                  onTapEditAccount: () {
                    final config = operationConfigs[OperationType.editAccount]!;
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => OperationBottomSheet(config: config),
                    );
                  },
                ),
                CardDetaisWidget(
                  title: "حسابي الاساسي",
                  status: "توفير",
                  editIcon: Icons.edit_document,
                  fontSize: SizeConfig.diagonal * .024,
                  amount: "200.00 ألف ليرة سورية",
                  date: "12/04/2025",
                  numberAccount: "129002",
                  statusColor: AppColor.blue,
                  accountState: "نشط",
                  accountStateColor: AppColor.blue,
                  accountDescreption:
                      "هذا الحساب مخصص لمدفوعات المنزل للعام الحالي وفيه كل شيء يخص المشتريات",
                  onTapEditAccount: () {
                    final config = operationConfigs[OperationType.editAccount]!;
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => OperationBottomSheet(config: config),
                    );
                  },
                ),
                CardDetaisWidget(
                  title: "حسابي الاساسي",
                  status: "توفير",
                  editIcon: Icons.edit_document,
                  fontSize: SizeConfig.diagonal * .024,
                  amount: "200.00 ألف ليرة سورية",
                  date: "12/04/2025",
                  numberAccount: "129002",
                  statusColor: AppColor.blue,
                  accountState: "نشط",
                  accountDescreption:
                      "هذا الحساب مخصص لمدفوعات المنزل للعام الحالي وفيه كل شيء يخص المشتريات",
                  onTapEditAccount: () {
                    final config = operationConfigs[OperationType.editAccount]!;
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => OperationBottomSheet(config: config),
                    );
                  },
                ),
              ],
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
              onTap: () {
                context.pushNamed(AppRouteRName.createAccount);
                // if (_formKey.currentState?.validate() ?? false) {
                //   debugPrint("im at confirm log innnnnn");
                //   context.read<LoginCubit>().loginSubmitted();
                // }
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
    );
  }
}
