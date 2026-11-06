import 'package:equatable/equatable.dart';

class AutoAttendanceZone extends Equatable {
  final double latitude;
  final double longitude;
  final double radiusMeters;

  const AutoAttendanceZone({
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
  });

  @override
  List<Object?> get props => [latitude, longitude, radiusMeters];
}
