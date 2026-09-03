import '../../domain/entities/barber_invite.dart';

class BarberInviteModel extends BarberInvite {
  const BarberInviteModel({
    required super.code,
    required super.url,
    required super.favoriteCount,
  });

  factory BarberInviteModel.fromJson(Map<String, dynamic> json) {
    return BarberInviteModel(
      code: json['code'] as String? ?? '',
      url: json['url'] as String? ?? '',
      favoriteCount: (json['favoriteCount'] as num?)?.toInt() ?? 0,
    );
  }
}
