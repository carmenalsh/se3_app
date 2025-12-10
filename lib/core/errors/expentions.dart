import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'error_model.dart';

abstract class ServerException implements Exception {
  final ErrorModel errorModel;

  const ServerException(this.errorModel);
}

//! CacheException
class CacheException implements Exception {
  final String errorMessage;

  const CacheException({required this.errorMessage});

  @override
  String toString() => errorMessage;
}

//! Server Exceptions types
class BadCertificateException extends ServerException {
  const BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  const ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  const BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  const ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  const ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  const SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  const ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  const NotFoundException(super.errorModel);
}

class ConflictException extends ServerException {
  const ConflictException(super.errorModel);
}

class CancelException extends ServerException {
  const CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  const UnknownException(super.errorModel);
}

ErrorModel _buildErrorModel(DioException e) {
  final statusCode = e.response?.statusCode ?? 0;
  final data = e.response?.data;

  if (data is Map<String, dynamic>) {
    return ErrorModel.fromJson(data);
  }

  return ErrorModel(
    status: statusCode,
    errorMessage: data?.toString() ?? e.message ?? 'Unexpected error',
  );
}

/// ترمي Exception دايمًا، ما بترجع
Never handleDioException(DioException e) {
  debugPrint('DioException type: ${e.type}');
  debugPrint('DioException response data: ${e.response?.data}');
  final errorModel = _buildErrorModel(e);

  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(errorModel);

    case DioExceptionType.badCertificate:
      throw BadCertificateException(errorModel);

    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(errorModel);

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(errorModel);

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(errorModel);

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(errorModel);
        case 401: // Unauthorized
          throw UnauthorizedException(errorModel);
        case 403: // Forbidden
          throw ForbiddenException(errorModel);
        case 404: // Not found
          throw NotFoundException(errorModel);
        case 409: // Conflict
          throw ConflictException(errorModel);
        case 504: // Gateway timeout
          throw BadResponseException(errorModel);
        default:
          throw BadResponseException(errorModel);
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(status: 500, errorMessage: e.toString()),
      );

    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(status: 500, errorMessage: e.toString()),
      );
  }
}
