import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/customer_rating.dart';
import '../../domain/entities/pending_rating_kind.dart';
import '../../domain/entities/pending_visit_rating.dart';
import '../../domain/repos/i_customer_ratings_repo.dart';
import '../apis/customer_ratings_api.dart';
import '../models/customer_rating_model.dart';
import '../models/pending_visit_rating_model.dart';

class CustomerRatingsRepo implements ICustomerRatingsRepo {
  final CustomerRatingsApi _api;

  CustomerRatingsRepo(this._api);

  @override
  Future<Either<Failure, List<CustomerRating>>> getRatings() async {
    final result = await _api.getRatings();
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map((json) => CustomerRatingModel.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<Either<Failure, PendingVisitRating?>> getPendingVisitRating() async {
    final result = await _api.getPendingVisitRating();
    return result.map(
      (response) => PendingVisitRatingModel.fromResponseData(response['data']),
    );
  }

  @override
  Future<Either<Failure, Unit>> submitVisitRating({
    required PendingVisitRating pending,
    int? barberStars,
    String? barberNote,
    int? shopStars,
  }) async {
    final result = pending.kind == PendingRatingKind.order
        ? await _api.submitOrderRating({
            'orderId': pending.referenceId,
            'stars': shopStars,
          })
        : await _submitBookingRating(
            pending.referenceId,
            barberStars,
            barberNote,
            shopStars,
          );
    return result.map((_) => unit);
  }

  Future<Either<Failure, dynamic>> _submitBookingRating(
    int bookingId,
    int? barberStars,
    String? barberNote,
    int? shopStars,
  ) {
    return _api.submitVisitRating({
      'bookingId': bookingId,
      if (barberStars != null)
        'barber': {
          'stars': barberStars,
          if (barberNote != null) 'note': barberNote,
        },
      if (shopStars != null) 'shop': {'stars': shopStars},
    });
  }
}
