import 'package:complaints_app/core/common%20widget/account_picker_field.dart';
import 'package:complaints_app/core/common%20widget/custom_app_bar.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/create_account/presentation/manager/create_account_cubit.dart';
import 'package:complaints_app/features/create_account/presentation/manager/create_account_state.dart';
import 'package:complaints_app/features/create_account/presentation/widget/custom_description_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});
  String? selectedAccount;

  final accounts = const [
    "حساب جاري - 1234",
    "حساب توفير - 5678",
    "حساب استثمار - 9999",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        final cubit = context.read<CreateAccountCubit>();

        return Scaffold(
          body: Column(
            children: [
              CustomAppBar(title: "انشاء حساب"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: AuthFieldLabel(
                          label: "اسم الحساب",
                          hint: "ادخل اسم الحساب الخاص بك...",
                          suffixIcon: Icons.edit_document,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            // context.read<SubmitComplaintCubit>().titleChanged(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: AccountsDropdownField(
                          label: "نوع الحساب",
                          hint: "اختار نوع الحساب...",
                          hintFontSize: 14,
                          selectedValue: state.selectedAccount,
                          items: state.accounts,
                          onChanged: cubit.accountChanged,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: CustomDescriptionTextFiels(
                          label: "وصف الحساب",
                          controller: cubit.descriptionController,
                          maxLines: 3,
                          maxLength: 512,
                          suffixIcon: Icons.layers_outlined,
                          keyboardType: TextInputType.multiline,
                          onChanged: cubit.descriptionChanged,
                          hint: "ادخل وصفا للحساب الخاص بك...",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: AuthFieldLabel(
                          label: "المبلغ",
                          hint: "ادخل مبلغا تريد ايداعه في الحساب...",
                          suffixIcon: Icons.credit_card,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            // context.read<SubmitComplaintCubit>().titleChanged(value);
                          },
                        ),
                      ),
                    ],
                  ),
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
                    // if (_formKey.currentState?.validate() ?? false) {
                    //   debugPrint("im at confirm log innnnnn");
                    //   context.read<LoginCubit>().loginSubmitted();
                    // }
                  },
                  child: CustomTextWidget(
                    "تأكيد الارسال",
                    fontSize: SizeConfig.height * .025,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
