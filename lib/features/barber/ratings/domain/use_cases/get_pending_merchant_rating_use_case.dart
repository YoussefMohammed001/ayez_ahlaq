import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/pending_merchant_rating.dart';
import '../repos/i_barber_ratings_repo.dart';

class GetPendingMerchantRatingUseCase {
  final IBarberRatingsRepo _repo;

  GetPendingMerchantRatingUseCase(this._repo);

  Future<Either<Failure, PendingMerchantRating?>> call() =>
      _repo.getPendingMerchantRating();
}
