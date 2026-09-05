import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscription.dart';
import '../repos/i_merchant_subscription_repo.dart';

class GetMerchantSubscriptionUseCase {
  final IMerchantSubscriptionRepo _repo;
  GetMerchantSubscriptionUseCase(this._repo);
  Future<Either<Failure, Subscription>> call() => _repo.getSubscription();
}
