import 'package:equatable/equatable.dart';

class SubscriptionPlan extends Equatable {
  final int id;
  final String name;
  final int price;
  final int? employeeCap;
  final int? ownServiceCap;
  final int? notificationQuotaAll;
  final int? notificationQuotaZone;
  final int? productCap;
  final int? drinkCap;
  final int? ownCategoryCap;
  final int? notificationOveragePrice;
  final DateTime? availableUntil;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    this.employeeCap,
    this.ownServiceCap,
    this.notificationQuotaAll,
    this.notificationQuotaZone,
    this.productCap,
    this.drinkCap,
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
    ownServiceCap,
    notificationQuotaAll,
    notificationQuotaZone,
    productCap,
    drinkCap,
    ownCategoryCap,
    notificationOveragePrice,
    availableUntil,
  ];
}
