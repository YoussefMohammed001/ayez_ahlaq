import '../../domain/entities/merchant_dashboard.dart';

class MerchantDashboardModel extends MerchantDashboard {
  const MerchantDashboardModel({
    required super.pendingOrders,
    required super.activeOrders,
    required super.deliveredThisMonth,
    required super.monthRevenue,
    required super.productCount,
    required super.liveDiscounts,
  });

  factory MerchantDashboardModel.fromJson(Map<String, dynamic> json) {
    return MerchantDashboardModel(
      pendingOrders: (json['pendingOrders'] as num?)?.toInt() ?? 0,
      activeOrders: (json['activeOrders'] as num?)?.toInt() ?? 0,
      deliveredThisMonth: (json['deliveredThisMonth'] as num?)?.toInt() ?? 0,
      monthRevenue: (json['monthRevenue'] as num?)?.toInt() ?? 0,
      productCount: (json['productCount'] as num?)?.toInt() ?? 0,
      liveDiscounts: (json['liveDiscounts'] as num?)?.toInt() ?? 0,
    );
  }
}
