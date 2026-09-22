import '../../domain/entities/subscription.dart';
import 'subscription_quota_model.dart';

class SubscriptionModel extends Subscription {
  const SubscriptionModel({
    required super.hasSubscription,
    super.planId,
    super.planName,
    required super.fee,
    super.status,
    super.cycleStartedAt,
    super.nextRenewalDate,
    required super.autoCharge,
    super.employees,
    super.ownServices,
    super.notificationsAll,
    super.notificationsZone,
    super.products,
    super.drinks,
    super.ownCategories,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      hasSubscription: json['hasSubscription'] as bool? ?? false,
      planId: json['planId'] as int?,
      planName: json['planName'] as String?,
      fee: json['fee'] as int? ?? 0,
      status: json['status'] as String?,
      cycleStartedAt: DateTime.tryParse(
        json['cycleStartedAt'] as String? ?? '',
      ),
      nextRenewalDate: DateTime.tryParse(
        json['nextRenewalDate'] as String? ?? '',
      ),
      autoCharge: json['autoCharge'] as bool? ?? false,
      employees: SubscriptionQuotaModel.fromJsonOrNull(json['employees']),
      ownServices: SubscriptionQuotaModel.fromJsonOrNull(json['ownServices']),
      notificationsAll: SubscriptionQuotaModel.fromJsonOrNull(
        json['notificationsAll'],
      ),
      notificationsZone: SubscriptionQuotaModel.fromJsonOrNull(
        json['notificationsZone'],
      ),
      products: SubscriptionQuotaModel.fromJsonOrNull(json['products']),
      drinks: SubscriptionQuotaModel.fromJsonOrNull(json['drinks']),
      ownCategories: SubscriptionQuotaModel.fromJsonOrNull(
        json['ownCategories'],
      ),
    );
  }
}
