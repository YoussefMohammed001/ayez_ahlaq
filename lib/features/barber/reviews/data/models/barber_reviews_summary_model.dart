import '../../domain/entities/barber_reviews_summary.dart';
import 'barber_review_model.dart';

class BarberReviewsSummaryModel extends BarberReviewsSummary {
  const BarberReviewsSummaryModel({
    required super.average,
    required super.count,
    required super.reviews,
  });

  factory BarberReviewsSummaryModel.fromJson(Map<String, dynamic> json) {
    final reviews = (json['reviews'] as List?) ?? const [];
    return BarberReviewsSummaryModel(
      average: (json['average'] as num?)?.toDouble() ?? 0,
      count: (json['count'] as num?)?.toInt() ?? 0,
      reviews: reviews
          .map((e) => BarberReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
