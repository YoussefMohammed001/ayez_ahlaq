import 'package:equatable/equatable.dart';

class AutoAttendanceZone extends Equatable {
  final double latitude;
  final double longitude;
  final double radiusMeters;
  final double? trackedRangeMeters;

  const AutoAttendanceZone({
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    this.trackedRangeMeters,
  });

  bool get needsTracking => trackedRangeMeters != null;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    radiusMeters,
    trackedRangeMeters,
  ];
}
