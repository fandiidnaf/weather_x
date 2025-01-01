import 'package:equatable/equatable.dart';

class Lokasi extends Equatable {
  final String adm1;
  final String adm2;
  final String adm3;
  final String adm4;
  final String provinsi;
  final String kota;
  final String kecamatan;
  final String desa;
  final double lon;
  final double lat;
  final String timezone;

  const Lokasi({
    required this.adm1,
    required this.adm2,
    required this.adm3,
    required this.adm4,
    required this.provinsi,
    required this.kota,
    required this.kecamatan,
    required this.desa,
    required this.lon,
    required this.lat,
    required this.timezone,
  });

  @override
  List<Object?> get props => [
        adm1,
        adm2,
        adm3,
        adm4,
        provinsi,
        kota,
        kecamatan,
        desa,
        lon,
        lat,
        timezone,
      ];
}
