import '../../../features/merchant/team/data/apis/merchant_member_self_api.dart';
import '../../../features/merchant/team/data/apis/merchant_team_api.dart';
import '../../../features/merchant/team/data/apis/merchant_team_hours_api.dart';
import '../../../features/merchant/team/data/repos/merchant_member_self_repo.dart';
import '../../../features/merchant/team/data/repos/merchant_team_hours_repo.dart';
import '../../../features/merchant/team/data/repos/merchant_team_repo.dart';
import '../../../features/merchant/team/domain/repos/i_merchant_member_self_repo.dart';
import '../../../features/merchant/team/domain/repos/i_merchant_team_hours_repo.dart';
import '../../../features/merchant/team/domain/repos/i_merchant_team_repo.dart';
import '../../../features/merchant/team/domain/use_cases/activate_merchant_member_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/add_merchant_member_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/block_merchant_member_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/change_my_merchant_password_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/delete_merchant_member_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/get_merchant_member_hours_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/get_merchant_member_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/get_merchant_members_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/get_my_merchant_hours_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/get_my_merchant_member_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/reset_merchant_member_password_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/set_merchant_member_salary_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/update_merchant_member_hours_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/update_merchant_member_permissions_use_case.dart';
import '../../../features/merchant/team/domain/use_cases/update_merchant_member_use_case.dart';
import '../../../features/barber/team/presentation/manager/member_hours_cubit.dart';
import '../../../features/merchant/team/presentation/manager/merchant_member_detail_cubit.dart';
import '../../../features/merchant/team/presentation/manager/merchant_team_cubit.dart';
import '../../../features/merchant/team/presentation/manager/my_merchant_member_cubit.dart';
import '../../../features/merchant/team/presentation/manager/my_schedule_cubit.dart';
import '../sl.dart';

const merchantMemberHoursCubitName = 'merchantMemberHours';

void registerMerchantTeam() {
  sl.registerLazySingleton(() => MerchantTeamApi(sl()));
  sl.registerLazySingleton<IMerchantTeamRepo>(() => MerchantTeamRepo(sl()));
  sl.registerLazySingleton(() => GetMerchantMembersUseCase(sl()));
  sl.registerLazySingleton(() => GetMerchantMemberUseCase(sl()));
  sl.registerLazySingleton(() => AddMerchantMemberUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMerchantMemberUseCase(sl()));
  sl.registerLazySingleton(() => SetMerchantMemberSalaryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMerchantMemberPermissionsUseCase(sl()));
  sl.registerLazySingleton(() => BlockMerchantMemberUseCase(sl()));
  sl.registerLazySingleton(() => ActivateMerchantMemberUseCase(sl()));
  sl.registerLazySingleton(() => ResetMerchantMemberPasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMerchantMemberUseCase(sl()));

  sl.registerLazySingleton(() => MerchantTeamHoursApi(sl()));
  sl.registerLazySingleton<IMerchantTeamHoursRepo>(
    () => MerchantTeamHoursRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMerchantMemberHoursUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMerchantMemberHoursUseCase(sl()));

  sl.registerLazySingleton(() => MerchantMemberSelfApi(sl()));
  sl.registerLazySingleton<IMerchantMemberSelfRepo>(
    () => MerchantMemberSelfRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMyMerchantMemberUseCase(sl()));
  sl.registerLazySingleton(() => GetMyMerchantHoursUseCase(sl()));
  sl.registerLazySingleton(() => ChangeMyMerchantPasswordUseCase(sl()));
  sl.registerFactory(() => MyMerchantMemberCubit(sl(), sl()));
  sl.registerFactory(() => MyScheduleCubit(sl()));
  sl.registerFactory(() => MerchantTeamCubit(sl(), sl()));
  sl.registerFactory(
    () => MerchantMemberDetailCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  sl.registerFactory<MemberHoursCubit>(
    () => MemberHoursCubit(
      sl<GetMerchantMemberHoursUseCase>().call,
      sl<UpdateMerchantMemberHoursUseCase>().call,
    ),
    instanceName: merchantMemberHoursCubitName,
  );
}
