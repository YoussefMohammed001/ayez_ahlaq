import '../../domain/entities/merchant_phone.dart';

class MerchantPhoneModel extends MerchantPhone {
  const MerchantPhoneModel({
    required super.id,
    required super.phoneNumber,
    super.countryCode,
    super.label,
  });

  factory MerchantPhoneModel.fromJson(Map<String, dynamic> json) {
    return MerchantPhoneModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      countryCode: json['countryCode'] as String?,
      label: json['label'] as String?,
    );
  }
}
