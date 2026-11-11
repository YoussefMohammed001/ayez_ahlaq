import 'package:equatable/equatable.dart';

class SaleLine extends Equatable {
  final int productId;
  final int quantity;

  const SaleLine({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}
