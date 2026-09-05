import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscription_request.dart';
import '../repos/i_merchant_subscription_repo.dart';

class GetMerchantSubscriptionRequestsUseCase {
  final IMerchantSubscriptionRepo _repo;
  GetMerchantSubscriptionRequestsUseCase(this._repo);
  Future<Either<Failure, List<SubscriptionRequest>>> call() =>
      _repo.getRequests();
}
