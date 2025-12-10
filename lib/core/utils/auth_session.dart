import 'package:flutter/foundation.dart';

class AuthSession {
  AuthSession._();
  static final instance = AuthSession._();

  /// ValueNotifier تنبيه الواجهة عند تغير الحالة
  final ValueNotifier<bool> isAuthenticated = ValueNotifier<bool>(false);

  void markAuthenticated() {
    if (isAuthenticated.value != true) {
      isAuthenticated.value = true;
    }
  }

  void markUnauthenticated() {
    if (isAuthenticated.value != false) {
      isAuthenticated.value = false;
    }
  }
}
