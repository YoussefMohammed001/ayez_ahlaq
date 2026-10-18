import '../../../../../shared/rating_target.dart';
import '../../domain/entities/customer_rating.dart';

class CustomerRatingModel extends CustomerRating {
  const CustomerRatingModel({
    required super.id,
    required super.target,
    required super.targetId,
    required super.targetName,
    required super.stars,
    super.note,
    super.bookingId,
    super.homeServiceRequestId,
    super.createdAt,
  });

  factory CustomerRatingModel.fromJson(Map<String, dynamic> json) {
    return CustomerRatingModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      target: RatingTarget.fromApi(json['targetType'] as String?),
      targetId: (json['targetId'] as num?)?.toInt() ?? 0,
      targetName: json['targetName'] as String? ?? '',
      stars: (json['stars'] as num?)?.toInt() ?? 0,
      note: json['note'] as String?,
      bookingId: (json['bookingId'] as num?)?.toInt(),
      homeServiceRequestId: (json['homeServiceRequestId'] as num?)?.toInt(),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
