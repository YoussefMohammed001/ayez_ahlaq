import '../../../../../core/helpers/safe_print.dart';
import '../../../attendance/data/repos/barber_attendance_repo.dart';
import '../../../attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../../domain/entities/auto_attendance_outcome.dart';
import '../../domain/use_cases/track_shop_presence_use_case.dart';
import '../services/auto_attendance_prefs_store.dart';
import '../services/geolocator_presence_tracker.dart';

class ShopPresenceBackground {
  const ShopPresenceBackground._();

  static Future<void> run({
    required BarberAttendanceRepo repo,
    required AutoAttendancePrefsStore store,
    required Future<void> Function(AutoAttendanceOutcome) onOutcome,
  }) async {
    final tracker = TrackShopPresenceUseCase(
      GetCurrentAttendanceUseCase(repo),
      CheckInAttendanceUseCase(repo),
      CheckOutAttendanceUseCase(repo),
      store,
      GeolocatorPresenceTracker(),
    );

    try {
      await tracker((outcome) => onOutcome(outcome));
    } catch (error) {
      safePrint('Shop presence tracking stopped: $error');
    }
  }
}
