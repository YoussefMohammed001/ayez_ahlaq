import '../../../features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_history_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/correct_attendance_record_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_setting_log_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_settings_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_team_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/update_attendance_settings_use_case.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_setting_log_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_settings_cubit.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_team_cubit.dart';
import '../../../features/merchant/attendance/data/apis/merchant_attendance_api.dart';
import '../../../features/merchant/attendance/data/apis/merchant_attendance_admin_api.dart';
import '../../../features/merchant/attendance/data/repos/merchant_attendance_admin_repo.dart';
import '../../../features/merchant/attendance/data/repos/merchant_attendance_repo.dart';
import '../../../features/merchant/attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../sl.dart';

const memberAttendanceHistoryCubitName = 'memberAttendanceHistory';
const merchantAttendanceSettingsCubitName = 'merchantAttendanceSettings';
const merchantAttendanceTeamCubitName = 'merchantAttendanceTeam';
const merchantAttendanceLogCubitName = 'merchantAttendanceLog';
const merchantMemberHistoryCubitName = 'merchantMemberHistory';

void registerMerchantAttendance() {
  sl.registerLazySingleton(() => MerchantAttendanceApi(sl()));
  sl.registerLazySingleton(() => MerchantAttendanceRepo(sl()));
  sl.registerFactory(
    () => MemberAttendanceCubit(
      GetCurrentAttendanceUseCase(sl<MerchantAttendanceRepo>()),
      CheckInAttendanceUseCase(sl<MerchantAttendanceRepo>()),
      CheckOutAttendanceUseCase(sl<MerchantAttendanceRepo>()),
      sl<GetCurrentLocationUseCase>(),
    ),
  );
  sl.registerFactory<AttendanceHistoryCubit>(
    () => AttendanceHistoryCubit(
      GetAttendanceHistoryUseCase(sl<MerchantAttendanceRepo>()).call,
      null,
    ),
    instanceName: memberAttendanceHistoryCubitName,
  );
  _registerAdmin();
}

void _registerAdmin() {
  sl.registerLazySingleton(() => MerchantAttendanceAdminApi(sl()));
  sl.registerLazySingleton(() => MerchantAttendanceAdminRepo(sl()));
  sl.registerFactory<AttendanceSettingsCubit>(
    () => AttendanceSettingsCubit(
      GetAttendanceSettingsUseCase(sl<MerchantAttendanceAdminRepo>()),
      UpdateAttendanceSettingsUseCase(sl<MerchantAttendanceAdminRepo>()),
    ),
    instanceName: merchantAttendanceSettingsCubitName,
  );
  sl.registerFactory<AttendanceTeamCubit>(
    () => AttendanceTeamCubit(
      GetTeamAttendanceUseCase(sl<MerchantAttendanceAdminRepo>()),
    ),
    instanceName: merchantAttendanceTeamCubitName,
  );
  sl.registerFactory<AttendanceSettingLogCubit>(
    () => AttendanceSettingLogCubit(
      GetAttendanceSettingLogUseCase(sl<MerchantAttendanceAdminRepo>()),
    ),
    instanceName: merchantAttendanceLogCubitName,
  );
  sl.registerFactoryParam<AttendanceHistoryCubit, int, void>(
    (memberId, _) => AttendanceHistoryCubit(
      ({required page}) => sl<MerchantAttendanceAdminRepo>().getMemberHistory(
        memberId: memberId,
        page: page,
      ),
      CorrectAttendanceRecordUseCase(sl<MerchantAttendanceAdminRepo>()).call,
    ),
    instanceName: merchantMemberHistoryCubitName,
  );
}
