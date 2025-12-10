import 'package:complaints_app/features/splash%20and%20welcome/presentation/widget/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 225, 248),
      body: SafeArea(child: SplashViewBody()),
    );
  }
}
