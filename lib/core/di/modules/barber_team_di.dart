import '../../../features/barber/team/data/apis/barber_team_api.dart';
import '../../../features/barber/team/data/apis/barber_team_hours_api.dart';
import '../../../features/barber/team/data/apis/barber_team_services_api.dart';
import '../../../features/barber/team/data/repos/barber_team_repo.dart';
import '../../../features/barber/team/data/repos/barber_team_hours_repo.dart';
import '../../../features/barber/team/data/repos/barber_team_services_repo.dart';
import '../../../features/barber/team/domain/repos/i_barber_team_repo.dart';
import '../../../features/barber/team/domain/repos/i_barber_team_hours_repo.dart';
import '../../../features/barber/team/domain/repos/i_barber_team_services_repo.dart';
import '../../../features/barber/team/domain/use_cases/activate_team_member_use_case.dart';
import '../../../features/barber/team/domain/use_cases/update_member_permissions_use_case.dart';
import '../../../features/barber/team/domain/use_cases/add_team_member_use_case.dart';
import '../../../features/barber/team/domain/use_cases/block_team_member_use_case.dart';
import '../../../features/barber/team/domain/use_cases/delete_team_member_permanently_use_case.dart';
import '../../../features/barber/team/domain/use_cases/create_member_service_use_case.dart';
import '../../../features/barber/team/domain/use_cases/delete_member_service_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_member_hours_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_member_service_catalog_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_member_services_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_team_member_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_team_use_case.dart';
import '../../../features/barber/team/domain/use_cases/reset_member_password_use_case.dart';
import '../../../features/barber/team/domain/use_cases/set_member_availability_use_case.dart';
import '../../../features/barber/team/domain/use_cases/update_member_hours_use_case.dart';
import '../../../features/barber/team/domain/use_cases/update_member_service_use_case.dart';
import '../../../features/barber/team/domain/use_cases/update_team_member_use_case.dart';
import '../../../features/barber/team/presentation/manager/barber_team_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_hours_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_services_cubit.dart';
import '../../../features/barber/team/presentation/manager/team_member_detail_cubit.dart';
import '../sl.dart';

void registerBarberTeam() {
  sl.registerLazySingleton(() => BarberTeamApi(sl()));
  sl.registerLazySingleton<IBarberTeamRepo>(() => BarberTeamRepo(sl()));
  sl.registerLazySingleton(() => GetTeamUseCase(sl()));
  sl.registerLazySingleton(() => AddTeamMemberUseCase(sl()));
  sl.registerLazySingleton(() => GetTeamMemberUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTeamMemberUseCase(sl()));
  sl.registerLazySingleton(() => SetMemberAvailabilityUseCase(sl()));
  sl.registerLazySingleton(() => BlockTeamMemberUseCase(sl()));
  sl.registerLazySingleton(() => ActivateTeamMemberUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMemberPermissionsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTeamMemberPermanentlyUseCase(sl()));
  sl.registerLazySingleton(() => ResetMemberPasswordUseCase(sl()));
  sl.registerFactory(() => BarberTeamCubit(sl(), sl(), sl()));
  sl.registerFactory(
    () => TeamMemberDetailCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );

  sl.registerLazySingleton(() => BarberTeamHoursApi(sl()));
  sl.registerLazySingleton<IBarberTeamHoursRepo>(
    () => BarberTeamHoursRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMemberHoursUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMemberHoursUseCase(sl()));
  sl.registerFactory(() => MemberHoursCubit(sl(), sl()));

  sl.registerLazySingleton(() => BarberTeamServicesApi(sl()));
  sl.registerLazySingleton<IBarberTeamServicesRepo>(
    () => BarberTeamServicesRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMemberServiceCatalogUseCase(sl()));
  sl.registerLazySingleton(() => GetMemberServicesUseCase(sl()));
  sl.registerLazySingleton(() => CreateMemberServiceUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMemberServiceUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMemberServiceUseCase(sl()));
  sl.registerFactory(() => MemberServicesCubit(sl(), sl(), sl(), sl(), sl()));
}
