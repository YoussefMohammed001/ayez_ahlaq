import 'package:equatable/equatable.dart';

class HaircutStyle extends Equatable {
  final int id;
  final String name;
  final int priceDelta;

  const HaircutStyle({
    required this.id,
    required this.name,
    required this.priceDelta,
  });

  @override
  List<Object?> get props => [id, name, priceDelta];
}
