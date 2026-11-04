import '../../domain/entities/attendance_feature_request_status.dart';
import '../../domain/entities/attendance_feature_state.dart';
import '../../domain/entities/attendance_feature_status.dart';
import 'attendance_feature_request_model.dart';

class AttendanceFeatureStatusModel extends AttendanceFeatureStatus {
  const AttendanceFeatureStatusModel({
    required super.enabled,
    required super.state,
    required super.owner,
    required super.message,
    required super.price,
    required super.startDate,
    required super.endDate,
    required super.daysLeft,
    required super.autoRenew,
    required super.canRequest,
    required super.pendingRequest,
  });

  factory AttendanceFeatureStatusModel.fromJson(Map<String, dynamic> json) {
    return AttendanceFeatureStatusModel(
      enabled: json['enabled'] as bool? ?? false,
      state: AttendanceFeatureState.fromApi(json['state'] as String?),
      owner: json['owner'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      startDate: _date(json['startDate']),
      endDate: _date(json['endDate']),
      daysLeft: (json['daysLeft'] as num?)?.toInt(),
      autoRenew: json['autoRenew'] as bool? ?? false,
      canRequest: json['canRequest'] as bool? ?? false,
      pendingRequest: _pending(json['pendingRequest']),
    );
  }

  static DateTime? _date(dynamic value) =>
      value is String ? DateTime.tryParse(value) : null;

  static AttendanceFeatureRequestModel? _pending(dynamic value) {
    if (value is Map<String, dynamic>) {
      return AttendanceFeatureRequestModel.fromJson(value);
    }
    if (value is num) {
      return AttendanceFeatureRequestModel(
        id: value.toInt(),
        status: AttendanceFeatureRequestStatus.pending,
        price: null,
        createdAt: null,
        decidedAt: null,
        note: null,
      );
    }
    return null;
  }
}
