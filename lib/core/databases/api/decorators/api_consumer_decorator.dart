import 'package:complaints_app/core/databases/api/api_consumer.dart';

abstract class ApiConsumerDecorator implements ApiConsumer {
  final ApiConsumer inner;
  ApiConsumerDecorator(this.inner);

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return inner.get(path, data: data, queryParameters: queryParameters);
  }

  @override
  Future post(String path,
      {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) {
    return inner.post(path, data: data, queryParameters: queryParameters, isFormData: isFormData);
  }

  @override
  Future patch(String path,
      {data, Map<String, dynamic>? queryParameters, bool isFormData = false}) {
    return inner.patch(path, data: data, queryParameters: queryParameters, isFormData: isFormData);
  }

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return inner.delete(path, data: data, queryParameters: queryParameters);
  }
}
