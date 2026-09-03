import '../../domain/entities/team_member.dart';

class TeamMemberModel extends TeamMember {
  const TeamMemberModel({
    required super.id,
    required super.name,
    required super.owner,
    required super.you,
    required super.rating,
    required super.ratingCount,
    required super.clientsToday,
    required super.clientsThisMonth,
    required super.rank,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      owner: json['owner'] as bool? ?? false,
      you: json['you'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
      clientsToday: (json['clientsToday'] as num?)?.toInt() ?? 0,
      clientsThisMonth: (json['clientsThisMonth'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
    );
  }
}
