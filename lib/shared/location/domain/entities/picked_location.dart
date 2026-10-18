import 'package:equatable/equatable.dart';

class PickedLocation extends Equatable {
  final double latitude;
  final double longitude;
  final String address;
  final String name;
  final String city;

  const PickedLocation({
    required this.latitude,
    required this.longitude,
    this.address = '',
    this.name = '',
    this.city = '',
  });

  @override
  List<Object?> get props => [latitude, longitude, address, name, city];
}
