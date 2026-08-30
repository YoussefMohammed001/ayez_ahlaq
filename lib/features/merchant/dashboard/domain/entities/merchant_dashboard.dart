import 'package:equatable/equatable.dart';

class MerchantDashboard extends Equatable {
  final int pendingOrders;
  final int activeOrders;
  final int deliveredThisMonth;
  final int monthRevenue;
  final int productCount;
  final int liveDiscounts;

  const MerchantDashboard({
    required this.pendingOrders,
    required this.activeOrders,
    required this.deliveredThisMonth,
    required this.monthRevenue,
    required this.productCount,
    required this.liveDiscounts,
  });

  @override
  List<Object?> get props => [
    pendingOrders,
    activeOrders,
    deliveredThisMonth,
    monthRevenue,
    productCount,
    liveDiscounts,
  ];
}
