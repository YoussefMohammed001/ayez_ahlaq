import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../../../core/helpers/safe_print.dart';
import '../domain/entities/geo_point.dart';

class PlaceGeocoder {
  Future<List<Placemark>> placemarksOf(GeoPoint point) async {
    await _setLocale(Intl.getCurrentLocale());
    try {
      final places = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      if (places.isNotEmpty) return places;
    } catch (error) {
      safePrint('placemark with locale failed: $error');
    }
    await _setLocale('');
    return placemarkFromCoordinates(point.latitude, point.longitude);
  }

  Future<String?> governorateOf(GeoPoint point) async {
    await _setLocale('en');
    try {
      final places = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      final area = places.isEmpty ? null : places.first.administrativeArea;
      return area
          ?.replaceAll(RegExp(r'\s*Governorate$', caseSensitive: false), '')
          .trim();
    } catch (error) {
      safePrint('governorate failed: $error');
      return null;
    }
  }

  Future<List<GeoPoint>> pointsOf(String query, {required int limit}) async {
    await _setLocale(Intl.getCurrentLocale());
    final locations = await locationFromAddress(query);
    return locations
        .take(limit)
        .map((location) => GeoPoint(location.latitude, location.longitude))
        .toList();
  }

  Future<void> _setLocale(String identifier) async {
    try {
      await setLocaleIdentifier(identifier);
    } catch (_) {}
  }
}
