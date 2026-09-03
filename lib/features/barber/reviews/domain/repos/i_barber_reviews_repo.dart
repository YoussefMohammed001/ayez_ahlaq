import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/barber_reviews_summary.dart';

abstract class IBarberReviewsRepo {
  Future<Either<Failure, BarberReviewsSummary>> getReviews();
}
