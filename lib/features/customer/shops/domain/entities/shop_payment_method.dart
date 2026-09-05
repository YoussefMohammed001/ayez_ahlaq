import 'package:equatable/equatable.dart';

class ShopPaymentMethod extends Equatable {
  final int id;
  final String name;

  const ShopPaymentMethod({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
