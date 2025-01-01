import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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

class GetWeatherByRegionCodeParam extends Equatable {
  final String regionCode;

  const GetWeatherByRegionCodeParam({required this.regionCode});

  @override
  List<Object?> get props => [regionCode];
}
