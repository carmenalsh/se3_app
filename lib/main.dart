import 'dart:developer';

import 'package:complaints_app/core/config/app_router.dart';
import 'package:complaints_app/core/services/notification/global_keys.dart';
import 'package:complaints_app/core/services/notification/notification_service.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/databases/cache/cache_helper.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:complaints_app/core/utils/auth_session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   debugPrint('📩 BG title: ${message.notification?.title}');
// }

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('🔔 رسالة بالخلفية: ${message.notification?.title}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
   //await CacheHelper.clearData();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  //FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Future.wait([
    // PushNotificationService.init(),
    // LocalNotificationService.init(),
  ]);
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // // جلب الـ FCM Token وعرضه باللوق
  // final token = await FirebaseMessaging.instance.getToken();
  // log('📲 FCM Token: $token');
await NotificationService.init();


  runApp(const ComplaitsApp());
}

//======================= Hi 👀 ============================
class ComplaitsApp extends StatefulWidget {
  const ComplaitsApp({super.key});

  @override
  State<ComplaitsApp> createState() => _ComplaitsAppState();
}

class _ComplaitsAppState extends State<ComplaitsApp> {
  @override
  void initState() {
    super.initState();
    AuthSession.instance.isAuthenticated.addListener(_onAuthChanged);
  }

  void _onAuthChanged() {
    final isAuth = AuthSession.instance.isAuthenticated.value;
    if (!isAuth) {
      AppRourer.router.goNamed(AppRouteRName.loginView);
    }
  }

  @override
  void dispose() {
    AuthSession.instance.isAuthenticated.removeListener(_onAuthChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: ThemeData().copyWith(scaffoldBackgroundColor: AppColor.white),
      routerConfig: AppRourer.router,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
