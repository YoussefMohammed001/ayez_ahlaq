import '../../../booking/domain/entities/rating_target.dart';
import '../../domain/entities/customer_rating.dart';

class CustomerRatingModel extends CustomerRating {
  const CustomerRatingModel({
    required super.id,
    required super.bookingId,
    required super.target,
    required super.stars,
    super.note,
    super.barberName,
    super.shopName,
    super.createdAt,
  });

  factory CustomerRatingModel.fromJson(Map<String, dynamic> json) {
    return CustomerRatingModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      bookingId: (json['bookingId'] as num?)?.toInt() ?? 0,
      target: RatingTarget.fromApi(json['target'] as String?),
      stars: (json['stars'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
      barberName: json['barberName'] as String?,
      shopName: json['shopName'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
