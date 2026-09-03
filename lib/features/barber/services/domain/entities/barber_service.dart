import 'package:equatable/equatable.dart';

class BarberService extends Equatable {
  final int id;
  final int catalogId;
  final String name;
  final String description;
  final int price;
  final int durationMinutes;
  final bool popular;
  final bool active;

  const BarberService({
    required this.id,
    required this.catalogId,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.popular,
    required this.active,
  });

  BarberService copyWith({bool? active}) {
    return BarberService(
      id: id,
      catalogId: catalogId,
      name: name,
      description: description,
      price: price,
      durationMinutes: durationMinutes,
      popular: popular,
      active: active ?? this.active,
    );
  }

  @override
  List<Object?> get props => [
    id,
    catalogId,
    name,
    description,
    price,
    durationMinutes,
    popular,
    active,
  ];
}
