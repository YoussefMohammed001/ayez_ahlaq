import '../../../attendance/domain/entities/attendance_method.dart';
import '../../../attendance/domain/entities/current_attendance.dart';
import '../../../attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../entities/auto_attendance_outcome.dart';
import '../entities/auto_attendance_policy.dart';
import '../entities/presence_action.dart';
import '../entities/presence_fix.dart';
import '../entities/shop_presence_monitor.dart';
import '../repos/i_auto_attendance_store.dart';
import '../repos/i_presence_tracker.dart';

class TrackShopPresenceUseCase {
  static const Duration staleHeartbeat = Duration(seconds: 90);
  static const Duration maxSession = Duration(hours: 12);

  final GetCurrentAttendanceUseCase _getCurrent;
  final CheckInAttendanceUseCase _checkIn;
  final CheckOutAttendanceUseCase _checkOut;
  final IAutoAttendanceStore _store;
  final IPresenceTracker _tracker;
  final DateTime Function() _now;

  TrackShopPresenceUseCase(
    this._getCurrent,
    this._checkIn,
    this._checkOut,
    this._store,
    this._tracker, [
    DateTime Function()? now,
  ]) : _now = now ?? DateTime.now;

  Future<void> call(void Function(AutoAttendanceOutcome) onOutcome) async {
    if (_isAlreadyTracking()) return;

    final current = (await _getCurrent()).getOrElse(
      () => const CurrentAttendance.none(),
    );
    final zone = AutoAttendancePolicy.zoneOf(current.config);
    if (zone == null || !zone.needsTracking) return;

    final monitor = ShopPresenceMonitor(zone: zone, onShift: current.onShift);
    final startedAt = _now();

    try {
      await for (final fix in _tracker.fixes()) {
        if (!_store.isEnabled || _now().difference(startedAt) > maxSession) {
          break;
        }
        await _store.setTrackingHeartbeat(_now());

        final action = monitor.onFix(fix);
        if (action == PresenceAction.leftZone) {
          if (monitor.onShift) {
            onOutcome(await _perform(PresenceAction.checkOut, fix));
          }
          break;
        }

        if (action == PresenceAction.none) continue;

        final outcome = await _perform(action, fix);
        if (!outcome.tookEffect) monitor.undo(action);
        onOutcome(outcome);
      }
    } finally {
      await _store.setTrackingHeartbeat(null);
    }
  }

  bool _isAlreadyTracking() {
    final beat = _store.trackingHeartbeat;
    return beat != null && _now().difference(beat) < staleHeartbeat;
  }

  Future<AutoAttendanceOutcome> _perform(
    PresenceAction action,
    PresenceFix fix,
  ) async {
    if (action == PresenceAction.checkIn) {
      final result = await _checkIn(
        lat: fix.latitude,
        lng: fix.longitude,
        method: AttendanceMethod.auto,
      );
      return result.fold(
        (_) => AutoAttendanceOutcome.failed,
        (_) => AutoAttendanceOutcome.checkedIn,
      );
    }

    final result = await _checkOut(
      lat: fix.latitude,
      lng: fix.longitude,
      method: AttendanceMethod.auto,
    );
    return result.fold(
      (_) => AutoAttendanceOutcome.failed,
      (_) => AutoAttendanceOutcome.checkedOut,
    );
  }
}
