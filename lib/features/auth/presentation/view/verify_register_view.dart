import 'package:complaints_app/core/common%20widget/arrow_back.dart';
import 'package:complaints_app/core/common%20widget/custom_background_with_child.dart';
import 'package:complaints_app/core/common%20widget/custom_text_widget.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/custom_snackbar_validation.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:complaints_app/features/auth/presentation/manager/verify%20register/verify_register_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/verify%20register/verify_register_state.dart';
import 'package:complaints_app/features/auth/presentation/widget/otp_input_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class VerifyRegisterView extends StatelessWidget {
  final String email;

  const VerifyRegisterView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: VerifyRegisterViewBody()));
  }
}

class VerifyRegisterViewBody extends StatelessWidget {
  const VerifyRegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyRegisterCubit, VerifyRegisterState>(
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
            message: state.successMessage ?? "تم الأمر بنجاح",
            isSuccess: true,
          );
        }

        if (state.isSuccess) {
          showTopSnackBar(
            context,
            message: state.successMessage ?? "تم تأكيد الحساب بنجاح",
            isSuccess: true,
          );

          debugPrint(
            "im at VerifyRegisterViewBody view at BlocListener anddd verify reggg success ✅",
          );

          context.goNamed(AppRouteRName.welcomeView);
        }
      },

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
                "تاكيد الحساب",
                fontSize: SizeConfig.diagonal * .045,
              ),
              CustomTextWidget(
                "عزيزي المستخدم يرجى منك تأكيد بريدك الالكتروني عن طريق ادخال الرمز المكون من ست ارقام علما انك ستفقد الرمز الخاص بك في حال المغادرة",
                fontSize: SizeConfig.diagonal * .025,
                color: AppColor.middleGrey,
                textAlign: TextAlign.start,
              ),

              SizedBox(height: SizeConfig.height * .02),

              CustomBackgroundWithChild(
                borderRadius: BorderRadius.circular(20),
                width: double.infinity,
                backgroundColor: AppColor.lightGreen,
                child: CustomTextWidget("نحن نقوم باجراء احترازي فقط"),
              ),

              SizedBox(height: SizeConfig.height * .04),

              BlocBuilder<VerifyRegisterCubit, VerifyRegisterState>(
                builder: (context, state) {
                  return OtpInputSection(
                    isSubmitting: state.isSubmitting,
                    remainingSeconds: state.remainingSeconds,
                    onOtpChanged: (value) =>
                        context.read<VerifyRegisterCubit>().otpChanged(value),
                    onSubmit: () {
                      context.read<VerifyRegisterCubit>().submitOtp();
                      debugPrint("verifyy confirmmmm");
                    },
                    onResend: () {
                      debugPrint("resend codeee ");
                      debugPrint(
                        "email is ${context.read<VerifyRegisterCubit>().email}",
                      );

                      context.read<VerifyRegisterCubit>().resendCode();
                    },
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
