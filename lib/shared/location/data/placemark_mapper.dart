import 'package:geocoding/geocoding.dart';
import '../domain/entities/place_info.dart';

class PlacemarkMapper {
  static PlaceInfo toPlaceInfo(Placemark place) {
    final name = _firstFilled([place.name, place.street, place.subLocality]);
    final city = _firstFilled([
      place.locality,
      place.subAdministrativeArea,
      place.administrativeArea,
    ]);

    return PlaceInfo(
      name: name,
      city: city == name ? '' : city,
      fullAddress: _joinDistinct([
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
      ]),
    );
  }

  static String _firstFilled(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) return value.trim();
    }
    return '';
  }

  static String _joinDistinct(List<String?> values) {
    final seen = <String>{};
    return values
        .whereType<String>()
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty && seen.add(value))
        .join('، ');
  }
}
