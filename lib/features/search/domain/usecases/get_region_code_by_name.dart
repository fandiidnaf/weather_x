import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/core/usecases/usecase.dart';
import 'package:weather_x/features/search/domain/entities/search_region_code.dart';
import 'package:weather_x/features/search/domain/repositories/search_region_code_repository.dart';

class GetRegionCodeByName
    implements UseCase<List<SearchRegionCode>, GetRegionCodeByNameParam> {
  final SearchRegionCodeRepository repository;

  GetRegionCodeByName(this.repository);

  @override
  Future<Either<Failure, List<SearchRegionCode>>> call(
      GetRegionCodeByNameParam params) async {
    return await repository.getRegionCodeByName(params.regionName);
  }
}

class GetRegionCodeByNameParam extends Equatable {
  final String regionName;

  const GetRegionCodeByNameParam({required this.regionName});

  @override
  List<Object?> get props => [
        regionName,
      ];
}
