import 'package:equatable/equatable.dart';
import 'subscription.dart';
import 'subscription_request.dart';

class SubscribeResult extends Equatable {
  final bool activated;
  final Subscription? subscription;
  final SubscriptionRequest? request;

  const SubscribeResult({
    required this.activated,
    this.subscription,
    this.request,
  });

  @override
  List<Object?> get props => [activated, subscription, request];
}
