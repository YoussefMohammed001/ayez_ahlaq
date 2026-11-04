import '../../domain/entities/attendance_feature_requests_page.dart';
import 'attendance_feature_request_model.dart';

class AttendanceFeatureRequestsPageModel extends AttendanceFeatureRequestsPage {
  const AttendanceFeatureRequestsPageModel({
    required super.requests,
    required super.page,
    required super.totalPages,
  });

  factory AttendanceFeatureRequestsPageModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AttendanceFeatureRequestsPageModel(
      requests: (json['content'] as List<dynamic>? ?? [])
          .map(
            (e) => AttendanceFeatureRequestModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }
}
