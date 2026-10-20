import '../../../features/barber/store/data/apis/barber_store_api.dart';
import '../../../features/barber/store/data/apis/barber_store_feed_api.dart';
import '../../../features/barber/store/data/repos/barber_store_repo.dart';
import '../../../features/barber/store/data/repos/barber_store_feed_repo.dart';
import '../../../features/barber/store/domain/repos/i_barber_store_repo.dart';
import '../../../features/barber/store/domain/repos/i_barber_store_feed_repo.dart';
import '../../../features/barber/store/domain/use_cases/cancel_store_order_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_merchant_products_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_store_categories_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_store_feed_products_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_store_merchants_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_store_order_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_store_orders_use_case.dart';
import '../../../features/barber/store/domain/use_cases/checkout_cart_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_cart_use_case.dart';
import '../../../features/barber/store/domain/use_cases/get_quote_use_case.dart';
import '../../../features/barber/store/domain/use_cases/put_cart_use_case.dart';
import '../../../features/barber/store/presentation/manager/barber_store_cart_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_feed_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_merchants_cubit.dart';
import '../../../features/barber/store/presentation/manager/barber_store_orders_cubit.dart';
import '../sl.dart';

void registerBarberStore() {
  sl.registerLazySingleton(() => BarberStoreApi(sl()));
  sl.registerLazySingleton<IBarberStoreRepo>(() => BarberStoreRepo(sl()));
  sl.registerLazySingleton(() => BarberStoreFeedApi(sl()));
  sl.registerLazySingleton<IBarberStoreFeedRepo>(
    () => BarberStoreFeedRepo(sl()),
  );
  sl.registerLazySingleton(() => GetStoreMerchantsUseCase(sl()));
  sl.registerLazySingleton(() => GetMerchantProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreFeedProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => PutCartUseCase(sl()));
  sl.registerLazySingleton(() => GetQuoteUseCase(sl()));
  sl.registerLazySingleton(() => CheckoutCartUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreOrderUseCase(sl()));
  sl.registerLazySingleton(() => CancelStoreOrderUseCase(sl()));
  sl.registerFactory(() => BarberStoreMerchantsCubit(sl()));
  sl.registerFactory(() => BarberStoreFeedCubit(sl(), sl()));
  sl.registerFactory(() => BarberStoreCartCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => BarberStoreOrdersCubit(sl(), sl(), sl()));
}
