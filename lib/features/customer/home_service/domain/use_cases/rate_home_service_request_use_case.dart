import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../shared/rating_target.dart';
import '../repos/i_customer_home_service_repo.dart';

class RateHomeServiceRequestUseCase {
  final ICustomerHomeServiceRepo _repo;

  RateHomeServiceRequestUseCase(this._repo);

  Future<Either<Failure, Unit>> call({
    required int homeServiceRequestId,
    required RatingTarget target,
    required int stars,
    String? note,
  }) => _repo.rate(
    homeServiceRequestId: homeServiceRequestId,
    target: target,
    stars: stars,
    note: note,
  );
}
