import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_x/features/weather/data/models/cuaca_group_model.dart';
import 'package:weather_x/features/weather/data/models/cuaca_model.dart';
import 'package:weather_x/features/weather/data/models/lokasi_model.dart';
import 'package:weather_x/features/weather/data/models/weather_model.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';

import '../../../fixtures/fixture.dart';

void main() {
  final WeatherModel tWeatherModel = WeatherModel(
    lokasi: LokasiModel(
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

  test('weather model should inherit from weather entity', () async {
    // assert
    expect(tWeatherModel, isA<Weather>());
  });

  test('should return a valid weatherModel from Json', () async {
    // act
    final jsonDecode = await json.decode(fixture('weather'));
    final result = WeatherModel.fromJson(jsonDecode);

    // assert
    expect(result, isA<WeatherModel>());
    expect(result, isA<Weather>());
  });
}
