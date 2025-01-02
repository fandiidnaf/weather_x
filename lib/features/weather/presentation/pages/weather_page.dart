import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_x/features/search/data/datasources/search_region_code_remote_data_source.dart';
import 'package:weather_x/features/search/data/repositories/search_region_code_repository_impl.dart';
import 'package:weather_x/features/search/domain/usecases/get_region_code_by_name.dart';
import 'package:weather_x/features/search/presentation/bloc/search_bloc.dart';
import 'package:weather_x/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_x/features/weather/data/repositories/weather_repostory_impl.dart';
import 'package:weather_x/features/weather/domain/usecases/get_weather_by_region_code.dart';
import 'package:weather_x/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_x/features/weather/presentation/pages/weather_2.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
        getWeatherByRegionCode: GetWeatherByRegionCode(
          WeatherRepostoryImpl(
            remoteDataSouce: WeatherRemoteDataSourceImpl(
              Dio(),
            ),
          ),
        ),
      ),
      child: BlocProvider(
        create: (context) => SearchBloc(
          getRegionCodeByName: GetRegionCodeByName(
            SearchRegionCodeRepositoryImpl(
              SearchRegionCodeRemoteDataSourceImpl(
                Dio(),
              ),
            ),
          ),
        ),
        child: const Weather2(),
      ),
    );
  }
}
