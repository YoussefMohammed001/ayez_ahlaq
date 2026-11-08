import 'auto_attendance_zone.dart';
import 'presence_action.dart';
import 'presence_fix.dart';

class ShopPresenceMonitor {
  static const double maxUsableAccuracyMeters = 30;
  static const int confirmationsNeeded = 2;

  final AutoAttendanceZone zone;
  bool onShift;
  int _insideCount = 0;
  int _outsideCount = 0;

  ShopPresenceMonitor({required this.zone, required this.onShift});

  double get _range => zone.trackedRangeMeters!;

  PresenceAction onFix(PresenceFix fix) {
    if (fix.accuracyMeters > maxUsableAccuracyMeters)
      return PresenceAction.none;

    final distance = fix.metersTo(zone.latitude, zone.longitude);

    if (distance - fix.accuracyMeters > zone.radiusMeters) {
      return PresenceAction.leftZone;
    }

    return onShift ? _whileOnShift(distance, fix) : _whileOffShift(distance);
  }

  void undo(PresenceAction action) {
    if (action == PresenceAction.checkIn) onShift = false;
    if (action == PresenceAction.checkOut) onShift = true;
    _insideCount = 0;
    _outsideCount = 0;
  }

  PresenceAction _whileOffShift(double distance) {
    _outsideCount = 0;
    _insideCount = distance <= _range ? _insideCount + 1 : 0;
    if (_insideCount < confirmationsNeeded) return PresenceAction.none;

    _insideCount = 0;
    onShift = true;
    return PresenceAction.checkIn;
  }

  PresenceAction _whileOnShift(double distance, PresenceFix fix) {
    _insideCount = 0;
    final clearlyOutside = distance - fix.accuracyMeters > _range;
    _outsideCount = clearlyOutside ? _outsideCount + 1 : 0;
    if (_outsideCount < confirmationsNeeded) return PresenceAction.none;

    _outsideCount = 0;
    onShift = false;
    return PresenceAction.checkOut;
  }
}
