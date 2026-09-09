import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_rating.dart';
import '../repos/i_customer_ratings_repo.dart';

class GetCustomerRatingsUseCase {
  final ICustomerRatingsRepo _repo;

  GetCustomerRatingsUseCase(this._repo);

  Future<Either<Failure, List<CustomerRating>>> call() => _repo.getRatings();
}
