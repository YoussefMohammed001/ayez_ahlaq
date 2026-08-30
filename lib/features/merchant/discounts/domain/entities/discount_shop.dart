import 'package:equatable/equatable.dart';

class DiscountShop extends Equatable {
  final int id;
  final String name;
  final String? area;

  const DiscountShop({required this.id, required this.name, this.area});

  @override
  List<Object?> get props => [id, name, area];
}
