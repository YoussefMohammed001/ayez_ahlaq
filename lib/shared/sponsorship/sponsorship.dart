import 'package:equatable/equatable.dart';

class Sponsorship extends Equatable {
  final bool active;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final int? lastPrice;
  final int monthlyPrice;
  final int walletBalance;
  final int walletAvailable;
  final bool canAfford;

  const Sponsorship({
    required this.active,
    required this.monthlyPrice,
    required this.walletBalance,
    required this.walletAvailable,
    required this.canAfford,
    this.startsAt,
    this.endsAt,
    this.lastPrice,
  });

  int? get daysLeft {
    final end = endsAt;
    if (!active || end == null) return null;
    final days = end.difference(DateTime.now()).inDays;
    return days < 0 ? 0 : days;
  }

  int get missingAmount {
    final gap = monthlyPrice - walletAvailable;
    return gap < 0 ? 0 : gap;
  }

  @override
  List<Object?> get props => [
    active,
    startsAt,
    endsAt,
    lastPrice,
    monthlyPrice,
    walletBalance,
    walletAvailable,
    canAfford,
  ];
}
