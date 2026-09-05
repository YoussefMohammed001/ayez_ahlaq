import 'package:equatable/equatable.dart';

class SubscriptionPlan extends Equatable {
  final int id;
  final String name;
  final int price;
  final int? employeeCap;
  final int? notificationQuotaAll;
  final int? notificationQuotaZone;
  final int? productCap;
  final int? ownCategoryCap;
  final int? notificationOveragePrice;
  final DateTime? availableUntil;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    this.employeeCap,
    this.notificationQuotaAll,
    this.notificationQuotaZone,
    this.productCap,
    this.ownCategoryCap,
    this.notificationOveragePrice,
    this.availableUntil,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    employeeCap,
    notificationQuotaAll,
    notificationQuotaZone,
    productCap,
    ownCategoryCap,
    notificationOveragePrice,
    availableUntil,
  ];
}
