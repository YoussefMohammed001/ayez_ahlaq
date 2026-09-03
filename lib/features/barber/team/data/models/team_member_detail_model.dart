import '../../domain/entities/team_member_detail.dart';

class TeamMemberDetailModel extends TeamMemberDetail {
  const TeamMemberDetailModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.tagline,
    required super.available,
    required super.active,
    required super.mustChangePassword,
    required super.rating,
    required super.ratingCount,
  });

  factory TeamMemberDetailModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberDetailModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      available: json['available'] as bool? ?? false,
      active: json['active'] as bool? ?? true,
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
    );
  }
}
