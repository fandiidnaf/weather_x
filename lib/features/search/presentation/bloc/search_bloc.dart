import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_x/features/search/domain/entities/search_region_code.dart';
import 'package:weather_x/features/search/domain/usecases/get_region_code_by_name.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetRegionCodeByName getRegionCodeByName;

  SearchBloc({
    required this.getRegionCodeByName,
  }) : super(SearchInitial()) {
    on<GetRegionCodeByNameEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await getRegionCodeByName
          .call(GetRegionCodeByNameParam(regionName: event.regionName));

      result.fold(
        (failure) => emit(SearchError(
            message: failure.message, statusCode: failure.statusCode)),
        (searchResult) => emit(SearchLoaded(searchRegionCodes: searchResult)),
      );
    });
  }
}
