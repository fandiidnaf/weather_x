import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_x/core/exception/exceptions.dart';
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
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? '', code: 0));
    } catch (e) {
      return Left(
        ServerFailure(message: 'UNKNOWN WHAT OCCURS', code: -1),
      );
    }
  }
}
