import 'package:equatable/equatable.dart';
import '../../domain/entities/attendance_feature_request.dart';

enum AttendanceFeatureRequestsStatus { initial, loading, success, failure }

class AttendanceFeatureRequestsState extends Equatable {
  final AttendanceFeatureRequestsStatus status;
  final List<AttendanceFeatureRequest> requests;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final String? errorMessage;

  const AttendanceFeatureRequestsState({
    this.status = AttendanceFeatureRequestsStatus.initial,
    this.requests = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  AttendanceFeatureRequestsState copyWith({
    AttendanceFeatureRequestsStatus? status,
    List<AttendanceFeatureRequest>? requests,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return AttendanceFeatureRequestsState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    requests,
    page,
    hasMore,
    isLoadingMore,
    errorMessage,
  ];
}
