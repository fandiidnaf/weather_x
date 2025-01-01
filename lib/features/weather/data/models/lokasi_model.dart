import 'package:weather_x/features/weather/domain/entities/lokasi.dart';

class LokasiModel extends Lokasi {
  LokasiModel({
    required super.adm1,
    required super.adm2,
    required super.adm3,
    required super.adm4,
    required super.provinsi,
    required super.kota,
    required super.kecamatan,
    required super.desa,
    required super.lon,
    required super.lat,
    required super.timezone,
  });

  factory LokasiModel.fromJson(Map<String, dynamic> json) {
    return LokasiModel(
      adm1: json['adm1'] ?? '',
      adm2: json['adm2'] ?? '',
      adm3: json['adm3'] ?? '',
      adm4: json['adm4'] ?? '',
      provinsi: json['provinsi'] ?? '',
      kota: json['kota'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      desa: json['desa'] ?? '',
      lon: (json['lon'] ?? 0).toDouble(),
      lat: (json['lat'] ?? 0).toDouble(),
      timezone: json['timezone'] ?? '',
    );
  }
}
