import 'package:complaints_app/core/services/notification/global_keys.dart';
import 'package:flutter/material.dart';

class TopNotification {
  static void show({
    required String title,
    required String message,
    bool isSuccess = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = rootScaffoldMessengerKey.currentState;
    if (messenger == null) return;

    // نشيل أي بانرات قديمة
    messenger.clearMaterialBanners();

    final bgColor = isSuccess
        ? const Color(0xFF4CAF50) // أخضر للنجاح
        : const Color(0xFFF44336); // أحمر للخطأ

    final icon = isSuccess ? Icons.check_circle : Icons.error;

    final banner = MaterialBanner(
      backgroundColor: bgColor,
      elevation: 8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: Icon(icon, color: Colors.white),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            messenger.clearMaterialBanners();
          },
          icon: const Icon(Icons.close, color: Colors.white),
        ),
      ],
    );

    messenger.showMaterialBanner(banner);

    // إخفاء تلقائي بعد مدة
    Future.delayed(duration, () {
      messenger.clearMaterialBanners();
    });
  }
}