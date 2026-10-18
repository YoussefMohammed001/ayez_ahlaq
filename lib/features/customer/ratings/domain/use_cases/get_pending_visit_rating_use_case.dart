import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/pending_visit_rating.dart';
import '../repos/i_customer_ratings_repo.dart';

class GetPendingVisitRatingUseCase {
  final ICustomerRatingsRepo _repo;

  GetPendingVisitRatingUseCase(this._repo);

  Future<Either<Failure, PendingVisitRating?>> call() =>
      _repo.getPendingVisitRating();
}
