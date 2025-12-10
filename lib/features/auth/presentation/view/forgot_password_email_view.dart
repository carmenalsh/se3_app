import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/auth/presentation/widget/common_top_part_forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordEmailView extends StatelessWidget {
  const ForgotPasswordEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ForgetPasswordEmailViewBody()));
  }
}

class ForgetPasswordEmailViewBody extends StatelessWidget {
  ForgetPasswordEmailViewBody({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (prev, curr) =>
          curr.errorMessage != null
          //prev.errorMessage != curr.errorMessage
          ||
          prev.isSuccess != curr.isSuccess,
      listener: (context, state) {
        final route = ModalRoute.of(context);
        if (route == null || !route.isCurrent) return;
        if (state.errorMessage != null) {
          showTopSnackBar(
            context,
            message: state.errorMessage ?? "حدث خطأ غير متوقع",
            isSuccess: false,
          );
        }

        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? "تم إرسال رمز التحقق إلى بريدك",
            isSuccess: true,
          );
          debugPrint("ForgetPassword  Email success ✅");
          context.read<ForgotPasswordCubit>().resetStatus();
          context.pushNamed(AppRouteRName.forgotPasswordOtpCodeView);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTopPartForgetPassword(
                  title: "نسيت كلمة المرور ؟",
                  bodyText:
                      "يرجى ادخال عنوان بريدك\n الالكتروني لتتلقى رمز التحقق عليه",
                  img: AppImage.forgetPass1,
                  imgHeight: SizeConfig.height * .3,
                ),

                SizedBox(height: SizeConfig.height * .04),

                AuthFieldLabel(
                  label: "البريد الالكتروني",
                  hint: 'ادخل بريدك الالكتروني...',
                  suffixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,

                  onChanged: (value) {
                    context.read<ForgotPasswordCubit>().emailChanged(value);
                    debugPrint("im at email field and val isss $value");
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد';
                    }
                    return null;
                  },
                ),

                SizedBox(height: SizeConfig.height * .06),

                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state.isSubmitting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButtonWidget(
                      width: double.infinity,
                      backgroundColor: AppColor.primary,
                      childHorizontalPad: SizeConfig.width * .07,
                      childVerticalPad: SizeConfig.height * .012,
                      borderRadius: 10,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<ForgotPasswordCubit>().submitEmail();
                          debugPrint("im at forget emailllllll ");
                        }
                      },
                      child: CustomTextWidget(
                        "تأكيد الإدخال",
                        fontSize: SizeConfig.height * .025,
                        color: AppColor.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
