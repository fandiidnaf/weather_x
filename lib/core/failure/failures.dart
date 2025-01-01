import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int code;

  const Failure({
    required this.message,
    required this.code,
  });
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.code});

  @override
  List<Object?> get props => [
        message,
        code,
      ];
}
