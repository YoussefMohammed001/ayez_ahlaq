import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscribe_result.dart';
import '../repos/i_merchant_subscription_repo.dart';

class SubscribeMerchantUseCase {
  final IMerchantSubscriptionRepo _repo;
  SubscribeMerchantUseCase(this._repo);
  Future<Either<Failure, SubscribeResult>> call(int planId) =>
      _repo.subscribe(planId);
}
