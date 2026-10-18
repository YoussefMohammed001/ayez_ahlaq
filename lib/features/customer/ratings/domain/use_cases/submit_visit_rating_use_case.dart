import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/pending_visit_rating.dart';
import '../repos/i_customer_ratings_repo.dart';

class SubmitVisitRatingUseCase {
  final ICustomerRatingsRepo _repo;

  SubmitVisitRatingUseCase(this._repo);

  Future<Either<Failure, Unit>> call({
    required PendingVisitRating pending,
    int? barberStars,
    String? barberNote,
    int? shopStars,
  }) => _repo.submitVisitRating(
    pending: pending,
    barberStars: barberStars,
    barberNote: barberNote,
    shopStars: shopStars,
  );
}
