import '../../domain/entities/barber_invite_preview.dart';

class BarberInvitePreviewModel extends BarberInvitePreview {
  const BarberInvitePreviewModel({
    required super.code,
    required super.barberId,
    required super.barberName,
    required super.shopId,
    required super.shopName,
    required super.rating,
    required super.ratingCount,
    super.tagline,
    super.area,
    super.address,
  });

  factory BarberInvitePreviewModel.fromJson(Map<String, dynamic> json) {
    return BarberInvitePreviewModel(
      code: json['code'] as String? ?? '',
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      tagline: json['tagline'] as String?,
      shopId: (json['shopId'] as num?)?.toInt() ?? 0,
      shopName: json['shopName'] as String? ?? '',
      area: json['area'] as String?,
      address: json['address'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
    );
  }
}
