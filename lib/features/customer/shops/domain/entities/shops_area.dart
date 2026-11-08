import 'package:equatable/equatable.dart';
import '../../../../../shared/location/domain/entities/geo_point.dart';
import '../../../../../shared/location/domain/entities/picked_location.dart';

class ShopsArea extends Equatable {
  final GeoPoint point;
  final String label;

  const ShopsArea({required this.point, required this.label});

  factory ShopsArea.fromPicked(PickedLocation picked) => ShopsArea(
    point: GeoPoint(picked.latitude, picked.longitude),
    label: _labelOf(picked),
  );

  PickedLocation toPicked() => PickedLocation(
    latitude: point.latitude,
    longitude: point.longitude,
    name: label,
  );

  static String _labelOf(PickedLocation picked) {
    for (final text in [picked.name, picked.address, picked.city]) {
      if (text.trim().isNotEmpty) return text.trim();
    }
    return '';
  }

  @override
  List<Object?> get props => [point, label];
}
