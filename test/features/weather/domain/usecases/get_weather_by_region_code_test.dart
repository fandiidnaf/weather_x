import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_x/features/weather/domain/entities/cuaca.dart';
import 'package:weather_x/features/weather/domain/entities/cuaca_group.dart';
import 'package:weather_x/features/weather/domain/entities/lokasi.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';
import 'package:weather_x/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_x/features/weather/domain/usecases/get_weather_by_region_code.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetWeatherByRegionCode usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherByRegionCode(mockWeatherRepository);
  });

  final Weather tWeather = Weather(
    lokasi: const Lokasi(
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
      CuacaGroup(
        cuacaList: [
          Cuaca(
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
      CuacaGroup(
        cuacaList: [
          Cuaca(
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
  test('should get a weather from repository', () async {
    // arrange
    when(() => mockWeatherRepository.getWeatherByRegionCode(any()))
        .thenAnswer((_) async => Right(tWeather));

    // act
    final result = await usecase(const GetWeatherByRegionCodeParam(
      regionCode: "35.06.14.2011",
    ));

    // assert
    expect(result, equals(Right(tWeather)));
    verify(() => mockWeatherRepository.getWeatherByRegionCode("35.06.14.2011"));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
