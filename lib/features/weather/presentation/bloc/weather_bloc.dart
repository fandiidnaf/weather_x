import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';
import 'package:weather_x/features/weather/domain/usecases/get_weather_by_region_code.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByRegionCode getWeatherByRegionCode;

  WeatherBloc({
    required this.getWeatherByRegionCode,
  }) : super(WeatherInitial()) {
    on<GetWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      final weatherEither = await getWeatherByRegionCode(
          GetWeatherByRegionCodeParam(regionCode: event.regionCode));

      weatherEither.fold(
        (failure) => emit(WeatherError(
            message: failure.message, statusCode: failure.statusCode)),
        (weather) => emit(WeatherLoaded(weather: weather)),
      );
    });
  }
}
