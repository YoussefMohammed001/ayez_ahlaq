import '../../domain/entities/customer_profile.dart';

class CustomerProfileModel extends CustomerProfile {
  const CustomerProfileModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    super.email,
    required super.active,
    required super.otpVerified,
    required super.rating,
    required super.ratingCount,
    required super.createdAt,
  });

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    return CustomerProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['userName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String?,
      active: json['active'] as bool? ?? false,
      otpVerified: json['otpVerified'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
