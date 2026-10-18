import '../../domain/entities/store_merchant_phone.dart';

class StoreMerchantPhoneModel extends StoreMerchantPhone {
  const StoreMerchantPhoneModel({required super.phoneNumber, super.label});

  factory StoreMerchantPhoneModel.fromJson(Map<String, dynamic> json) {
    return StoreMerchantPhoneModel(
      phoneNumber: json['phoneNumber'] as String? ?? '',
      label: json['label'] as String?,
    );
  }
}
