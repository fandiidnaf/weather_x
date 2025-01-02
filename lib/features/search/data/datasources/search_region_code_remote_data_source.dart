import 'package:dio/dio.dart';
import 'package:weather_x/core/exception/exceptions.dart';
import 'package:weather_x/features/search/data/models/search_region_code_model.dart';

abstract class SearchRegionCodeRemoteDataSource {
  Future<List<SearchRegionCodeModel>> getRegionCodeByName(String name);
}

class SearchRegionCodeRemoteDataSourceImpl
    implements SearchRegionCodeRemoteDataSource {
  final Dio dio;

  SearchRegionCodeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SearchRegionCodeModel>> getRegionCodeByName(String name) async {
    try {
      final List<SearchRegionCodeModel> allResults = [];

      // Fetch data recursively
      await _fetchAndFilterRegions(
        url: 'https://wilayah.id/api/provinces.json',
        name: name,
        results: allResults,
        nextUrlBuilder: (code) => 'https://wilayah.id/api/regencies/$code.json',
        nextFilter: (json) => _fetchAndFilterRegions(
          url: 'https://wilayah.id/api/districts/${json['code']}.json',
          name: name,
          results: allResults,
          nextUrlBuilder: (code) =>
              'https://wilayah.id/api/villages/$code.json',
          nextFilter: (json) => _fetchAndFilterRegions(
            url: 'https://wilayah.id/api/villages/${json['code']}.json',
            name: name,
            results: allResults,
          ),
        ),
      );

      return allResults;
    } catch (e) {
      throw handleDioError(e);
    }
  }

  Future<void> _fetchAndFilterRegions({
    required String url,
    required String name,
    required List<SearchRegionCodeModel> results,
    String Function(String code)? nextUrlBuilder,
    Future<void> Function(Map<String, dynamic> json)? nextFilter,
  }) async {
    final response = await dio.get(url);

    // Parse response into a list of models
    final regions = SearchRegionCodeModel.fromJsonList(response.data);

    // Filter regions by name
    final filteredRegions = regions
        .where(
            (region) => region.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    results.addAll(filteredRegions);

    // Continue fetching child regions if applicable
    if (nextUrlBuilder != null && nextFilter != null) {
      for (var region in regions) {
        final nextUrl = nextUrlBuilder(region.code);
        await nextFilter({'code': region.code, 'url': nextUrl});
      }
    }
  }
}
