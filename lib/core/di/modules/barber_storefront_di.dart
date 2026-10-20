import '../../../features/barber/storefront/products/data/apis/barber_storefront_products_api.dart';
import '../../../features/barber/storefront/products/data/repos/barber_storefront_products_repo.dart';
import '../../../features/barber/storefront/products/domain/repos/i_barber_storefront_products_repo.dart';
import '../../../features/barber/storefront/products/domain/use_cases/create_storefront_product_use_case.dart';
import '../../../features/barber/storefront/products/domain/use_cases/delete_storefront_product_use_case.dart';
import '../../../features/barber/storefront/products/domain/use_cases/get_storefront_products_use_case.dart';
import '../../../features/barber/storefront/products/domain/use_cases/set_storefront_product_stock_use_case.dart';
import '../../../features/barber/storefront/products/domain/use_cases/update_storefront_product_use_case.dart';
import '../../../features/barber/storefront/products/presentation/manager/barber_storefront_products_cubit.dart';
import '../../../features/barber/storefront/categories/data/apis/barber_storefront_categories_api.dart';
import '../../../features/barber/storefront/categories/data/repos/barber_storefront_categories_repo.dart';
import '../../../features/barber/storefront/categories/domain/repos/i_barber_storefront_categories_repo.dart';
import '../../../features/barber/storefront/categories/domain/use_cases/create_storefront_category_use_case.dart';
import '../../../features/barber/storefront/categories/domain/use_cases/delete_storefront_category_use_case.dart';
import '../../../features/barber/storefront/categories/domain/use_cases/get_assignable_storefront_categories_use_case.dart';
import '../../../features/barber/storefront/categories/domain/use_cases/update_storefront_category_use_case.dart';
import '../../../features/barber/storefront/categories/presentation/manager/barber_storefront_categories_cubit.dart';
import '../../../features/barber/storefront/delivery/data/apis/barber_storefront_delivery_api.dart';
import '../../../features/barber/storefront/delivery/data/repos/barber_storefront_delivery_repo.dart';
import '../../../features/barber/storefront/delivery/domain/repos/i_barber_storefront_delivery_repo.dart';
import '../../../features/barber/storefront/delivery/domain/use_cases/get_storefront_delivery_use_case.dart';
import '../../../features/barber/storefront/delivery/domain/use_cases/update_storefront_delivery_use_case.dart';
import '../../../features/barber/storefront/delivery/presentation/manager/barber_storefront_delivery_cubit.dart';
import '../../../features/barber/storefront/orders/data/apis/barber_storefront_orders_api.dart';
import '../../../features/barber/storefront/orders/data/repos/barber_storefront_orders_repo.dart';
import '../../../features/barber/storefront/orders/domain/repos/i_barber_storefront_orders_repo.dart';
import '../../../features/barber/storefront/orders/domain/use_cases/accept_storefront_order_use_case.dart';
import '../../../features/barber/storefront/orders/domain/use_cases/advance_storefront_order_status_use_case.dart';
import '../../../features/barber/storefront/orders/domain/use_cases/get_storefront_order_use_case.dart';
import '../../../features/barber/storefront/orders/domain/use_cases/get_storefront_orders_use_case.dart';
import '../../../features/barber/storefront/orders/domain/use_cases/reject_storefront_order_use_case.dart';
import '../../../features/barber/storefront/orders/presentation/manager/barber_storefront_orders_cubit.dart';
import '../sl.dart';

void registerBarberStorefrontProducts() {
  sl.registerLazySingleton(() => BarberStorefrontProductsApi(sl()));
  sl.registerLazySingleton<IBarberStorefrontProductsRepo>(
    () => BarberStorefrontProductsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetStorefrontProductsUseCase(sl()));
  sl.registerLazySingleton(() => CreateStorefrontProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStorefrontProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteStorefrontProductUseCase(sl()));
  sl.registerLazySingleton(() => SetStorefrontProductStockUseCase(sl()));
  sl.registerFactory(
    () => BarberStorefrontProductsCubit(sl(), sl(), sl(), sl(), sl()),
  );
}

void registerBarberStorefrontCategories() {
  sl.registerLazySingleton(() => BarberStorefrontCategoriesApi(sl()));
  sl.registerLazySingleton<IBarberStorefrontCategoriesRepo>(
    () => BarberStorefrontCategoriesRepo(sl()),
  );
  sl.registerLazySingleton(
    () => GetAssignableStorefrontCategoriesUseCase(sl()),
  );
  sl.registerLazySingleton(() => CreateStorefrontCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStorefrontCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteStorefrontCategoryUseCase(sl()));
  sl.registerFactory(
    () => BarberStorefrontCategoriesCubit(sl(), sl(), sl(), sl()),
  );
}

void registerBarberStorefrontDelivery() {
  sl.registerLazySingleton(() => BarberStorefrontDeliveryApi(sl()));
  sl.registerLazySingleton<IBarberStorefrontDeliveryRepo>(
    () => BarberStorefrontDeliveryRepo(sl()),
  );
  sl.registerLazySingleton(() => GetStorefrontDeliveryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStorefrontDeliveryUseCase(sl()));
  sl.registerFactory(() => BarberStorefrontDeliveryCubit(sl(), sl()));
}

void registerBarberStorefrontOrders() {
  sl.registerLazySingleton(() => BarberStorefrontOrdersApi(sl()));
  sl.registerLazySingleton<IBarberStorefrontOrdersRepo>(
    () => BarberStorefrontOrdersRepo(sl()),
  );
  sl.registerLazySingleton(() => GetStorefrontOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetStorefrontOrderUseCase(sl()));
  sl.registerLazySingleton(() => AcceptStorefrontOrderUseCase(sl()));
  sl.registerLazySingleton(() => RejectStorefrontOrderUseCase(sl()));
  sl.registerLazySingleton(() => AdvanceStorefrontOrderStatusUseCase(sl()));
  sl.registerFactory(
    () => BarberStorefrontOrdersCubit(sl(), sl(), sl(), sl(), sl()),
  );
}
