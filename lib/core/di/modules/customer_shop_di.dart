import '../../../features/customer/shops/data/apis/customer_shops_api.dart';
import '../../../features/customer/shops/data/repos/customer_shops_repo.dart';
import '../../../features/customer/shops/domain/repos/i_customer_shops_repo.dart';
import '../../../features/customer/shops/domain/use_cases/get_shop_detail_use_case.dart';
import '../../../features/customer/shops/domain/use_cases/get_shops_use_case.dart';
import '../../../features/customer/shops/presentation/manager/customer_shop_detail_cubit.dart';
import '../../../features/customer/shops/presentation/manager/customer_shops_cubit.dart';
import '../sl.dart';

void registerCustomerShops() {
  sl.registerLazySingleton(() => CustomerShopsApi(sl()));
  sl.registerLazySingleton<ICustomerShopsRepo>(() => CustomerShopsRepo(sl()));
  sl.registerLazySingleton(() => GetShopsUseCase(sl()));
  sl.registerLazySingleton(() => GetShopDetailUseCase(sl()));
  sl.registerFactory(() => CustomerShopsCubit(sl(), sl(), sl()));
  sl.registerFactory(
    () => CustomerShopDetailCubit(sl(), sl(), sl(), sl(), sl()),
  );
}
