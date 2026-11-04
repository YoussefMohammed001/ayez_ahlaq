import '../../domain/entities/attendance_feature_request.dart';
import '../../domain/entities/attendance_feature_request_status.dart';

class AttendanceFeatureRequestModel extends AttendanceFeatureRequest {
  const AttendanceFeatureRequestModel({
    required super.id,
    required super.status,
    required super.price,
    required super.createdAt,
    required super.decidedAt,
    required super.note,
  });

  factory AttendanceFeatureRequestModel.fromJson(Map<String, dynamic> json) {
    return AttendanceFeatureRequestModel(
      id: (json['id'] as num?)?.toInt(),
      status: AttendanceFeatureRequestStatus.fromApi(json['status'] as String?),
      price: json['price'] as num?,
      createdAt: _date(json, const ['createdAt', 'requestedAt']),
      decidedAt: _date(json, const ['decidedAt', 'reviewedAt', 'updatedAt']),
      note: _text(json, const ['note', 'decisionNote', 'adminNote', 'reason']),
    );
  }

  static DateTime? _date(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String) return DateTime.tryParse(value);
    }
    return null;
  }

  static String? _text(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value is String && value.isNotEmpty) return value;
    }
    return null;
  }
}
