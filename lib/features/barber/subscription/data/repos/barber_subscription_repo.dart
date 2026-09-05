import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/subscribe_result.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_plan.dart';
import '../../domain/entities/subscription_request.dart';
import '../../domain/repos/i_barber_subscription_repo.dart';
import '../apis/barber_subscription_api.dart';
import '../models/subscribe_result_model.dart';
import '../models/subscription_model.dart';
import '../models/subscription_plan_model.dart';
import '../models/subscription_request_model.dart';

class BarberSubscriptionRepo implements IBarberSubscriptionRepo {
  final BarberSubscriptionApi _api;
  BarberSubscriptionRepo(this._api);

  @override
  Future<Either<Failure, Subscription>> getSubscription() async {
    final result = await _api.getSubscription();
    return result.map(
      (response) => SubscriptionModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, List<SubscriptionPlan>>> getPlans() async {
    final result = await _api.getPlans();
    return result.map((response) {
      final plans = (response['data'] as List?) ?? const [];
      return plans
          .map((e) => SubscriptionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<Either<Failure, SubscribeResult>> subscribe(int planId) async {
    final result = await _api.subscribe(planId);
    return result.map(
      (response) => SubscribeResultModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, List<SubscriptionRequest>>> getRequests() async {
    final result = await _api.getRequests();
    return result.map((response) {
      final requests = (response['data'] as List?) ?? const [];
      return requests
          .map((e) => SubscriptionRequestModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
