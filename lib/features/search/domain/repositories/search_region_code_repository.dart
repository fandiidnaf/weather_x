import 'package:dartz/dartz.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/features/search/domain/entities/search_region_code.dart';

abstract class SearchRegionCodeRepository {
  Future<Either<Failure, List<SearchRegionCode>>> getRegionCodeByName(
      String regionName);
}
