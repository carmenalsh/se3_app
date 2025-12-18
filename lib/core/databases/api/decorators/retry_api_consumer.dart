import 'dart:async';
import 'package:complaints_app/core/errors/expentions.dart';
import 'api_consumer_decorator.dart';

class RetryApiConsumer extends ApiConsumerDecorator {
  final int retries;
  final Duration delay;

  RetryApiConsumer(super.inner, {this.retries = 2, this.delay = const Duration(milliseconds: 400)});

  bool _shouldRetry(Exception e) {
    return e is ConnectionErrorException ||
        e is ConnectionTimeoutException ||
        e is ReceiveTimeoutException ||
        e is SendTimeoutException;
  }

  Future<T> _run<T>(Future<T> Function() fn) async {
    int attempt = 0;
    while (true) {
      try {
        return await fn();
      } catch (e) {
        if (e is Exception && _shouldRetry(e) && attempt < retries) {
          attempt++;
          await Future.delayed(delay);
          continue;
        }
        rethrow;
      }
    }
  }

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _run(() => super.get(path, data: data, queryParameters: queryParameters));
  }

  @override
  Future post(String path, {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) {
    return _run(() => super.post(path, data: data, queryParameters: queryParameters, isFormData: isFormData));
  }

  @override
  Future patch(String path, {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) {
    return _run(() => super.patch(path, data: data, queryParameters: queryParameters, isFormData: isFormData));
  }

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _run(() => super.delete(path, data: data, queryParameters: queryParameters));
  }
}
