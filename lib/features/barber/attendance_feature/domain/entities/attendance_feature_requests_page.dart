import 'package:equatable/equatable.dart';
import 'attendance_feature_request.dart';

class AttendanceFeatureRequestsPage extends Equatable {
  final List<AttendanceFeatureRequest> requests;
  final int page;
  final int totalPages;

  const AttendanceFeatureRequestsPage({
    required this.requests,
    required this.page,
    required this.totalPages,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [requests, page, totalPages];
}
