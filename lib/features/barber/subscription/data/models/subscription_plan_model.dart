import '../../domain/entities/subscription_plan.dart';

class SubscriptionPlanModel extends SubscriptionPlan {
  const SubscriptionPlanModel({
    required super.id,
    required super.name,
    required super.price,
    super.employeeCap,
    super.ownServiceCap,
    super.notificationQuotaAll,
    super.notificationQuotaZone,
    super.productCap,
    super.drinkCap,
    super.ownCategoryCap,
    super.notificationOveragePrice,
    super.availableUntil,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      employeeCap: json['employeeCap'] as int?,
      ownServiceCap: json['ownServiceCap'] as int?,
      notificationQuotaAll: json['notificationQuotaAll'] as int?,
      notificationQuotaZone: json['notificationQuotaZone'] as int?,
      productCap: json['productCap'] as int?,
      drinkCap: json['drinkCap'] as int?,
      ownCategoryCap: json['ownCategoryCap'] as int?,
      notificationOveragePrice: json['notificationOveragePrice'] as int?,
      availableUntil: DateTime.tryParse(
        json['availableUntil'] as String? ?? '',
      ),
    );
  }
}
