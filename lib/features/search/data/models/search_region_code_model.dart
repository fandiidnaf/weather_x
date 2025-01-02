import 'package:weather_x/features/search/domain/entities/search_region_code.dart';

class SearchRegionCodeModel extends SearchRegionCode {
  final String? postalCode;

  const SearchRegionCodeModel({
    required super.code,
    required super.name,
    this.postalCode,
  });

  /// Factory method untuk membuat instance dari JSON.
  factory SearchRegionCodeModel.fromJson(Map<String, dynamic> json) {
    return SearchRegionCodeModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      postalCode: json['postal_code'] as String?,
    );
  }

  /// Factory method untuk membuat daftar instance dari JSON.
  static List<SearchRegionCodeModel> fromJsonList(Map<String, dynamic> json) {
    if (json['data'] == null || json['data'] is! List) {
      throw ArgumentError("Invalid or missing 'data' in JSON.");
    }

    return (json['data'] as List).map((item) {
      if (item is! Map<String, dynamic>) {
        throw ArgumentError("Invalid element in 'data' list.");
      }
      return SearchRegionCodeModel.fromJson(item);
    }).toList();
  }
}
