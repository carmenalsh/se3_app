// import 'dart:developer';

// import 'package:complaints_app/core/services/notification/local_votification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// class PushNotificationService {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;

//   static Future<void> init() async {
//     final settings = await messaging.requestPermission();
//     debugPrint('🔐 FCM permission: ${settings.authorizationStatus}');

//     final token = await messaging.getToken();
//     log("📲 FCM token is : $token");

//     _handleForegroundMessages();

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('📬 onMessageOpenedApp: ${message.messageId}');
//     });
//   }

//   static void _handleForegroundMessages() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('🚀 ENTERED onMessage (foreground)');
//       debugPrint('📩 title: ${message.notification?.title}');
//       debugPrint('📩 body : ${message.notification?.body}');

//       LocalNotificationService.showBasicNotification(message);
//     });
//   }
// }
