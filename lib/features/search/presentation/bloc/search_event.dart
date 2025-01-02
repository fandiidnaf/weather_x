part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetRegionCodeByNameEvent extends SearchEvent {
  final String regionName;

  const GetRegionCodeByNameEvent({required this.regionName});

  @override
  List<Object> get props => [
        regionName,
      ];
}
