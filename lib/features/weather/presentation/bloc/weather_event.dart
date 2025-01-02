part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final String regionCode;

  const GetWeatherEvent({required this.regionCode});

  @override
  List<Object> get props => [
        regionCode,
      ];
}
