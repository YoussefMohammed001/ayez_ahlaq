import 'package:equatable/equatable.dart';

class AttendanceSettingLogEntry extends Equatable {
  final int id;
  final String actorName;
  final int? oldRangeMeters;
  final int? newRangeMeters;
  final bool oldEnforced;
  final bool newEnforced;
  final DateTime createdAt;

  const AttendanceSettingLogEntry({
    required this.id,
    required this.actorName,
    required this.oldRangeMeters,
    required this.newRangeMeters,
    required this.oldEnforced,
    required this.newEnforced,
    required this.createdAt,
  });

  bool get rangeChanged => oldRangeMeters != newRangeMeters;

  bool get enforcedChanged => oldEnforced != newEnforced;

  @override
  List<Object?> get props => [
    id,
    actorName,
    oldRangeMeters,
    newRangeMeters,
    oldEnforced,
    newEnforced,
    createdAt,
  ];
}
