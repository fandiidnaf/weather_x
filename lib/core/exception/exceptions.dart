import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

// Custom Exception Classes
class ServerException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const ServerException(this.message, [this.statusCode]);

  @override
  String toString() => 'ServerException: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

class ClientException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const ClientException(this.message, [this.statusCode]);

  @override
  String toString() => 'ClientException: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

class NetworkException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException(this.message, [this.statusCode]);

  @override
  String toString() => 'NetworkException: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

class UnexpectedException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const UnexpectedException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'UnexpectedException: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

// Function to handle Dio exceptions
Exception handleDioError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException(
            'Connection timed out. Please try again later.');

      case DioExceptionType.badResponse:
        if (error.response != null) {
          final statusCode = error.response?.statusCode;
          if (statusCode != null) {
            if (statusCode >= 500) {
              return ServerException(
                  'Server error: ${error.response?.statusMessage ?? 'Unknown error'}',
                  statusCode);
            } else if (statusCode >= 400) {
              return ClientException(
                  'Client error: ${error.response?.statusMessage ?? 'Unknown error'}',
                  statusCode);
            }
          }
        }
        return const UnexpectedException('Unexpected response error.');

      case DioExceptionType.cancel:
        return const ClientException('Request was cancelled.');

      case DioExceptionType.unknown:
        return NetworkException('Network error: ${error.message}');

      case DioExceptionType.badCertificate:
        return const NetworkException(
            'Bad certificate error: Unable to verify server identity.');

      case DioExceptionType.connectionError:
        return const NetworkException(
            'Connection error: Unable to establish a connection to the server.');
    }
  } else {
    return UnexpectedException('Unexpected error: ${error.toString()}');
  }
}
