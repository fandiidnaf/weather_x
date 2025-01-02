import 'package:dartz/dartz.dart';
import 'package:weather_x/core/failure/failures.dart';
import 'package:weather_x/features/search/data/datasources/search_region_code_remote_data_source.dart';
import 'package:weather_x/features/search/domain/entities/search_region_code.dart';
import 'package:weather_x/features/search/domain/repositories/search_region_code_repository.dart';

class SearchRegionCodeRepositoryImpl implements SearchRegionCodeRepository {
  final SearchRegionCodeRemoteDataSource dataSource;

  SearchRegionCodeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<SearchRegionCode>>> getRegionCodeByName(
      String regionName) async {
    try {
      return Right(await dataSource.getRegionCodeByName(regionName));
    } catch (e) {
      return handleFailureFromException<List<SearchRegionCode>>(
        e,
        onServerException: (message, statusCode) =>
            Left(ServerFailure(message: message, statusCode: statusCode)),
        onClientException: (message, statusCode) =>
            Left(ClientFailure(message: message, statusCode: statusCode)),
        onNetworkException: (message, statusCode) =>
            Left(NetworkFailure(message: message, statusCode: statusCode)),
        onUnexpectedException: (message, statusCode) =>
            Left(UnexpectedFailure(message: message, statusCode: statusCode)),
      );
      // return Left(ServerFailure(message: 'message', code: 10));
    }
  }
}
