import '../../../features/barber/attendance/data/apis/barber_attendance_api.dart';
import '../../../features/barber/attendance/data/repos/barber_attendance_repo.dart';
import '../../../features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import '../../../features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_history_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import '../sl.dart';

void registerBarberAttendance() {
  sl.registerLazySingleton(() => BarberAttendanceApi(sl()));
  sl.registerLazySingleton<IBarberAttendanceRepo>(
    () => BarberAttendanceRepo(sl()),
  );
  sl.registerLazySingleton(() => GetCurrentAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => CheckInAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => CheckOutAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => GetAttendanceHistoryUseCase(sl()));
  sl.registerFactory(() => BarberAttendanceCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => AttendanceHistoryCubit(sl()));
}
