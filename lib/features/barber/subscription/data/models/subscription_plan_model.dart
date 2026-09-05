import '../../domain/entities/subscription_plan.dart';

class SubscriptionPlanModel extends SubscriptionPlan {
  const SubscriptionPlanModel({
    required super.id,
    required super.name,
    required super.price,
    super.employeeCap,
    super.notificationQuotaAll,
    super.notificationQuotaZone,
    super.productCap,
    super.ownCategoryCap,
    super.notificationOveragePrice,
    super.availableUntil,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      employeeCap: json['employeeCap'] as int?,
      notificationQuotaAll: json['notificationQuotaAll'] as int?,
      notificationQuotaZone: json['notificationQuotaZone'] as int?,
      productCap: json['productCap'] as int?,
      ownCategoryCap: json['ownCategoryCap'] as int?,
      notificationOveragePrice: json['notificationOveragePrice'] as int?,
      availableUntil: DateTime.tryParse(json['availableUntil'] as String? ?? ''),
    );
  }
}
