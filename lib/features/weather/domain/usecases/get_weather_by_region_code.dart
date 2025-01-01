import 'package:dartz/dartz.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/core/usecases/usecase.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';
import 'package:weather_x/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByRegionCode
    implements UseCase<Weather, GetWeatherByRegionCodeParam> {
  final WeatherRepository repository;

  GetWeatherByRegionCode(this.repository);

  @override
  Future<Either<Failure, Weather>> call(
      GetWeatherByRegionCodeParam params) async {
    return await repository.getWeatherByRegionCode(params.regionCode);
  }
}

class GetWeatherByRegionCodeParam {
  final String regionCode;

  GetWeatherByRegionCodeParam({required this.regionCode});
}
