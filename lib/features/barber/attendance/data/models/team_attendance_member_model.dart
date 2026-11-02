import '../../domain/entities/team_attendance_member.dart';

class TeamAttendanceMemberModel extends TeamAttendanceMember {
  const TeamAttendanceMemberModel({
    required super.barberId,
    required super.name,
    required super.owner,
    required super.onShift,
    required super.checkInAt,
    required super.todayMinutes,
  });

  factory TeamAttendanceMemberModel.fromJson(Map<String, dynamic> json) {
    final checkInAt = json['checkInAt'] as String?;

    return TeamAttendanceMemberModel(
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      owner: json['owner'] as bool? ?? false,
      onShift: json['onShift'] as bool? ?? false,
      checkInAt: checkInAt == null ? null : DateTime.parse(checkInAt),
      todayMinutes: (json['todayMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}
