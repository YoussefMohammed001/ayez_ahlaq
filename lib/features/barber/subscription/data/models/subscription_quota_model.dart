import '../../domain/entities/subscription_quota.dart';

class SubscriptionQuotaModel extends SubscriptionQuota {
  const SubscriptionQuotaModel({
    super.cap,
    required super.used,
    super.remaining,
  });

  factory SubscriptionQuotaModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionQuotaModel(
      cap: json['cap'] as int?,
      used: json['used'] as int? ?? 0,
      remaining: json['remaining'] as int?,
    );
  }

  static SubscriptionQuotaModel? fromJsonOrNull(dynamic json) {
    if (json is! Map<String, dynamic>) return null;
    return SubscriptionQuotaModel.fromJson(json);
  }
}
