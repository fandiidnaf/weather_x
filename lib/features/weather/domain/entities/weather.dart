import 'cuaca_group.dart';
import 'lokasi.dart';

class Weather {
  final Lokasi lokasi;
  final List<CuacaGroup> cuacaGroups;

  Weather({
    required this.lokasi,
    required this.cuacaGroups,
  });
}
