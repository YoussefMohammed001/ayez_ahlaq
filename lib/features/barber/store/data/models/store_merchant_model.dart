import '../../domain/entities/store_merchant.dart';
import 'store_merchant_phone_model.dart';

class StoreMerchantModel extends StoreMerchant {
  const StoreMerchantModel({
    required super.id,
    required super.businessName,
    required super.phoneNumber,
    required super.rating,
    required super.ratingCount,
    required super.productCount,
    required super.deliveryOffered,
    required super.deliveryFee,
    super.freeDeliveryOver,
    super.phones,
  });

  factory StoreMerchantModel.fromJson(Map<String, dynamic> json) {
    return StoreMerchantModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      businessName: json['businessName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      productCount: (json['productCount'] as num?)?.toInt() ?? 0,
      deliveryOffered: json['deliveryOffered'] as bool? ?? false,
      deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 0,
      freeDeliveryOver: (json['freeDeliveryOver'] as num?)?.toInt(),
      phones: (json['phones'] as List?)
              ?.map(
                (e) =>
                    StoreMerchantPhoneModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}
