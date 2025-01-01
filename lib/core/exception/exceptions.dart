import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final int code;

  const ServerException({
    required this.message,
    required this.code,
  });

  @override
  List<Object?> get props => [
        message,
        code,
      ];
}
