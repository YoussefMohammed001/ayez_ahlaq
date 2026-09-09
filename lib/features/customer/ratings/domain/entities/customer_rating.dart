import 'package:equatable/equatable.dart';
import '../../../booking/domain/entities/rating_target.dart';

class CustomerRating extends Equatable {
  final int id;
  final int bookingId;
  final RatingTarget target;
  final int stars;
  final String? note;
  final String? barberName;
  final String? shopName;
  final DateTime? createdAt;

  const CustomerRating({
    required this.id,
    required this.bookingId,
    required this.target,
    required this.stars,
    this.note,
    this.barberName,
    this.shopName,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    bookingId,
    target,
    stars,
    note,
    barberName,
    shopName,
    createdAt,
  ];
}
