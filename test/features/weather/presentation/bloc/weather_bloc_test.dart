import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/features/weather/domain/entities/cuaca.dart';
import 'package:weather_x/features/weather/domain/entities/cuaca_group.dart';
import 'package:weather_x/features/weather/domain/entities/lokasi.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';
import 'package:weather_x/features/weather/domain/usecases/get_weather_by_region_code.dart';
import 'package:weather_x/features/weather/presentation/bloc/weather_bloc.dart';

class MockGetWeatherByRegionCode extends Mock
    implements GetWeatherByRegionCode {}

class MockGetWeatherByRegionCodeParam extends Mock
    implements GetWeatherByRegionCodeParam {}

void main() {
  late MockGetWeatherByRegionCode usecase;
  late WeatherBloc bloc;
  late MockGetWeatherByRegionCodeParam usecaseParam;

  setUp(() {
    usecase = MockGetWeatherByRegionCode();
    bloc = WeatherBloc(
      getWeatherByRegionCode: usecase,
    );
    usecaseParam = MockGetWeatherByRegionCodeParam();
  });

  group('GetWeatherByRegionCode', () {
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

    setUp(() {
      // registerFallbackValue(
      //     const GetWeatherByRegionCodeParam(regionCode: '1234'));  // pass
      registerFallbackValue(usecaseParam); // pass
    });

    test('should get weather data from the region code use case', () async {
      // arrange
      when(() => usecase(any())).thenAnswer((_) async => Right(tWeather));

      // act
      bloc.add(const GetWeatherEvent(regionCode: '35.06.14.2011'));
      await untilCalled(() => usecase(any()));

      // assert
      verify(() => usecase(
          const GetWeatherByRegionCodeParam(regionCode: '35.06.14.2011')));
    });

    test('should emit [Loading, Loaded] when data is gotten succesfully',
        () async {
      // arrange
      when(() => usecase(any())).thenAnswer((_) async => Right(tWeather));

      // assert later
      final expected = [WeatherLoading(), WeatherLoaded(weather: tWeather)];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(const GetWeatherEvent(regionCode: '35.06.14.2011'));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(() => usecase(any())).thenAnswer(
          (_) async => Left(ServerFailure(message: 'SERVER DOWN', code: 404)));

      // assert later
      final expected = [
        WeatherLoading(),
        const WeatherError(message: 'SERVER DOWN', code: 404),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(const GetWeatherEvent(regionCode: '35.06.14.2011'));
    });

    // test(
    //     'should emit [Loading, Error] with proper message for the error when getting data fails',
    //     () async {
    //   // arrange
    //   when(() => mockGetRandomNumberTrivia(any()))
    //       .thenAnswer((_) async => Left(CacheFailure()));

    //   // assert later
    //   final expected = [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)];
    //   expectLater(bloc.stream, emitsInOrder(expected));

    //   // act
    //   bloc.add(GetTriviaForRandomNumber());
    // });
  });
}
