import '../../../features/barber/attendance/domain/use_cases/check_in_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/check_out_attendance_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_attendance_history_use_case.dart';
import '../../../features/barber/attendance/domain/use_cases/get_current_attendance_use_case.dart';
import '../../../features/barber/attendance/presentation/manager/attendance_history_cubit.dart';
import '../../../features/merchant/attendance/data/apis/merchant_attendance_api.dart';
import '../../../features/merchant/attendance/data/repos/merchant_attendance_repo.dart';
import '../../../features/merchant/attendance/presentation/manager/member_attendance_cubit.dart';
import '../../../shared/location/domain/use_cases/get_current_location_use_case.dart';
import '../sl.dart';

const memberAttendanceHistoryCubitName = 'memberAttendanceHistory';

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
      GetAttendanceHistoryUseCase(sl<MerchantAttendanceRepo>()),
      null,
    ),
    instanceName: memberAttendanceHistoryCubitName,
  );
}
