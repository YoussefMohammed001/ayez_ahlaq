import '../../../../../core/error/failure.dart';

extension AttendanceFailureX on Failure {
  static const _featureCodePrefix = 'ATTENDANCE_FEATURE';

  bool get isAttendanceFeatureRequired {
    final code = data['code'];
    return code is String && code.startsWith(_featureCodePrefix);
  }
}
