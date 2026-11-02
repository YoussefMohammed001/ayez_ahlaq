import '../../../../../generated/l10n.dart';
import '../../../../../shared/location/domain/entities/location_availability.dart';

class AttendanceLocationMessage {
  const AttendanceLocationMessage._();

  static String of(LocationAvailability availability) => switch (availability) {
    LocationAvailability.serviceDisabled => S().attendanceLocationServiceOff,
    LocationAvailability.permissionDenied => S().attendanceLocationDenied,
    LocationAvailability.permissionDeniedForever =>
      S().attendanceLocationDeniedForever,
    _ => S().attendanceLocationUnavailable,
  };
}
