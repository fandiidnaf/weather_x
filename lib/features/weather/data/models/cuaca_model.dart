import 'package:weather_x/features/weather/domain/entities/cuaca.dart';

class CuacaModel extends Cuaca {
  CuacaModel({
    required super.datetime,
    required super.temperature,
    required super.cloudCoverage,
    required super.precipitation,
    required super.weatherCode,
    required super.weatherDescription,
    required super.weatherDescriptionEn,
    required super.windDirectionDegree,
    required super.windDirection,
    required super.windToDirection,
    required super.windSpeed,
    required super.humidity,
    required super.visibility,
    required super.visibilityText,
    required super.imageUrl,
    required super.utcDatetime,
    required super.localDatetime,
  });

  factory CuacaModel.fromJson(Map<String, dynamic> json) {
    return CuacaModel(
      datetime: DateTime.parse(json['datetime']),
      temperature: (json['t'] ?? 0).toDouble(),
      cloudCoverage: json['tcc'] ?? 0,
      precipitation: (json['tp'] ?? 0).toDouble(),
      weatherCode: json['weather'] ?? 0,
      weatherDescription: json['weather_desc'] ?? '',
      weatherDescriptionEn: json['weather_desc_en'] ?? '',
      windDirectionDegree: json['wd_deg'] ?? 0,
      windDirection: json['wd'] ?? '',
      windToDirection: json['wd_to'] ?? '',
      windSpeed: (json['ws'] ?? 0).toDouble(),
      humidity: json['hu'] ?? 0,
      visibility: json['vs'] ?? 0,
      visibilityText: json['vs_text'] ?? '',
      imageUrl: json['image'] ?? '',
      utcDatetime: DateTime.parse(json['utc_datetime']),
      localDatetime: DateTime.parse(json['local_datetime']),
    );
  }
}
