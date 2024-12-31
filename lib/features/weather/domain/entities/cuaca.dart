class Cuaca {
  final DateTime datetime;
  final double temperature;
  final int cloudCoverage;
  final double precipitation;
  final int weatherCode;
  final String weatherDescription;
  final String weatherDescriptionEn;
  final int windDirectionDegree;
  final String windDirection;
  final String windToDirection;
  final double windSpeed;
  final int humidity;
  final int visibility;
  final String visibilityText;
  final String imageUrl;
  final DateTime utcDatetime;
  final DateTime localDatetime;

  Cuaca({
    required this.datetime,
    required this.temperature,
    required this.cloudCoverage,
    required this.precipitation,
    required this.weatherCode,
    required this.weatherDescription,
    required this.weatherDescriptionEn,
    required this.windDirectionDegree,
    required this.windDirection,
    required this.windToDirection,
    required this.windSpeed,
    required this.humidity,
    required this.visibility,
    required this.visibilityText,
    required this.imageUrl,
    required this.utcDatetime,
    required this.localDatetime,
  });
}