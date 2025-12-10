import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/common_top_part_forget_password.dart';
import 'package:complaints_app/features/auth/presentation/widget/otp_input_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordOtpCodeView extends StatelessWidget {
  const ForgetPasswordOtpCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: ForgetPasswordOtpCodeViewBody()),
    );
  }
}

class ForgetPasswordOtpCodeViewBody extends StatefulWidget {
  const ForgetPasswordOtpCodeViewBody({super.key});

  @override
  State<ForgetPasswordOtpCodeViewBody> createState() =>
      _ForgetPasswordOtpCodeViewBodyState();
}

class _ForgetPasswordOtpCodeViewBodyState
    extends State<ForgetPasswordOtpCodeViewBody> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.resetStatus();
    cubit.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (prev, curr) =>
          prev.errorMessage != curr.errorMessage ||
          prev.isSuccess != curr.isSuccess ||
          prev.successMessage != curr.successMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          showTopSnackBar(
            context,
            message: state.errorMessage ?? "حدث خطأ غير متوقع",
            isSuccess: false,
          );
        }

        if (state.successMessage != null && !state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? "تم إرسال رمز جديد إلى بريدك",
            isSuccess: true,
          );
        }

        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? "تم تأكيد الرمز بنجاح",
            isSuccess: true,
          );

          debugPrint(
            "im at ForgetPasswordOtpCodeViewBody BlocListener and success ✅",
          );
          context.read<ForgotPasswordCubit>().resetStatus();
          context.pushNamed(AppRouteRName.forgotPasswordNewPasswordView);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommonTopPartForgetPassword(
                title: "تأكيد البريد المدخل",
                bodyText:
                    "الرجاء ادخال الرمز المكون من ستة \nأرقام الى بريدك الخاص",
                img: AppImage.forgetPass1,
                imgHeight: SizeConfig.height * .3,
              ),
              SizedBox(height: SizeConfig.height * .04),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                builder: (context, state) {
                  return OtpInputSection(
                    isSubmitting: state.isSubmitting,
                    remainingSeconds: state.remainingSeconds,
                    onOtpChanged: (value) =>
                        context.read<ForgotPasswordCubit>().otpChanged(value),
                    onSubmit: () {
                      context.read<ForgotPasswordCubit>().submitOtp();
                      debugPrint("confirmm otp ");
                    },
                    onResend: () =>
                        context.read<ForgotPasswordCubit>().resendCode(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
