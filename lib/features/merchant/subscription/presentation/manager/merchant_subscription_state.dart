import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_plan.dart';

enum MerchantSubscriptionStatus { initial, loading, success, failure }

class MerchantSubscriptionState extends Equatable {
  final MerchantSubscriptionStatus status;
  final Subscription? subscription;
  final List<SubscriptionPlan> plans;
  final int? subscribingPlanId;
  final String? errorMessage;

  const MerchantSubscriptionState({
    this.status = MerchantSubscriptionStatus.initial,
    this.subscription,
    this.plans = const [],
    this.subscribingPlanId,
    this.errorMessage,
  });

  MerchantSubscriptionState copyWith({
    MerchantSubscriptionStatus? status,
    Subscription? subscription,
    List<SubscriptionPlan>? plans,
    int? subscribingPlanId,
    bool clearSubscribingPlanId = false,
    String? errorMessage,
  }) {
    return MerchantSubscriptionState(
      status: status ?? this.status,
      subscription: subscription ?? this.subscription,
      plans: plans ?? this.plans,
      subscribingPlanId:
          clearSubscribingPlanId ? null : subscribingPlanId ?? this.subscribingPlanId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    subscription,
    plans,
    subscribingPlanId,
    errorMessage,
  ];
}
