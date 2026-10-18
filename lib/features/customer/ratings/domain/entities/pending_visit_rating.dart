import 'package:equatable/equatable.dart';
import 'pending_rating_kind.dart';

class PendingVisitRating extends Equatable {
  final PendingRatingKind kind;
  final int referenceId;
  final String barberName;
  final String shopName;
  final bool canRateBarber;
  final bool canRateShop;

  const PendingVisitRating({
    required this.kind,
    required this.referenceId,
    required this.barberName,
    required this.shopName,
    required this.canRateBarber,
    required this.canRateShop,
  });

  @override
  List<Object?> get props => [
    kind,
    referenceId,
    barberName,
    shopName,
    canRateBarber,
    canRateShop,
  ];
}
