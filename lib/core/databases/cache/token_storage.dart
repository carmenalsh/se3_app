import 'package:complaints_app/core/databases/cache/cache_helper.dart';
import 'package:complaints_app/core/utils/auth_session.dart';

class TokenStorage {
  static const _accessTokenKey = 'token';
  static const _expiryKey = 'expires_in';

  static Future<void> saveAccessToken({
    required String token,
    required int expiresInSeconds,
  }) async {
    await CacheHelper.saveData(key: _accessTokenKey, value: token);

    final expiry = DateTime.now()
        .add(Duration(seconds: expiresInSeconds))
        .toIso8601String();

    await CacheHelper.saveData(key: _expiryKey, value: expiry);

    AuthSession.instance.markAuthenticated();
  }

  static String? getAccessToken() {
    return CacheHelper.getData(key: _accessTokenKey);
  }

  static DateTime? getAccessTokenExpiry() {
    final raw = CacheHelper.getData(key: _expiryKey);
    if (raw == null) return null;
    if (raw is String) {
      return DateTime.tryParse(raw);
    }

    // رجاع تاريخ "منتهي مسبقًا" للتأكد من أن التوكن يعتبر منتهي
    if (raw is int) {
      return DateTime.now().subtract(const Duration(seconds: 1));
    }

    return null;
  }

  static bool get isAlmostExpired {
    final expiry = getAccessTokenExpiry();
    if (expiry == null) return true;
    final now = DateTime.now();
    return now.isAfter(expiry.subtract(const Duration(minutes: 1)));
  }

  static Future<void> clear() async {
    await CacheHelper.removeData(key: _accessTokenKey);
    await CacheHelper.removeData(key: _expiryKey);

    AuthSession.instance.markUnauthenticated();
  }
}
