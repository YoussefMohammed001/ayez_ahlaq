import '../../../../barber/attendance/domain/entities/team_attendance_member.dart';

class MerchantTeamAttendanceModel extends TeamAttendanceMember {
  const MerchantTeamAttendanceModel({
    required super.barberId,
    required super.name,
    required super.owner,
    required super.onShift,
    required super.checkInAt,
    required super.todayMinutes,
  });

  factory MerchantTeamAttendanceModel.fromJson(Map<String, dynamic> json) {
    return MerchantTeamAttendanceModel(
      barberId: (json['merchantMemberId'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      owner: false,
      onShift: json['checkedIn'] as bool? ?? false,
      checkInAt: DateTime.tryParse(json['checkedInSince'] as String? ?? ''),
      todayMinutes: (json['todayMinutes'] as num?)?.toInt() ?? 0,
    );
  }
}
