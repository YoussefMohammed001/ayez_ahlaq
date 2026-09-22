import 'package:equatable/equatable.dart';

class MoneySummary extends Equatable {
  final int totalAdded;
  final int totalSubtracted;
  final int net;

  const MoneySummary({
    required this.totalAdded,
    required this.totalSubtracted,
    required this.net,
  });

  @override
  List<Object?> get props => [totalAdded, totalSubtracted, net];
}
