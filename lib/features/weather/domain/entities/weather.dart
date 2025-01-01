import 'package:equatable/equatable.dart';

import 'cuaca_group.dart';
import 'lokasi.dart';

class Weather extends Equatable {
  final Lokasi lokasi;
  final List<CuacaGroup> cuacaGroups;

  const Weather({
    required this.lokasi,
    required this.cuacaGroups,
  });

  @override
  List<Object?> get props => [
        lokasi,
        cuacaGroups,
      ];
}
