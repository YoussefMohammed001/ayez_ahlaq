import 'package:equatable/equatable.dart';
import 'store_merchant_phone.dart';

class StoreMerchant extends Equatable {
  final int id;
  final String businessName;
  final String phoneNumber;
  final double rating;
  final int ratingCount;
  final int productCount;
  final bool deliveryOffered;
  final int deliveryFee;
  final int? freeDeliveryOver;
  final List<StoreMerchantPhone> phones;

  const StoreMerchant({
    required this.id,
    required this.businessName,
    required this.phoneNumber,
    required this.rating,
    required this.ratingCount,
    required this.productCount,
    required this.deliveryOffered,
    required this.deliveryFee,
    this.freeDeliveryOver,
    this.phones = const [],
  });

  @override
  List<Object?> get props => [
    id,
    businessName,
    phoneNumber,
    rating,
    ratingCount,
    productCount,
    deliveryOffered,
    deliveryFee,
    freeDeliveryOver,
    phones,
  ];
}
