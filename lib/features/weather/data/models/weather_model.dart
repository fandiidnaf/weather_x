import 'package:weather_x/features/weather/data/models/cuaca_group_model.dart';
import 'package:weather_x/features/weather/data/models/lokasi_model.dart';
import 'package:weather_x/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required LokasiModel lokasi,
    required List<CuacaGroupModel> cuacaGroups,
  }) : super(lokasi: lokasi, cuacaGroups: cuacaGroups);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      lokasi: LokasiModel.fromJson(json['lokasi']),
      cuacaGroups: (json['data'][0]['cuaca'] as List<dynamic>)
          .map((group) => CuacaGroupModel.fromJson(group))
          .toList(),
    );
  }
}
