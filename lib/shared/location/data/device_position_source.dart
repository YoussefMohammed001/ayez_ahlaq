import '../../../core/helpers/safe_print.dart';
import '../domain/entities/geo_point.dart';
import 'position_gateway.dart';

class DevicePositionSource {
  static const _timeout = Duration(seconds: 10);
  static const _maxLastKnownAge = Duration(minutes: 2);

  final PositionGateway _gateway;
  final DateTime Function() _now;

  DevicePositionSource({PositionGateway? gateway, DateTime Function()? now})
    : _gateway = gateway ?? GeolocatorPositionGateway(),
      _now = now ?? DateTime.now;

  Future<GeoPoint?> resolve() async {
    try {
      final position = await _gateway
          .current(timeLimit: _timeout)
          .timeout(_timeout);
      if (position != null) {
        return GeoPoint(position.latitude, position.longitude);
      }
    } catch (error) {
      safePrint('current position failed: $error');
    }

    return _recentLastKnown();
  }

  Future<GeoPoint?> _recentLastKnown() async {
    try {
      final position = await _gateway.lastKnown();
      if (position == null) return null;
      if (_now().difference(position.timestamp) > _maxLastKnownAge) return null;
      return GeoPoint(position.latitude, position.longitude);
    } catch (_) {
      return null;
    }
  }
}
