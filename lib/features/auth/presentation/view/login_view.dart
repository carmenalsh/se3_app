import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_button_widget.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/auth_field_label.dart';
import 'package:complaints_app/features/auth/presentation/widget/tow_text_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LogInViewBody()));
  }
}

class LogInViewBody extends StatelessWidget {
  LogInViewBody({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
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
            message:
                state.successMessage ??
                "تم تسجيل الدخول بنجاح، أهلاً بك مجدداً",
            isSuccess: true,
          );
          debugPrint("im at login view at BlocListener anddd Login success ✅");
          context.goNamed(AppRouteRName.homeView, extra: state.successMessage);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height * .02),
                ArrowBack(),

                SizedBox(height: SizeConfig.height * .04),

                SvgPicture.asset(
                  AppImage.splashLogo,
                  height: SizeConfig.height * .07,
                ),
                CustomTextWidget(
                  "تسجيل الدخول",
                  fontSize: SizeConfig.diagonal * .045,
                ),
                CustomTextWidget(
                  "مرحبا بك مجددا سجل دخولك وقم بإدارة اموالك بطريقة ذكية وعصرية",
                  fontSize: SizeConfig.diagonal * .025,
                  color: AppColor.middleGrey,
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: SizeConfig.height * .02),

                AuthFieldLabel(
                  label: "البريد الالكتروني",
                  hint: 'ادخل بريدك الالكتروني...',
                  suffixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,

                  onChanged: (value) {
                    context.read<LoginCubit>().emailChanged(value);
                    debugPrint("im at email field and val isss $value");
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد';
                    }
                    return null;
                  },
                ),

                SizedBox(height: SizeConfig.height * .01),

                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return AuthFieldLabel(
                      label: "كلمة المرور",
                      hint: 'ادخل كلمة المرور...',
                      suffixIcon: state.isPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      obscureText: state.isPasswordObscure,
                      onChanged: (value) {
                        context.read<LoginCubit>().passwordChanged(value);
                        debugPrint("im at passss field and val isss $value");
                      },
                      onSuffixTap: () {
                        context.read<LoginCubit>().togglePasswordVisibility();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    );
                  },
                ),

                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(AppRouteRName.forgotPasswordEmailView);
                    },
                    child: CustomTextWidget(
                      "نسبت كلمة المرور ؟",
                      fontSize: SizeConfig.diagonal * .03,
                      color: AppColor.primary,
                    ),
                  ),
                ),

                SizedBox(height: SizeConfig.height * .06),

                BlocBuilder<LoginCubit, LoginState>(
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
                          debugPrint("im at confirm log innnnnn");
                          context.read<LoginCubit>().loginSubmitted();
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

                SizedBox(height: SizeConfig.height * .02),

                TowTextRow(
                  text: "ليس لديك حساب ؟ قم بإنشاء ",
                  actionText: "حساب جديد",
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).replaceNamed(AppRouteRName.registerView);
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
