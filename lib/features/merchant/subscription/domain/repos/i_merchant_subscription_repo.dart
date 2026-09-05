import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscribe_result.dart';
import '../entities/subscription.dart';
import '../entities/subscription_plan.dart';
import '../entities/subscription_request.dart';

abstract class IMerchantSubscriptionRepo {
  Future<Either<Failure, Subscription>> getSubscription();
  Future<Either<Failure, List<SubscriptionPlan>>> getPlans();
  Future<Either<Failure, SubscribeResult>> subscribe(int planId);
  Future<Either<Failure, List<SubscriptionRequest>>> getRequests();
}
