import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_rating.dart';

abstract class ICustomerRatingsRepo {
  Future<Either<Failure, List<CustomerRating>>> getRatings();
}
