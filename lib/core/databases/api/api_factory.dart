import 'package:complaints_app/core/databases/api/api_consumer.dart';
import 'package:complaints_app/core/databases/api/dio_consumer.dart';
import 'package:complaints_app/core/databases/api/decorators/logging_api_consumer.dart';
import 'package:complaints_app/core/databases/api/decorators/retry_api_consumer.dart';
import 'package:complaints_app/core/databases/api/decorators/timeout_api_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:dio/dio.dart';

ApiConsumer buildApiConsumer() {
  final dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  ApiConsumer api = DioConsumer(dio: dio);

  // ✅ Decorators (رتّبهم كيف بدك)
  api = TimeoutApiConsumer(api, timeout: const Duration(seconds: 15));
  api = RetryApiConsumer(api, retries: 2);
  api = LoggingApiConsumer(api);

  return api;
}
