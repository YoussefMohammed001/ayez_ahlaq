import 'package:equatable/equatable.dart';
import '../../../../../shared/rating_target.dart';

class CustomerRating extends Equatable {
  final int id;
  final RatingTarget target;
  final int targetId;
  final String targetName;
  final int stars;
  final String? note;
  final int? bookingId;
  final int? homeServiceRequestId;
  final DateTime? createdAt;

  const CustomerRating({
    required this.id,
    required this.target,
    required this.targetId,
    required this.targetName,
    required this.stars,
    this.note,
    this.bookingId,
    this.homeServiceRequestId,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    target,
    targetId,
    targetName,
    stars,
    note,
    bookingId,
    homeServiceRequestId,
    createdAt,
  ];
}
