import 'package:equatable/equatable.dart';

class MerchantCustomer extends Equatable {
  final int barberId;
  final String barberName;
  final int shopId;
  final String shopName;
  final String phoneNumber;
  final int orderCount;
  final int totalSpend;
  final DateTime? lastOrderAt;

  const MerchantCustomer({
    required this.barberId,
    required this.barberName,
    required this.shopId,
    required this.shopName,
    required this.phoneNumber,
    required this.orderCount,
    required this.totalSpend,
    this.lastOrderAt,
  });

  @override
  List<Object?> get props => [
    barberId,
    barberName,
    shopId,
    shopName,
    phoneNumber,
    orderCount,
    totalSpend,
    lastOrderAt,
  ];
}
