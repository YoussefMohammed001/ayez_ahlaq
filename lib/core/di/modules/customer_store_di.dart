import '../../../features/customer/store/data/apis/customer_store_api.dart';
import '../../../features/customer/store/data/repos/customer_store_repo.dart';
import '../../../features/customer/store/domain/repos/i_customer_store_repo.dart';
import '../../../features/customer/store/domain/use_cases/cancel_store_order_use_case.dart'
    as customer_store;
import '../../../features/customer/store/domain/use_cases/get_storefront_use_case.dart';
import '../../../features/customer/store/domain/use_cases/get_store_feed_use_case.dart';
import '../../../features/customer/store/domain/use_cases/get_store_orders_use_case.dart'
    as customer_store;
import '../../../features/customer/store/domain/use_cases/get_cart_use_case.dart'
    as customer_store;
import '../../../features/customer/store/domain/use_cases/put_cart_use_case.dart'
    as customer_store;
import '../../../features/customer/store/domain/use_cases/checkout_cart_use_case.dart'
    as customer_store;
import '../../../features/customer/store/presentation/manager/customer_store_feed_cubit.dart';
import '../../../features/customer/store/presentation/manager/store_cart_cubit.dart';
import '../../../features/customer/store/presentation/manager/store_orders_cubit.dart';
import '../sl.dart';

void registerCustomerStore() {
  sl.registerLazySingleton(() => CustomerStoreApi(sl()));
  sl.registerLazySingleton<ICustomerStoreRepo>(() => CustomerStoreRepo(sl()));
  sl.registerLazySingleton(() => GetStorefrontUseCase(sl()));
  sl.registerLazySingleton(() => customer_store.GetCartUseCase(sl()));
  sl.registerLazySingleton(() => customer_store.PutCartUseCase(sl()));
  sl.registerLazySingleton(() => customer_store.CheckoutCartUseCase(sl()));
  sl.registerLazySingleton(() => customer_store.GetStoreOrdersUseCase(sl()));
  sl.registerLazySingleton(() => customer_store.CancelStoreOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreFeedUseCase(sl(), sl()));
  sl.registerFactory(() => StoreCartCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => StoreOrdersCubit(sl(), sl()));
  sl.registerFactory(() => CustomerStoreFeedCubit(sl()));
}
