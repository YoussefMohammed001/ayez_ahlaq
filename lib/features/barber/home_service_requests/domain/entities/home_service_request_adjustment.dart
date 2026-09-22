import 'package:equatable/equatable.dart';

class HomeServiceRequestAdjustment extends Equatable {
  final int? id;
  final String label;
  final num amount;

  const HomeServiceRequestAdjustment({
    this.id,
    required this.label,
    required this.amount,
  });

  bool get isDiscount => amount < 0;

  @override
  List<Object?> get props => [id, label, amount];
}
