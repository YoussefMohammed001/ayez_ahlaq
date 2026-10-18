import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/pending_merchant_rating.dart';
import '../../domain/repos/i_barber_ratings_repo.dart';
import '../apis/barber_ratings_api.dart';
import '../models/pending_merchant_rating_model.dart';

class BarberRatingsRepo implements IBarberRatingsRepo {
  final BarberRatingsApi _api;

  BarberRatingsRepo(this._api);

  @override
  Future<Either<Failure, PendingMerchantRating?>>
  getPendingMerchantRating() async {
    final result = await _api.getPendingMerchantRating();
    return result.map(
      (response) =>
          PendingMerchantRatingModel.fromResponseData(response['data']),
    );
  }

  @override
  Future<Either<Failure, Unit>> submitMerchantRating({
    required int orderId,
    required int stars,
    String? note,
  }) async {
    final result = await _api.submitMerchantRating({
      'orderId': orderId,
      'stars': stars,
      if (note != null) 'note': note,
    });
    return result.map((_) => unit);
  }
}
