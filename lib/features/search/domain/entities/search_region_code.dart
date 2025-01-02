import 'package:equatable/equatable.dart';

class SearchRegionCode extends Equatable {
  final String code;
  final String name;

  const SearchRegionCode({required this.code, required this.name});

  @override
  List<Object?> get props => [
        code,
        name,
      ];
}
