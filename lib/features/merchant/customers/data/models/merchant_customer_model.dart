import '../../domain/entities/merchant_customer.dart';

class MerchantCustomerModel extends MerchantCustomer {
  const MerchantCustomerModel({
    required super.barberId,
    required super.barberName,
    required super.shopId,
    required super.shopName,
    required super.phoneNumber,
    required super.orderCount,
    required super.totalSpend,
    super.lastOrderAt,
  });

  factory MerchantCustomerModel.fromJson(Map<String, dynamic> json) {
    return MerchantCustomerModel(
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      orderCount: (json['orderCount'] as num?)?.toInt() ?? 0,
      totalSpend: (json['totalSpend'] as num?)?.toInt() ?? 0,
      lastOrderAt: DateTime.tryParse(json['lastOrderAt'] as String? ?? ''),
    );
  }
}
