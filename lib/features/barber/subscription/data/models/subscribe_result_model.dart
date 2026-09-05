import '../../domain/entities/subscribe_result.dart';
import 'subscription_model.dart';
import 'subscription_request_model.dart';

class SubscribeResultModel extends SubscribeResult {
  const SubscribeResultModel({
    required super.activated,
    super.subscription,
    super.request,
  });

  factory SubscribeResultModel.fromJson(Map<String, dynamic> json) {
    final subscriptionJson = json['subscription'];
    final requestJson = json['request'];
    return SubscribeResultModel(
      activated: json['activated'] as bool? ?? false,
      subscription: subscriptionJson is Map<String, dynamic>
          ? SubscriptionModel.fromJson(subscriptionJson)
          : null,
      request: requestJson is Map<String, dynamic>
          ? SubscriptionRequestModel.fromJson(requestJson)
          : null,
    );
  }
}
