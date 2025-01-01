import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_x/core/const/url.dart';
import 'package:weather_x/core/exception/exceptions.dart';
import 'package:weather_x/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_x/features/weather/data/models/weather_model.dart';

import '../../../../fixtures/fixture.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late WeatherRemoteDataSource dataSource;

  setUp(() {
    dio = MockDio();
    dataSource = WeatherRemoteDataSourceImpl(dio);
  });

  group('weather remote data source', () {
    test('should return a weather model from data source', () async {
      // arrange

      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          data: json.decode(
            fixture('weather'),
          ),
          statusCode: 200,
        ),
      );

      // act
      final result = await dataSource.getWeatherByRegionCode('35.06.14.2011');

      // assert
      expect(result, isA<WeatherModel>());
      verify(
        () => dio.get(
          '$BASE_URL?adm4=35.06.14.2011',
        ),
      );

      verifyNoMoreInteractions(dio);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(() => dio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 404,
          statusMessage: 'Server Down',
        ),
      );

      // act
      call() async => await dataSource.getWeatherByRegionCode('35.06.14.2011');

      // assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });
}
