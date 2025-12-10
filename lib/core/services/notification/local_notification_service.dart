// import 'dart:async';
// import 'dart:convert';

// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static StreamController<NotificationResponse> streamController =
//       StreamController.broadcast();

//   static void onTap(NotificationResponse notificationResponse) {
//     streamController.add(notificationResponse);
//   }

//   static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
//     'high_importance_channel', 
//     'High Importance Notifications', 
//     description: 'Channel for important notifications',
//     importance: Importance.high,
//     playSound: true,
//   );

//   static Future<void> init() async {
//     const androidSettings = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );

//     const iosSettings = DarwinInitializationSettings();

//     const settings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(_channel);

//     await flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: onTap,
//       onDidReceiveBackgroundNotificationResponse: onTap,
//     );
//   }

//   static Future<void> showBasicNotification(RemoteMessage message) async {
//     final android = AndroidNotificationDetails(
//       _channel.id,
//       _channel.name,
//       channelDescription: _channel.description,
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//     );

//     final details = NotificationDetails(android: android);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title ?? 'إشعار جديد',
//       message.notification?.body ?? '',
//       details,
//     );
//   }


// }
