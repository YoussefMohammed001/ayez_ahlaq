import '../../../features/barber/home_service/data/apis/barber_home_service_api.dart';
import '../../../features/barber/home_service/data/apis/barber_home_service_hours_api.dart';
import '../../../features/barber/home_service/data/repos/barber_home_service_repo.dart';
import '../../../features/barber/home_service/data/repos/barber_home_service_hours_repo.dart';
import '../../../features/barber/home_service/domain/repos/i_barber_home_service_repo.dart';
import '../../../features/barber/home_service/domain/repos/i_barber_home_service_hours_repo.dart';
import '../../../features/barber/home_service/domain/use_cases/get_home_service_settings_use_case.dart';
import '../../../features/barber/home_service/domain/use_cases/update_home_service_settings_use_case.dart';
import '../../../features/barber/home_service/domain/use_cases/get_home_service_hours_use_case.dart';
import '../../../features/barber/home_service/domain/use_cases/update_home_service_hours_use_case.dart';
import '../../../features/barber/home_service/presentation/manager/home_service_settings_cubit.dart';
import '../../../features/barber/home_service/presentation/manager/home_service_hours_cubit.dart';
import '../../../features/barber/home_service_requests/data/apis/barber_home_service_request_api.dart';
import '../../../features/barber/home_service_requests/data/repos/barber_home_service_request_repo.dart';
import '../../../features/barber/home_service_requests/domain/repos/i_barber_home_service_request_repo.dart';
import '../../../features/barber/home_service_requests/domain/use_cases/accept_home_service_request_use_case.dart';
import '../../../features/barber/home_service_requests/domain/use_cases/get_home_service_request_use_case.dart'
    as barber_hsr;
import '../../../features/barber/home_service_requests/domain/use_cases/get_home_service_requests_use_case.dart'
    as barber_hsr;
import '../../../features/barber/home_service_requests/domain/use_cases/reject_home_service_request_use_case.dart';
import '../../../features/barber/home_service_requests/domain/use_cases/update_home_service_request_price_use_case.dart';
import '../../../features/barber/home_service_requests/domain/use_cases/update_home_service_request_status_use_case.dart';
import '../../../features/barber/home_service_requests/presentation/manager/home_service_requests_cubit.dart'
    as barber_hsr;
import '../../../features/barber/home_service_broadcast/data/apis/barber_home_service_broadcast_api.dart';
import '../../../features/barber/home_service_broadcast/data/repos/barber_home_service_broadcast_repo.dart';
import '../../../features/barber/home_service_broadcast/domain/repos/i_barber_home_service_broadcast_repo.dart';
import '../../../features/barber/home_service_broadcast/domain/use_cases/accept_home_service_broadcast_use_case.dart';
import '../../../features/barber/home_service_broadcast/domain/use_cases/get_home_service_broadcast_for_request_use_case.dart';
import '../../../features/barber/home_service_broadcast/domain/use_cases/get_home_service_broadcasts_use_case.dart';
import '../../../features/barber/home_service_broadcast/domain/use_cases/reject_home_service_broadcast_use_case.dart';
import '../../../features/barber/home_service_broadcast/presentation/manager/home_service_broadcast_cubit.dart';
import '../sl.dart';

void registerBarberHomeService() {
  sl.registerLazySingleton(() => BarberHomeServiceApi(sl()));
  sl.registerLazySingleton<IBarberHomeServiceRepo>(
    () => BarberHomeServiceRepo(sl()),
  );
  sl.registerLazySingleton(() => GetHomeServiceSettingsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHomeServiceSettingsUseCase(sl()));
  sl.registerFactory(() => HomeServiceSettingsCubit(sl(), sl()));
}

void registerBarberHomeServiceRequests() {
  sl.registerLazySingleton(() => BarberHomeServiceRequestApi(sl()));
  sl.registerLazySingleton<IBarberHomeServiceRequestRepo>(
    () => BarberHomeServiceRequestRepo(sl()),
  );
  sl.registerLazySingleton(
    () => barber_hsr.GetHomeServiceRequestsUseCase(sl()),
  );
  sl.registerLazySingleton(() => barber_hsr.GetHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHomeServiceRequestPriceUseCase(sl()));
  sl.registerLazySingleton(() => AcceptHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => RejectHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHomeServiceRequestStatusUseCase(sl()));
  sl.registerFactory(
    () =>
        barber_hsr.HomeServiceRequestsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
  );
}

void registerBarberHomeServiceBroadcast() {
  sl.registerLazySingleton(() => BarberHomeServiceBroadcastApi(sl()));
  sl.registerLazySingleton<IBarberHomeServiceBroadcastRepo>(
    () => BarberHomeServiceBroadcastRepo(sl()),
  );
  sl.registerLazySingleton(() => GetHomeServiceBroadcastsUseCase(sl()));
  sl.registerLazySingleton(
    () => GetHomeServiceBroadcastForRequestUseCase(sl()),
  );
  sl.registerLazySingleton(() => AcceptHomeServiceBroadcastUseCase(sl()));
  sl.registerLazySingleton(() => RejectHomeServiceBroadcastUseCase(sl()));
  sl.registerFactory(() => HomeServiceBroadcastCubit(sl(), sl(), sl(), sl()));
}

void registerBarberHomeServiceHours() {
  sl.registerLazySingleton(() => BarberHomeServiceHoursApi(sl()));
  sl.registerLazySingleton<IBarberHomeServiceHoursRepo>(
    () => BarberHomeServiceHoursRepo(sl()),
  );
  sl.registerLazySingleton(() => GetHomeServiceHoursUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHomeServiceHoursUseCase(sl()));
  sl.registerFactory(() => HomeServiceHoursCubit(sl(), sl()));
}
