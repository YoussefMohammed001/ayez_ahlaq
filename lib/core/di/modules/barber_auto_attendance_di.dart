import '../../../features/barber/auto_attendance/data/background/auto_attendance_background.dart';
import '../../../features/barber/auto_attendance/data/services/auto_attendance_prefs_store.dart';
import '../../../features/barber/auto_attendance/data/services/native_geofence_registrar.dart';
import '../../../features/barber/auto_attendance/data/services/permission_handler_background_location.dart';
import '../../../features/barber/auto_attendance/domain/repos/i_auto_attendance_store.dart';
import '../../../features/barber/auto_attendance/domain/repos/i_background_location_permission.dart';
import '../../../features/barber/auto_attendance/domain/repos/i_geofence_registrar.dart';
import '../../../features/barber/auto_attendance/domain/use_cases/disable_auto_attendance_use_case.dart';
import '../../../features/barber/auto_attendance/domain/use_cases/enable_auto_attendance_use_case.dart';
import '../../../features/barber/auto_attendance/domain/use_cases/sync_auto_attendance_zone_use_case.dart';
import '../../../features/barber/auto_attendance/presentation/manager/auto_attendance_cubit.dart';
import '../sl.dart';

void registerBarberAutoAttendance() {
  sl.registerLazySingleton<IAutoAttendanceStore>(
    () => AutoAttendancePrefsStore(sl()),
  );
  sl.registerLazySingleton<IGeofenceRegistrar>(
    () => NativeGeofenceRegistrar(autoAttendanceGeofenceCallback),
  );
  sl.registerLazySingleton<IBackgroundLocationPermission>(
    () => PermissionHandlerBackgroundLocation(),
  );
  sl.registerLazySingleton(() => DisableAutoAttendanceUseCase(sl(), sl()));
  sl.registerLazySingleton(
    () => EnableAutoAttendanceUseCase(sl(), sl(), sl(), sl()),
  );
  sl.registerLazySingleton(
    () => SyncAutoAttendanceZoneUseCase(sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(() => AutoAttendanceCubit(sl(), sl(), sl(), sl()));
}
