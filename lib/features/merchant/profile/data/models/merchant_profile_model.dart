import '../../domain/entities/merchant_profile.dart';

class MerchantProfileModel extends MerchantProfile {
  const MerchantProfileModel({
    required super.id,
    required super.businessName,
    required super.ownerName,
    required super.phoneNumber,
    required super.active,
    required super.mustChangePassword,
    required super.categoryLimit,
    super.phoneE164,
    super.email,
    super.userName,
    super.createdAt,
  });

  factory MerchantProfileModel.fromJson(Map<String, dynamic> json) {
    return MerchantProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      businessName: json['businessName'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      phoneE164: json['phoneE164'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      active: json['active'] as bool? ?? false,
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
      categoryLimit: (json['categoryLimit'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }
}
