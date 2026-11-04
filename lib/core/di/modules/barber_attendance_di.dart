import '../../../features/barber/attendance/data/apis/barber_attendance_api.dart';
import '../../../features/barber/attendance/data/apis/barber_attendance_admin_api.dart';
import '../../../features/barber/attendance/data/repos/barber_attendance_admin_repo.dart';
import '../../../features/barber/attendance/data/repos/barber_attendance_repo.dart';
import '../../../features/barber/attendance/domain/repos/i_barber_attendance_admin_repo.dart';
import '../../../features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import '../../../features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/correct_attendance_record_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_history_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_setting_log_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_settings_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_team_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/update_attendance_settings_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_setting_log_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_settings_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_team_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/barber_attendance_cubit.dart';
import '../../../features/barber/attendance_feature/data/apis/attendance_feature_api.dart';
import '../../../features/barber/attendance_feature/data/repos/attendance_feature_repo.dart';
import '../../../features/barber/attendance_feature/domain/repos/i_attendance_feature_repo.dart';
import '../../../features/barber/attendance_feature/domain/use_cases/cancel_attendance_feature_request_use_case.dart';
import '../../../features/barber/attendance_feature/domain/use_cases/get_attendance_feature_requests_use_case.dart';
import '../../../features/barber/attendance_feature/domain/use_cases/get_attendance_feature_status_use_case.dart';
import '../../../features/barber/attendance_feature/domain/use_cases/request_attendance_feature_use_case.dart';
import '../../../features/barber/attendance_feature/presentation/manager/attendance_feature_request_cubit.dart';
import '../../../features/barber/attendance_feature/presentation/manager/attendance_feature_requests_cubit.dart';
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
  sl.registerLazySingleton(() => AttendanceFeatureApi(sl()));
  sl.registerLazySingleton<IAttendanceFeatureRepo>(
    () => AttendanceFeatureRepo(sl()),
  );
  sl.registerLazySingleton(() => GetAttendanceFeatureStatusUseCase(sl()));
  sl.registerLazySingleton(() => RequestAttendanceFeatureUseCase(sl()));
  sl.registerLazySingleton(() => CancelAttendanceFeatureRequestUseCase(sl()));
  sl.registerLazySingleton(() => GetAttendanceFeatureRequestsUseCase(sl()));
  sl.registerFactory(() => AttendanceFeatureRequestCubit(sl(), sl()));
  sl.registerFactory(() => AttendanceFeatureRequestsCubit(sl()));
  sl.registerFactory(() => BarberAttendanceCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => BarberAttendanceAdminApi(sl()));
  sl.registerLazySingleton<IBarberAttendanceAdminRepo>(
    () => BarberAttendanceAdminRepo(sl()),
  );
  sl.registerLazySingleton(() => GetAttendanceSettingsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateAttendanceSettingsUseCase(sl()));
  sl.registerLazySingleton(() => GetTeamAttendanceUseCase(sl()));
  sl.registerLazySingleton(() => GetAttendanceSettingLogUseCase(sl()));
  sl.registerLazySingleton(() => CorrectAttendanceRecordUseCase(sl()));
  sl.registerFactory(() => AttendanceHistoryCubit(sl(), sl()));
  sl.registerFactory(() => AttendanceSettingsCubit(sl(), sl()));
  sl.registerFactory(() => AttendanceTeamCubit(sl()));
  sl.registerFactory(() => AttendanceSettingLogCubit(sl()));
}
