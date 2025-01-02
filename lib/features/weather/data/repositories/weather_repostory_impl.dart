import 'package:dartz/dartz.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';
import 'package:weather_x/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepostoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSouce;

  WeatherRepostoryImpl({
    required this.remoteDataSouce,
  });

  @override
  Future<Either<Failure, Weather>> getWeatherByRegionCode(
      String regionCode) async {
    try {
      return Right(await remoteDataSouce.getWeatherByRegionCode(regionCode));
    } catch (e) {
      return handleFailureFromException<Weather>(
        e,
        onServerException: (message, statusCode) =>
            Left(ServerFailure(message: message, statusCode: statusCode)),
        onClientException: (message, statusCode) =>
            Left(ClientFailure(message: message, statusCode: statusCode)),
        onNetworkException: (message, statusCode) =>
            Left(NetworkFailure(message: message, statusCode: statusCode)),
        onUnexpectedException: (message, statusCode) =>
            Left(UnexpectedFailure(message: message, statusCode: statusCode)),
      );
    }
  }
}
