// import 'package:complaints_app/core/errors/expentions.dart';
// import 'package:dio/dio.dart';

// import 'api_consumer.dart';
// import 'end_points.dart';

// class DioConsumer extends ApiConsumer {
//   final Dio dio;

//     bool _isRefreshing = false;

//   DioConsumer({required this.dio}) {
//     dio.options
//       ..baseUrl = EndPoints.baseUrl
//       ..receiveDataWhenStatusError = true;
//   }

//   //! POST
//   @override
//   Future<dynamic> post(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFormData = false,
//   }) async {
//     try {
//       final res = await dio.post(
//         path,
//         data: isFormData && data != null ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return res.data;
//     } on DioException catch (e) {
//       handleDioException(e);
//     }
//   }

//   //! GET
//   @override
//   Future<dynamic> get(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final res = await dio.get(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return res.data;
//     } on DioException catch (e) {
//       handleDioException(e);
//     }
//   }

//   //! DELETE
//   @override
//   Future<dynamic> delete(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final res = await dio.delete(
//         path,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return res.data;
//     } on DioException catch (e) {
//       handleDioException(e);
//     }
//   }

//   //! PATCH
//   @override
//   Future<dynamic> patch(
//     String path, {
//     dynamic data,
//     Map<String, dynamic>? queryParameters,
//     bool isFormData = false,
//   }) async {
//     try {
//       final res = await dio.patch(
//         path,
//         data: isFormData && data != null ? FormData.fromMap(data) : data,
//         queryParameters: queryParameters,
//       );
//       return res.data;
//     } on DioException catch (e) {
//       handleDioException(e);
//     }
//   }
// }

import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/errors/expentions.dart';
import 'package:dio/dio.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/core/databases/cache/token_storage.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  bool _isRefreshing = false;

  DioConsumer({required this.dio}) {
    dio.options
      ..baseUrl = EndPoints.baseUrl
      ..receiveDataWhenStatusError = true;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1) نجيب التوكين الحالي
          final token = TokenStorage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            // 2) لو تقريباً منتهي → نحاول refresh استباقي
            if (TokenStorage.isAlmostExpired && !_isRefreshing) {
              await _proactiveRefresh(token);
            }

            // 3) نضيف التوكين (ممكن يكون الجديد بعد refresh)
            final finalToken = TokenStorage.getAccessToken();
            if (finalToken != null && finalToken.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $finalToken';
            }
          }

          handler.next(options);
        },
        onError: (error, handler) async {
          final statusCode = error.response?.statusCode;
          final isRefreshCall = error.requestOptions.path.contains('/refresh');

          // لو 401 ومو طلب refresh نفسه → نحاول refresh + إعادة الطلب
          if (statusCode == 401 && !isRefreshCall) {
            final response = await _tryRefreshAndRetry(error);
            if (response != null) {
              handler.resolve(response);
              return;
            }
          }

          // لو ما قدرنا نعمل refresh أو مش 401 → نمشي بالخطأ عادي
          handler.next(error);
        },
      ),
    );
  }

  // 🔹 Refresh استباقي (قبل نهاية التوكين بدقيقة تقريباً)
  Future<void> _proactiveRefresh(String oldToken) async {
    if (_isRefreshing) return;

    _isRefreshing = true;
    try {
      final refreshDio = Dio();

      final refreshResponse = await refreshDio.post(
        EndPoints.refreshToken,
        options: Options(headers: {'Authorization': 'Bearer $oldToken'}),
      );

      if (refreshResponse.statusCode == 200) {
        final data = refreshResponse.data as Map<String, dynamic>;
        final newToken = data['data']?['newToken']?.toString() ?? '';
        final expiresIn = data['data']?['expires_in'] as int? ?? 0;

        if (newToken.isNotEmpty && expiresIn > 0) {
          await TokenStorage.saveAccessToken(
            token: newToken,
            expiresInSeconds: expiresIn,
          );
        } else {
          await TokenStorage.clear();
        }
      } else {
        await TokenStorage.clear();
      }
    } catch (e) {
      ///////////////  ملاحظة في حال انقط الانترنت ونقلني للوج او 500 فيجب تعديل هنا
      await TokenStorage.clear();
    } finally {
      _isRefreshing = false;
    }
  }

  // 🔹 معالجة 401: نجرب refresh ثم نعيد إرسال نفس الطلب
  Future<Response<dynamic>?> _tryRefreshAndRetry(DioException err) async {
    if (_isRefreshing) {
      // للتبسيط: لو في refresh شغال، نخلي الطلب هذا يفشل مرة واحدة
      return null;
    }

    _isRefreshing = true;
    try {
      final oldToken = TokenStorage.getAccessToken();
      if (oldToken == null || oldToken.isEmpty) {
        await TokenStorage.clear();
        return null;
      }

      final refreshDio = Dio();
      final refreshResponse = await refreshDio.post(
        EndPoints.refreshToken,
        options: Options(headers: {'Authorization': 'Bearer $oldToken'}),
      );

      if (refreshResponse.statusCode == 200) {
        final data = refreshResponse.data as Map<String, dynamic>;
        final newToken = data['data']?['newToken']?.toString() ?? '';
        final expiresIn = data['data']?['expires_in'] as int? ?? 0;

        if (newToken.isEmpty || expiresIn == 0) {
          await TokenStorage.clear();
          return null;
        }

        await TokenStorage.saveAccessToken(
          token: newToken,
          expiresInSeconds: expiresIn,
        );

        // نعيد إرسال الطلب الأصلي
        final requestOptions = err.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer $newToken';

        final clonedResponse = await dio.fetch(requestOptions);
        return clonedResponse;
      } else {
        await TokenStorage.clear();
        return null;
      }
    } catch (e) {
      await TokenStorage.clear();
      return null;
    } finally {
      _isRefreshing = false;
    }
  }

  //! POST
  @override
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final res = await dio.post(
        path,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //! GET
  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //! DELETE
  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //! PATCH
  @override
  Future<dynamic> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final res = await dio.patch(
        path,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
