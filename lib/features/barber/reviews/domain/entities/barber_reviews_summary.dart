import 'package:equatable/equatable.dart';
import 'barber_review.dart';

class BarberReviewsSummary extends Equatable {
  final double average;
  final int count;
  final List<BarberReview> reviews;

  const BarberReviewsSummary({
    required this.average,
    required this.count,
    required this.reviews,
  });

  @override
  List<Object?> get props => [average, count, reviews];
}
