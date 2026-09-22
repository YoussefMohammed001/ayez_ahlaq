import 'package:equatable/equatable.dart';

class HomeServiceAdjustment extends Equatable {
  final int id;
  final String label;
  final num amount;

  const HomeServiceAdjustment({
    required this.id,
    required this.label,
    required this.amount,
  });

  @override
  List<Object?> get props => [id, label, amount];
}
