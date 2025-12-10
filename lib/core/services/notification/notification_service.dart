import 'dart:developer';
import 'package:complaints_app/core/common%20widget/top_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:complaints_app/core/services/notification/global_keys.dart';

class NotificationService {
  static Future<void> init() async {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final token = await FirebaseMessaging.instance.getToken();
    log('📲 FCM Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? 'إشعار جديد';
      final body = message.notification?.body ?? '';

      log('📨 onMessage (foreground): $title - $body');

      // ✅ ما نستخدم context، نستعمل الـ ScaffoldMessenger العالمي
      TopNotification.show(
        title: title,
        message: body,
        isSuccess: true, // لاحقاً تقدر تغيّرها حسب نوع الإشعار
        duration: const Duration(seconds: 3),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('📨 onMessageOpenedApp: ${message.data}');
    });
  }

  // static Future<void> _firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   await Firebase.initializeApp();
  //   log('🔔 رسالة بالخلفية: ${message.notification?.title}');
  // }
}