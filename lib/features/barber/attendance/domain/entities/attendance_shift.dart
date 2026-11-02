import 'package:equatable/equatable.dart';
import 'attendance_status.dart';

class AttendanceShift extends Equatable {
  final int id;
  final int barberId;
  final String barberName;
  final DateTime checkInAt;
  final DateTime? checkOutAt;
  final int durationMinutes;
  final AttendanceStatus status;
  final int? checkInDistanceMeters;
  final String? adjustNote;

  const AttendanceShift({
    required this.id,
    required this.barberId,
    required this.barberName,
    required this.checkInAt,
    required this.checkOutAt,
    required this.durationMinutes,
    required this.status,
    required this.checkInDistanceMeters,
    required this.adjustNote,
  });

  bool get isOpen => status == AttendanceStatus.open;

  @override
  List<Object?> get props => [
    id,
    barberId,
    barberName,
    checkInAt,
    checkOutAt,
    durationMinutes,
    status,
    checkInDistanceMeters,
    adjustNote,
  ];
}
