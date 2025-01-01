import 'package:weather_x/core/const/url.dart';
import 'package:weather_x/core/exception/exceptions.dart';
import 'package:weather_x/core/utils/extension.dart';
import 'package:weather_x/features/weather/data/models/weather_model.dart';
import 'package:dio/dio.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByRegionCode(String code);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> getWeatherByRegionCode(String code) async {
    try {
      final response = await dio.get(BASE_URL.query({
        getAdmFromCode(code): code,
      }));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw ServerException(
          message: response.statusMessage ?? '',
          code: response.statusCode ?? 0,
        );
      }
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  String getAdmFromCode(String code) {
    final int totalAdm = code.split('.').length;

    late final String result;

    switch (totalAdm) {
      case 1:
        result = 'adm1';
        break;
      case 2:
        result = 'adm2';
        break;
      case 3:
        result = 'adm3';
        break;
      case 4:
        result = 'adm4';
        break;
      default:
        result = '';
        break;
    }

    return result;
  }
}
