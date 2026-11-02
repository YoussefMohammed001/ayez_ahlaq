import 'package:equatable/equatable.dart';

class TeamAttendanceMember extends Equatable {
  final int barberId;
  final String name;
  final bool owner;
  final bool onShift;
  final DateTime? checkInAt;
  final int todayMinutes;

  const TeamAttendanceMember({
    required this.barberId,
    required this.name,
    required this.owner,
    required this.onShift,
    required this.checkInAt,
    required this.todayMinutes,
  });

  @override
  List<Object?> get props => [
    barberId,
    name,
    owner,
    onShift,
    checkInAt,
    todayMinutes,
  ];
}
