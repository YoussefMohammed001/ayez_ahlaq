import '../../domain/entities/attendance_config.dart';

class AttendanceConfigModel extends AttendanceConfig {
  const AttendanceConfigModel({
    required super.shopLat,
    required super.shopLng,
    required super.rangeMeters,
    required super.enforced,
  });

  factory AttendanceConfigModel.fromJson(Map<String, dynamic> json) {
    return AttendanceConfigModel(
      shopLat: ((json['shopLat'] ?? json['merchantLat']) as num?)?.toDouble(),
      shopLng: ((json['shopLng'] ?? json['merchantLng']) as num?)?.toDouble(),
      rangeMeters: (json['rangeMeters'] as num?)?.toInt(),
      enforced: json['enforced'] as bool? ?? false,
    );
  }
}
