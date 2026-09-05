import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscription_plan.dart';
import '../repos/i_barber_subscription_repo.dart';

class GetBarberSubscriptionPlansUseCase {
  final IBarberSubscriptionRepo _repo;
  GetBarberSubscriptionPlansUseCase(this._repo);
  Future<Either<Failure, List<SubscriptionPlan>>> call() => _repo.getPlans();
}
