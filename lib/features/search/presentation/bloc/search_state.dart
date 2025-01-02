part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<SearchRegionCode> searchRegionCodes;

  const SearchLoaded({required this.searchRegionCodes});

  @override
  List<Object> get props => [searchRegionCodes];
}

final class SearchError extends SearchState {
  final String message;
  final int? statusCode;

  const SearchError({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
