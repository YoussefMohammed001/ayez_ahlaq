import '../../../features/barber/drinks/data/apis/barber_drinks_api.dart';
import '../../../features/barber/drinks/data/repos/barber_drinks_repo.dart';
import '../../../features/barber/drinks/domain/repos/i_barber_drinks_repo.dart';
import '../../../features/barber/drinks/domain/use_cases/create_drink_use_case.dart';
import '../../../features/barber/drinks/domain/use_cases/delete_drink_use_case.dart';
import '../../../features/barber/drinks/domain/use_cases/get_drinks_use_case.dart';
import '../../../features/barber/drinks/domain/use_cases/update_drink_use_case.dart';
import '../../../features/barber/drinks/presentation/manager/barber_drinks_cubit.dart';
import '../../../features/barber/hours/data/apis/barber_hours_api.dart';
import '../../../features/barber/hours/data/repos/barber_hours_repo.dart';
import '../../../features/barber/hours/domain/repos/i_barber_hours_repo.dart';
import '../../../features/barber/hours/domain/use_cases/get_barber_hours_use_case.dart';
import '../../../features/barber/hours/domain/use_cases/update_barber_hours_use_case.dart';
import '../../../features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import '../../../features/barber/services/data/apis/barber_services_api.dart';
import '../../../features/barber/services/data/repos/barber_services_repo.dart';
import '../../../features/barber/services/domain/repos/i_barber_services_repo.dart';
import '../../../features/barber/services/domain/use_cases/create_barber_service_use_case.dart';
import '../../../features/barber/services/domain/use_cases/create_own_service_use_case.dart';
import '../../../features/barber/services/domain/use_cases/delete_barber_service_use_case.dart';
import '../../../features/barber/services/domain/use_cases/delete_own_service_use_case.dart';
import '../../../features/barber/services/domain/use_cases/get_barber_services_use_case.dart';
import '../../../features/barber/services/domain/use_cases/get_own_services_use_case.dart';
import '../../../features/barber/services/domain/use_cases/get_service_catalog_use_case.dart';
import '../../../features/barber/services/domain/use_cases/get_shop_haircut_styles_use_case.dart';
import '../../../features/barber/services/domain/use_cases/update_barber_service_use_case.dart';
import '../../../features/barber/services/domain/use_cases/update_shop_haircut_style_use_case.dart';
import '../../../features/barber/services/presentation/manager/barber_services_cubit.dart';
import '../../../features/barber/services/presentation/manager/own_services_cubit.dart';
import '../../../features/barber/services/presentation/manager/shop_haircut_styles_cubit.dart';
import '../sl.dart';

void registerBarberDrinks() {
  sl.registerLazySingleton(() => BarberDrinksApi(sl()));
  sl.registerLazySingleton<IBarberDrinksRepo>(() => BarberDrinksRepo(sl()));
  sl.registerLazySingleton(() => GetDrinksUseCase(sl()));
  sl.registerLazySingleton(() => CreateDrinkUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDrinkUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDrinkUseCase(sl()));
  sl.registerFactory(() => BarberDrinksCubit(sl(), sl(), sl(), sl()));
}

void registerBarberHours() {
  sl.registerLazySingleton(() => BarberHoursApi(sl()));
  sl.registerLazySingleton<IBarberHoursRepo>(() => BarberHoursRepo(sl()));
  sl.registerLazySingleton(() => GetBarberHoursUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBarberHoursUseCase(sl()));
  sl.registerFactory(() => BarberHoursCubit(sl(), sl()));
}

void registerBarberServices() {
  sl.registerLazySingleton(() => BarberServicesApi(sl()));
  sl.registerLazySingleton<IBarberServicesRepo>(() => BarberServicesRepo(sl()));
  sl.registerLazySingleton(() => GetServiceCatalogUseCase(sl()));
  sl.registerLazySingleton(() => GetBarberServicesUseCase(sl()));
  sl.registerLazySingleton(() => CreateBarberServiceUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBarberServiceUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBarberServiceUseCase(sl()));
  sl.registerLazySingleton(() => GetOwnServicesUseCase(sl()));
  sl.registerLazySingleton(() => CreateOwnServiceUseCase(sl()));
  sl.registerLazySingleton(() => DeleteOwnServiceUseCase(sl()));
  sl.registerLazySingleton(() => GetShopHaircutStylesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateShopHaircutStyleUseCase(sl()));
  sl.registerFactory(() => BarberServicesCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => OwnServicesCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ShopHaircutStylesCubit(sl(), sl()));
}
