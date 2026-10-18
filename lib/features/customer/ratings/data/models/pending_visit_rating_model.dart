import '../../domain/entities/pending_rating_kind.dart';
import '../../domain/entities/pending_visit_rating.dart';

class PendingVisitRatingModel extends PendingVisitRating {
  const PendingVisitRatingModel({
    required super.kind,
    required super.referenceId,
    required super.barberName,
    required super.shopName,
    required super.canRateBarber,
    required super.canRateShop,
  });

  static PendingVisitRatingModel? fromResponseData(dynamic data) {
    final json = data is List ? (data.isEmpty ? null : data.first) : data;
    if (json is! Map<String, dynamic>) return null;
    final kind = _kindFrom(json['kind']);
    final referenceId = json['referenceId'] as int?;
    if (kind == null || referenceId == null) return null;

    final canRateBarber = json['canRateBarber'] as bool? ?? true;
    final canRateShop = json['canRateShop'] as bool? ?? true;
    if (!canRateBarber && !canRateShop) return null;

    return PendingVisitRatingModel(
      kind: kind,
      referenceId: referenceId,
      barberName: json['barberName'] as String? ?? '',
      shopName: json['shopName'] as String? ?? '',
      canRateBarber: canRateBarber,
      canRateShop: canRateShop,
    );
  }

  static PendingRatingKind? _kindFrom(dynamic value) => switch (value) {
    'BOOKING' => PendingRatingKind.booking,
    'ORDER' => PendingRatingKind.order,
    _ => null,
  };
}
