import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_reviews_summary.dart';
import '../repos/i_barber_reviews_repo.dart';

class GetBarberReviewsUseCase {
  final IBarberReviewsRepo _repo;

  GetBarberReviewsUseCase(this._repo);

  Future<Either<Failure, BarberReviewsSummary>> call() => _repo.getReviews();
}
