import '../../../features/barber/discounts/data/apis/barber_discounts_api.dart';
import '../../../features/barber/discounts/data/repos/barber_discounts_repo.dart';
import '../../../features/barber/discounts/domain/repos/i_barber_discounts_repo.dart';
import '../../../features/barber/discounts/domain/use_cases/close_barber_discount_use_case.dart';
import '../../../features/barber/discounts/domain/use_cases/create_barber_discount_use_case.dart';
import '../../../features/barber/discounts/domain/use_cases/get_barber_discount_by_id_use_case.dart';
import '../../../features/barber/discounts/domain/use_cases/get_barber_discounts_use_case.dart';
import '../../../features/barber/discounts/domain/use_cases/update_barber_discount_use_case.dart';
import '../../../features/barber/discounts/presentation/manager/barber_discounts_cubit.dart';
import '../sl.dart';

void registerBarberDiscounts() {
  sl.registerLazySingleton(() => BarberDiscountsApi(sl()));
  sl.registerLazySingleton<IBarberDiscountsRepo>(
    () => BarberDiscountsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetBarberDiscountsUseCase(sl()));
  sl.registerLazySingleton(() => GetBarberDiscountByIdUseCase(sl()));
  sl.registerLazySingleton(() => CreateBarberDiscountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBarberDiscountUseCase(sl()));
  sl.registerLazySingleton(() => CloseBarberDiscountUseCase(sl()));
  sl.registerFactory(() => BarberDiscountsCubit(sl(), sl(), sl(), sl(), sl()));
}
