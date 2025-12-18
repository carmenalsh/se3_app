import 'dart:async';
import 'api_consumer_decorator.dart';

class TimeoutApiConsumer extends ApiConsumerDecorator {
  final Duration timeout;
  TimeoutApiConsumer(super.inner, {this.timeout = const Duration(seconds: 15)});

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return super.get(path, data: data, queryParameters: queryParameters).timeout(timeout);
  }

  @override
  Future post(String path, {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) {
    return super.post(path, data: data, queryParameters: queryParameters, isFormData: isFormData).timeout(timeout);
  }

  @override
  Future patch(String path, {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) {
    return super.patch(path, data: data, queryParameters: queryParameters, isFormData: isFormData).timeout(timeout);
  }

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return super.delete(path, data: data, queryParameters: queryParameters).timeout(timeout);
  }
}
