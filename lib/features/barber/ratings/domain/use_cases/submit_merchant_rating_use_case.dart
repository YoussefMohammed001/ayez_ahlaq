import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_ratings_repo.dart';

class SubmitMerchantRatingUseCase {
  final IBarberRatingsRepo _repo;

  SubmitMerchantRatingUseCase(this._repo);

  Future<Either<Failure, Unit>> call({
    required int orderId,
    required int stars,
    String? note,
  }) => _repo.submitMerchantRating(orderId: orderId, stars: stars, note: note);
}
