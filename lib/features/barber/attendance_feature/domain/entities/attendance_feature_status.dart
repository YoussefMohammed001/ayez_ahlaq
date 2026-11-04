import 'package:equatable/equatable.dart';
import 'attendance_feature_request.dart';
import 'attendance_feature_state.dart';

class AttendanceFeatureStatus extends Equatable {
  final bool enabled;
  final AttendanceFeatureState state;
  final bool owner;
  final String message;
  final num price;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? daysLeft;
  final bool autoRenew;
  final bool canRequest;
  final AttendanceFeatureRequest? pendingRequest;

  const AttendanceFeatureStatus({
    required this.enabled,
    required this.state,
    required this.owner,
    required this.message,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.daysLeft,
    required this.autoRenew,
    required this.canRequest,
    required this.pendingRequest,
  });

  const AttendanceFeatureStatus.ungated()
    : enabled = true,
      state = AttendanceFeatureState.active,
      owner = false,
      message = '',
      price = 0,
      startDate = null,
      endDate = null,
      daysLeft = null,
      autoRenew = false,
      canRequest = false,
      pendingRequest = null;

  static const endingSoonDays = 7;

  bool get isPending =>
      !enabled &&
      (pendingRequest != null || state == AttendanceFeatureState.pending);

  bool get isExpired => !enabled && state == AttendanceFeatureState.expired;

  bool get isSuspended => !enabled && state == AttendanceFeatureState.suspended;

  bool get isEndingSoon {
    final left = daysLeft;
    return enabled && left != null && left <= endingSoonDays;
  }

  @override
  List<Object?> get props => [
    enabled,
    state,
    owner,
    message,
    price,
    startDate,
    endDate,
    daysLeft,
    autoRenew,
    canRequest,
    pendingRequest,
  ];
}
