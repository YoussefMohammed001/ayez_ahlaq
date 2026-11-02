import '../../domain/entities/attendance_shift.dart';
import '../../domain/entities/attendance_status.dart';

class AttendanceShiftModel extends AttendanceShift {
  const AttendanceShiftModel({
    required super.id,
    required super.barberId,
    required super.barberName,
    required super.checkInAt,
    required super.checkOutAt,
    required super.durationMinutes,
    required super.status,
    required super.checkInDistanceMeters,
    required super.adjustNote,
  });

  factory AttendanceShiftModel.fromJson(Map<String, dynamic> json) {
    final checkOut = json['checkOutAt'] as String?;

    return AttendanceShiftModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      barberId: (json['barberId'] as num?)?.toInt() ?? 0,
      barberName: json['barberName'] as String? ?? '',
      checkInAt: DateTime.parse(json['checkInAt'] as String),
      checkOutAt: checkOut == null ? null : DateTime.parse(checkOut),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      status: AttendanceStatus.fromApi(json['status'] as String?),
      checkInDistanceMeters: (json['checkInDistanceMeters'] as num?)?.toInt(),
      adjustNote: json['adjustNote'] as String?,
    );
  }
}
