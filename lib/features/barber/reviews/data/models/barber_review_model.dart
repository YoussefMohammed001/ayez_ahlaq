import '../../domain/entities/barber_review.dart';

class BarberReviewModel extends BarberReview {
  const BarberReviewModel({
    required super.id,
    required super.stars,
    required super.customerName,
    required super.bookingId,
    super.note,
    super.createdAt,
  });

  factory BarberReviewModel.fromJson(Map<String, dynamic> json) {
    return BarberReviewModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      stars: (json['stars'] as num?)?.toInt() ?? 0,
      customerName: json['customerName'] as String? ?? '',
      bookingId: (json['bookingId'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
