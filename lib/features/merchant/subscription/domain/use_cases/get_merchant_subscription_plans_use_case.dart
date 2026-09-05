import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscription_plan.dart';
import '../repos/i_merchant_subscription_repo.dart';

class GetMerchantSubscriptionPlansUseCase {
  final IMerchantSubscriptionRepo _repo;
  GetMerchantSubscriptionPlansUseCase(this._repo);
  Future<Either<Failure, List<SubscriptionPlan>>> call() => _repo.getPlans();
}
