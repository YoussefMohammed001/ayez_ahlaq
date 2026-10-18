import 'package:equatable/equatable.dart';
import '../../domain/entities/location_availability.dart';

class LocationStatusState extends Equatable {
  final LocationAvailability availability;
  final bool isLoaded;

  const LocationStatusState({
    this.availability = LocationAvailability.unavailable,
    this.isLoaded = false,
  });

  @override
  List<Object?> get props => [availability, isLoaded];
}
