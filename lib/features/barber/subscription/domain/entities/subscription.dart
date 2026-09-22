import 'package:equatable/equatable.dart';
import 'subscription_quota.dart';

class Subscription extends Equatable {
  final bool hasSubscription;
  final int? planId;
  final String? planName;
  final int fee;
  final String? status;
  final DateTime? cycleStartedAt;
  final DateTime? nextRenewalDate;
  final bool autoCharge;
  final SubscriptionQuota? employees;
  final SubscriptionQuota? ownServices;
  final SubscriptionQuota? notificationsAll;
  final SubscriptionQuota? notificationsZone;
  final SubscriptionQuota? products;
  final SubscriptionQuota? drinks;
  final SubscriptionQuota? ownCategories;

  const Subscription({
    required this.hasSubscription,
    this.planId,
    this.planName,
    required this.fee,
    this.status,
    this.cycleStartedAt,
    this.nextRenewalDate,
    required this.autoCharge,
    this.employees,
    this.ownServices,
    this.notificationsAll,
    this.notificationsZone,
    this.products,
    this.drinks,
    this.ownCategories,
  });

  @override
  List<Object?> get props => [
    hasSubscription,
    planId,
    planName,
    fee,
    status,
    cycleStartedAt,
    nextRenewalDate,
    autoCharge,
    employees,
    ownServices,
    notificationsAll,
    notificationsZone,
    products,
    drinks,
    ownCategories,
  ];
}
