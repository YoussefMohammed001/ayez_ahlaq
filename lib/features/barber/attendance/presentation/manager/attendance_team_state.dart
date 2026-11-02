import 'package:equatable/equatable.dart';
import '../../domain/entities/team_attendance_member.dart';

enum AttendanceTeamStatus { initial, loading, success, failure }

class AttendanceTeamState extends Equatable {
  final AttendanceTeamStatus status;
  final List<TeamAttendanceMember> members;
  final DateTime? fetchedAt;
  final String? errorMessage;

  const AttendanceTeamState({
    this.status = AttendanceTeamStatus.initial,
    this.members = const [],
    this.fetchedAt,
    this.errorMessage,
  });

  AttendanceTeamState copyWith({
    AttendanceTeamStatus? status,
    List<TeamAttendanceMember>? members,
    DateTime? fetchedAt,
    String? errorMessage,
  }) {
    return AttendanceTeamState(
      status: status ?? this.status,
      members: members ?? this.members,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, members, fetchedAt, errorMessage];
}
