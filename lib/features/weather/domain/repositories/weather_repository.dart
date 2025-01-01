import 'package:dartz/dartz.dart';
import 'package:weather_x/core/failure/failures.dart';

import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherByRegionCode(String regionCode);
}
