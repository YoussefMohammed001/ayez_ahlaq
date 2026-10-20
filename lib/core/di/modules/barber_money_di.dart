import '../../../features/barber/money/data/apis/barber_money_api.dart';
import '../../../features/barber/money/data/apis/barber_money_pin_api.dart';
import '../../../features/barber/money/data/repos/barber_money_repo.dart';
import '../../../features/barber/money/data/repos/barber_money_pin_repo.dart';
import '../../../features/barber/money/domain/repos/i_barber_money_repo.dart';
import '../../../features/barber/money/domain/repos/i_barber_money_pin_repo.dart';
import '../../../features/barber/money/domain/use_cases/get_money_items_use_case.dart';
import '../../../features/barber/money/domain/use_cases/create_money_item_use_case.dart';
import '../../../features/barber/money/domain/use_cases/update_money_item_use_case.dart';
import '../../../features/barber/money/domain/use_cases/delete_money_item_use_case.dart';
import '../../../features/barber/money/domain/use_cases/get_money_entries_use_case.dart';
import '../../../features/barber/money/domain/use_cases/create_money_entry_use_case.dart';
import '../../../features/barber/money/domain/use_cases/get_money_summary_use_case.dart';
import '../../../features/barber/money/domain/use_cases/get_pending_occurrences_use_case.dart';
import '../../../features/barber/money/domain/use_cases/confirm_occurrence_use_case.dart';
import '../../../features/barber/money/domain/use_cases/dismiss_occurrence_use_case.dart';
import '../../../features/barber/money/domain/use_cases/check_money_pin_use_case.dart';
import '../../../features/barber/money/domain/use_cases/setup_money_pin_use_case.dart';
import '../../../features/barber/money/domain/use_cases/verify_money_pin_use_case.dart';
import '../../../features/barber/money/domain/use_cases/change_money_pin_use_case.dart';
import '../../../features/barber/money/domain/use_cases/get_money_pin_reset_status_use_case.dart';
import '../../../features/barber/money/domain/use_cases/request_money_pin_reset_use_case.dart';
import '../../../features/barber/money/presentation/manager/money_pin_cubit.dart';
import '../../../features/barber/money/presentation/manager/money_home_cubit.dart';
import '../../../features/barber/money/presentation/manager/money_items_cubit.dart';
import '../../../features/barber/money/presentation/manager/money_entries_cubit.dart';
import '../../../features/barber/team/data/apis/barber_earnings_api.dart';
import '../../../features/barber/team/data/repos/barber_earnings_repo.dart';
import '../../../features/barber/team/domain/repos/i_barber_earnings_repo.dart';
import '../../../features/barber/team/domain/use_cases/get_earnings_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_member_clients_use_case.dart';
import '../../../features/barber/team/domain/use_cases/get_member_earnings_use_case.dart';
import '../../../features/barber/team/presentation/manager/earnings_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_clients_cubit.dart';
import '../../../features/barber/team/presentation/manager/member_earnings_cubit.dart';
import '../sl.dart';

void registerBarberMoney() {
  sl.registerLazySingleton(() => BarberMoneyApi(sl()));
  sl.registerLazySingleton(() => BarberMoneyPinApi(sl()));
  sl.registerLazySingleton<IBarberMoneyRepo>(() => BarberMoneyRepo(sl()));
  sl.registerLazySingleton<IBarberMoneyPinRepo>(() => BarberMoneyPinRepo(sl()));

  sl.registerLazySingleton(() => GetMoneyItemsUseCase(sl()));
  sl.registerLazySingleton(() => CreateMoneyItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMoneyItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMoneyItemUseCase(sl()));
  sl.registerLazySingleton(() => GetMoneyEntriesUseCase(sl()));
  sl.registerLazySingleton(() => CreateMoneyEntryUseCase(sl()));
  sl.registerLazySingleton(() => GetMoneySummaryUseCase(sl()));
  sl.registerLazySingleton(() => GetPendingOccurrencesUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmOccurrenceUseCase(sl()));
  sl.registerLazySingleton(() => DismissOccurrenceUseCase(sl()));
  sl.registerLazySingleton(() => CheckMoneyPinUseCase(sl()));
  sl.registerLazySingleton(() => SetupMoneyPinUseCase(sl()));
  sl.registerLazySingleton(() => VerifyMoneyPinUseCase(sl()));
  sl.registerLazySingleton(() => ChangeMoneyPinUseCase(sl()));
  sl.registerLazySingleton(() => GetMoneyPinResetStatusUseCase(sl()));
  sl.registerLazySingleton(() => RequestMoneyPinResetUseCase(sl()));

  sl.registerFactory(() => MoneyPinCubit(sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MoneyHomeCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MoneyItemsCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => MoneyEntriesCubit(sl(), sl()));
}

void registerBarberEarnings() {
  sl.registerLazySingleton(() => BarberEarningsApi(sl()));
  sl.registerLazySingleton<IBarberEarningsRepo>(() => BarberEarningsRepo(sl()));
  sl.registerLazySingleton(() => GetEarningsUseCase(sl()));
  sl.registerLazySingleton(() => GetMemberEarningsUseCase(sl()));
  sl.registerLazySingleton(() => GetMemberClientsUseCase(sl()));
  sl.registerFactory(() => EarningsCubit(sl()));
  sl.registerFactory(() => MemberEarningsCubit(sl()));
  sl.registerFactory(() => MemberClientsCubit(sl()));
}
