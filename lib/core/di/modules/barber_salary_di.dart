import '../../../features/barber/salary/data/apis/member_salary_api.dart';
import '../../../features/barber/salary/data/apis/member_commission_api.dart';
import '../../../features/barber/salary/data/apis/salary_deductions_api.dart';
import '../../../features/barber/salary/data/repos/member_commission_repo.dart';
import '../../../features/barber/salary/domain/repos/i_member_commission_repo.dart';
import '../../../features/barber/salary/domain/use_cases/get_member_commission_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/set_member_commission_use_case.dart';
import '../../../features/barber/salary/data/repos/member_salary_repo.dart';
import '../../../features/barber/salary/data/repos/salary_deductions_repo.dart';
import '../../../features/barber/salary/domain/repos/i_member_salary_repo.dart';
import '../../../features/barber/salary/domain/repos/i_salary_deductions_repo.dart';
import '../../../features/barber/salary/domain/use_cases/clear_member_salary_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/decide_deduction_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/get_deduction_grace_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/get_salary_deductions_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/get_member_salary_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/get_my_salary_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/get_pending_deductions_count_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/set_deduction_grace_use_case.dart';
import '../../../features/barber/salary/domain/use_cases/set_member_salary_use_case.dart';
import '../../../features/barber/salary/presentation/manager/deduction_grace_cubit.dart';
import '../../../features/barber/salary/presentation/manager/member_commission_cubit.dart';
import '../../../features/barber/salary/presentation/manager/member_salary_cubit.dart';
import '../../../features/barber/salary/presentation/manager/pending_deductions_count_cubit.dart';
import '../../../features/barber/salary/presentation/manager/salary_deductions_cubit.dart';
import '../../../features/barber/salary/presentation/manager/my_salary_cubit.dart';
import '../sl.dart';

void registerBarberSalary() {
  sl.registerLazySingleton(() => MemberSalaryApi(sl()));
  sl.registerLazySingleton(() => SalaryDeductionsApi(sl()));
  sl.registerLazySingleton<IMemberSalaryRepo>(() => MemberSalaryRepo(sl()));
  sl.registerLazySingleton<ISalaryDeductionsRepo>(
    () => SalaryDeductionsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMySalaryUseCase(sl()));
  sl.registerLazySingleton(() => GetMemberSalaryUseCase(sl()));
  sl.registerLazySingleton(() => SetMemberSalaryUseCase(sl()));
  sl.registerLazySingleton(() => ClearMemberSalaryUseCase(sl()));
  sl.registerLazySingleton(() => GetPendingDeductionsCountUseCase(sl()));
  sl.registerLazySingleton(() => GetDeductionGraceUseCase(sl()));
  sl.registerLazySingleton(() => SetDeductionGraceUseCase(sl()));
  sl.registerLazySingleton(() => MemberCommissionApi(sl()));
  sl.registerLazySingleton<IMemberCommissionRepo>(
    () => MemberCommissionRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMemberCommissionUseCase(sl()));
  sl.registerLazySingleton(() => SetMemberCommissionUseCase(sl()));
  sl.registerLazySingleton(() => GetSalaryDeductionsUseCase(sl()));
  sl.registerLazySingleton(() => DecideDeductionUseCase(sl()));
  sl.registerFactory(() => MemberSalaryCubit(sl(), sl(), sl()));
  sl.registerFactory(() => MySalaryCubit(sl()));
  sl.registerFactory(() => MemberCommissionCubit(sl(), sl()));
  sl.registerFactory(() => SalaryDeductionsCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PendingDeductionsCountCubit(sl()));
  sl.registerFactory(() => DeductionGraceCubit(sl(), sl()));
}
