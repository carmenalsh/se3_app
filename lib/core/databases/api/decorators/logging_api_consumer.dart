import 'package:flutter/foundation.dart';
import 'api_consumer_decorator.dart';

class LoggingApiConsumer extends ApiConsumerDecorator {
  LoggingApiConsumer(super.inner);

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    debugPrint("➡️ GET  $path  query=$queryParameters");
    final res = await super.get(path, data: data, queryParameters: queryParameters);
    debugPrint("✅ GET  $path  done");
    return res;
  }

  @override
  Future post(String path, {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    debugPrint("➡️ POST $path  data=$data");
    final res = await super.post(path, data: data, queryParameters: queryParameters, isFormData: isFormData);
    debugPrint("✅ POST $path  done");
    return res;
  }

  @override
  Future patch(String path, {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    debugPrint("➡️ PATCH $path  data=$data");
    final res = await super.patch(path, data: data, queryParameters: queryParameters, isFormData: isFormData);
    debugPrint("✅ PATCH $path  done");
    return res;
  }

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    debugPrint("➡️ DELETE $path  data=$data");
    final res = await super.delete(path, data: data, queryParameters: queryParameters);
    debugPrint("✅ DELETE $path  done");
    return res;
  }
}
