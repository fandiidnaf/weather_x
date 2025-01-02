import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_x/core/exception/exceptions.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_x/features/weather/data/models/cuaca_group_model.dart';
import 'package:weather_x/features/weather/data/models/cuaca_model.dart';
import 'package:weather_x/features/weather/data/models/lokasi_model.dart';
import 'package:weather_x/features/weather/data/models/weather_model.dart';
import 'package:weather_x/features/weather/data/repositories/weather_repostory_impl.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';
import 'package:weather_x/features/weather/domain/repositories/weather_repository.dart';

class MockWeatherRemoteDataSource extends Mock
    implements WeatherRemoteDataSource {}

void main() {
  late WeatherRepository weatherRepository;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepository =
        WeatherRepostoryImpl(remoteDataSouce: mockWeatherRemoteDataSource);
  });

  group('getWeather', () {
    final WeatherModel tWeatherModel = WeatherModel(
      lokasi: const LokasiModel(
          adm1: '35',
          adm2: '35.06',
          adm3: '35.06.14',
          adm4: '35.06.14.2011',
          provinsi: 'Jawa Timur',
          kota: 'Kediri',
          kecamatan: 'Papar',
          desa: 'Maduretno',
          lon: 112.0946719899,
          lat: -7.6948073008,
          timezone: 'Asia/Jakarta'),
      cuacaGroups: [
        CuacaGroupModel(
          cuacaList: [
            CuacaModel(
              datetime: DateTime.now(),
              temperature: 25,
              cloudCoverage: 100,
              precipitation: 0.8,
              weatherCode: 3,
              weatherDescription: 'Berawan',
              weatherDescriptionEn: 'Mostly Cloude',
              windDirectionDegree: 141,
              windDirection: 'SE',
              windToDirection: 'NW',
              windSpeed: 6.6,
              humidity: 97,
              visibility: 30277,
              visibilityText: '> 10 km',
              imageUrl:
                  'https://api-apps.bmkg.go.id/storage/icon/cuaca/berawan-am.svg',
              utcDatetime: DateTime.now(),
              localDatetime: DateTime.now(),
            ),
          ],
        ),
        CuacaGroupModel(
          cuacaList: [
            CuacaModel(
              datetime: DateTime.now().add(const Duration(days: 1)),
              temperature: 25,
              cloudCoverage: 100,
              precipitation: 0.8,
              weatherCode: 3,
              weatherDescription: 'Berawan',
              weatherDescriptionEn: 'Mostly Cloude',
              windDirectionDegree: 141,
              windDirection: 'SE',
              windToDirection: 'NW',
              windSpeed: 6.6,
              humidity: 97,
              visibility: 30277,
              visibilityText: '> 10 km',
              imageUrl:
                  'https://api-apps.bmkg.go.id/storage/icon/cuaca/berawan-am.svg',
              utcDatetime: DateTime.now().add(const Duration(days: 1)),
              localDatetime: DateTime.now().add(const Duration(days: 1)),
            ),
          ],
        )
      ],
    );

    test('should return a weatherModel from internet', () async {
      // arrange
      when(() => mockWeatherRemoteDataSource.getWeatherByRegionCode(any()))
          .thenAnswer((_) async => tWeatherModel);

      // act
      final result =
          await weatherRepository.getWeatherByRegionCode('35.06.14.2011');

      // assert
      expect(result, Right(tWeatherModel));
      verify(() =>
          mockWeatherRemoteDataSource.getWeatherByRegionCode('35.06.14.2011'));
      verifyNoMoreInteractions(mockWeatherRemoteDataSource);
    });

    test('should return a ServerFailure from internet', () async {
      // arrange
      when(() => mockWeatherRemoteDataSource.getWeatherByRegionCode(any()))
          .thenThrow(
        const ServerException('Server Down', 404),
      );

      // act
      final result =
          await weatherRepository.getWeatherByRegionCode('35.06.14.2011');

      // assert
      expect(
          result,
          const Left<Failure, Weather>(
              ServerFailure(statusCode: 404, message: 'Server Down')));
      verify(() =>
          mockWeatherRemoteDataSource.getWeatherByRegionCode('35.06.14.2011'));
      verifyNoMoreInteractions(mockWeatherRemoteDataSource);
    });
  });
}
