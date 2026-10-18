import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_rating.dart';
import '../entities/pending_visit_rating.dart';

abstract class ICustomerRatingsRepo {
  Future<Either<Failure, List<CustomerRating>>> getRatings();

  Future<Either<Failure, PendingVisitRating?>> getPendingVisitRating();

  Future<Either<Failure, Unit>> submitVisitRating({
    required PendingVisitRating pending,
    int? barberStars,
    String? barberNote,
    int? shopStars,
  });
}
