import 'package:equatable/equatable.dart';

class ShopAddon extends Equatable {
  final int id;
  final String name;
  final int price;

  const ShopAddon({required this.id, required this.name, required this.price});

  @override
  List<Object?> get props => [id, name, price];
}
