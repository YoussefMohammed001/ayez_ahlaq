import 'package:equatable/equatable.dart';
import 'geo_point.dart';
import 'location_availability.dart';

class DeviceLocationResult extends Equatable {
  final LocationAvailability availability;
  final GeoPoint? point;

  const DeviceLocationResult(this.availability, [this.point]);

  bool get hasPoint => point != null;

  @override
  List<Object?> get props => [availability, point];
}
