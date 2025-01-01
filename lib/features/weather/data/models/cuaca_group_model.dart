import 'package:weather_x/features/weather/data/models/cuaca_model.dart';
import 'package:weather_x/features/weather/domain/entities/cuaca_group.dart';

class CuacaGroupModel extends CuacaGroup {
  CuacaGroupModel({required List<CuacaModel> cuacaList})
      : super(cuacaList: cuacaList);

  factory CuacaGroupModel.fromJson(List<dynamic> jsonList) {
    return CuacaGroupModel(
      cuacaList: jsonList.map((json) => CuacaModel.fromJson(json)).toList(),
    );
  }
}
