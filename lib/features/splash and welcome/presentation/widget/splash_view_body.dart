import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/databases/cache/token_storage.dart';
import 'package:complaints_app/core/theme/assets/fonts.dart';
import 'package:complaints_app/core/theme/assets/images.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/auth_session.dart';
import 'package:complaints_app/core/utils/media_query_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewbodyState();
}

class _SplashViewbodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AppImage.splashLogo,
            height: SizeConfig.height * 0.25,
            width: SizeConfig.width * .5,
          ),
        ),
        Text(
          "نقد",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.tasees,
            fontSize: SizeConfig.height * 0.042,
          ),
        ),
        Divider(
          endIndent: SizeConfig.height * 0.12,
          indent: SizeConfig.height * 0.12,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      animationController.forward();
    });
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 4), () async {
      if (!mounted) return;

      final token = TokenStorage.getAccessToken();
      final expiry = TokenStorage.getAccessTokenExpiry();

      final hasValidToken =
          token != null &&
          token.isNotEmpty &&
          expiry != null &&
          DateTime.now().isBefore(expiry);

      if (hasValidToken) {
        AuthSession.instance.markAuthenticated();

        context.goNamed(AppRouteRName.homeView);
      } else {
        AuthSession.instance.markUnauthenticated();
        context.goNamed(AppRouteRName.welcomeView);
      }
    });
  }
}

class SlidingText extends StatelessWidget {
  const SlidingText({super.key, required this.slidingAnimation});

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Text(
            "تطبيق المعاملات المالية",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.height * 0.035,
              fontFamily: AppFonts.reemKufi,
              color: AppColor.primary,
            ),
          ),
        );
      },
    );
  }
}
