import 'package:equatable/equatable.dart';

import 'cuaca.dart';

class CuacaGroup extends Equatable {
  final List<Cuaca> cuacaList;

  const CuacaGroup({
    required this.cuacaList,
  });

  @override
  List<Object?> get props => [
        cuacaList,
      ];
}
