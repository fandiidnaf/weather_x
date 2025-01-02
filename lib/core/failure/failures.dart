import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_x/core/exception/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});

  @override
  String toString() => 'ServerFailure: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [
        message,
        statusCode,
      ];
}

class ClientFailure extends Failure {
  const ClientFailure({required super.message, super.statusCode});

  @override
  String toString() => 'ClientFailure: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [
        message,
        statusCode,
      ];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});

  @override
  String toString() => 'NetworkFailure: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required super.message, super.statusCode});

  @override
  String toString() => 'UnexpectedFailure: $message (Status code: $statusCode)';

  @override
  List<Object?> get props => [message, statusCode];
}

typedef HandleExceptFunc<T> = Left<Failure, T> Function(
    String message, int? statusCode);

Left<Failure, Success> handleFailureFromException<Success>(
  dynamic exception, {
  required HandleExceptFunc<Success> onServerException,
  required HandleExceptFunc<Success> onClientException,
  required HandleExceptFunc<Success> onNetworkException,
  required HandleExceptFunc<Success> onUnexpectedException,
}) {
  if (exception is ServerException) {
    return onServerException(exception.message, exception.statusCode);
  } else if (exception is ClientException) {
    return onClientException(exception.message, exception.statusCode);
  } else if (exception is NetworkException) {
    return onNetworkException(exception.message, exception.statusCode);
  } else if (exception is UnexpectedException) {
    return onUnexpectedException(exception.message, exception.statusCode);
  } else {
    return const Left(UnexpectedFailure(message: 'UnExpected Occurs'));
  }
}
