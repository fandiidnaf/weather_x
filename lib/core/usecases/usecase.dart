import 'package:dartz/dartz.dart';
import 'package:weather_x/core/failure/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
