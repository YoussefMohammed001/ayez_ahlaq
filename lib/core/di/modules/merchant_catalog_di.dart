import '../../../features/merchant/categories/data/apis/merchant_categories_api.dart';
import '../../../features/merchant/categories/data/repos/merchant_categories_repo.dart';
import '../../../features/merchant/categories/domain/repos/i_merchant_categories_repo.dart';
import '../../../features/merchant/categories/domain/use_cases/create_category_use_case.dart';
import '../../../features/merchant/categories/domain/use_cases/delete_category_use_case.dart';
import '../../../features/merchant/categories/domain/use_cases/get_assignable_categories_use_case.dart';
import '../../../features/merchant/categories/domain/use_cases/update_category_use_case.dart';
import '../../../features/merchant/categories/presentation/manager/merchant_categories_cubit.dart';
import '../../../features/merchant/dashboard/data/apis/merchant_dashboard_api.dart';
import '../../../features/merchant/dashboard/data/repos/merchant_dashboard_repo.dart';
import '../../../features/merchant/dashboard/domain/repos/i_merchant_dashboard_repo.dart';
import '../../../features/merchant/dashboard/domain/use_cases/get_dashboard_use_case.dart';
import '../../../features/merchant/dashboard/presentation/manager/merchant_dashboard_cubit.dart';
import '../../../features/merchant/delivery/data/apis/merchant_delivery_api.dart';
import '../../../features/merchant/delivery/data/repos/merchant_delivery_repo.dart';
import '../../../features/merchant/delivery/domain/repos/i_merchant_delivery_repo.dart';
import '../../../features/merchant/delivery/domain/use_cases/get_delivery_use_case.dart';
import '../../../features/merchant/delivery/domain/use_cases/update_delivery_use_case.dart';
import '../../../features/merchant/delivery/presentation/manager/merchant_delivery_cubit.dart';
import '../../../features/merchant/customers/data/apis/merchant_customers_api.dart';
import '../../../features/merchant/customers/data/repos/merchant_customers_repo.dart';
import '../../../features/merchant/customers/domain/repos/i_merchant_customers_repo.dart';
import '../../../features/merchant/customers/domain/use_cases/get_merchant_customers_use_case.dart';
import '../../../features/merchant/customers/presentation/manager/merchant_customers_cubit.dart';
import '../../../features/merchant/discounts/data/apis/merchant_discounts_api.dart';
import '../../../features/merchant/discounts/data/repos/merchant_discounts_repo.dart';
import '../../../features/merchant/discounts/domain/repos/i_merchant_discounts_repo.dart';
import '../../../features/merchant/discounts/domain/use_cases/close_discount_use_case.dart';
import '../../../features/merchant/discounts/domain/use_cases/quote_discount_use_case.dart';
import '../../../features/merchant/discounts/presentation/manager/discount_quote_cubit.dart';
import '../../../features/merchant/discounts/domain/use_cases/create_discount_use_case.dart';
import '../../../features/merchant/discounts/domain/use_cases/get_discount_by_id_use_case.dart';
import '../../../features/merchant/discounts/domain/use_cases/get_discount_shops_use_case.dart';
import '../../../features/merchant/discounts/domain/use_cases/get_discounts_use_case.dart';
import '../../../features/merchant/discounts/domain/use_cases/update_discount_use_case.dart';
import '../../../features/merchant/discounts/presentation/manager/merchant_discounts_cubit.dart';
import '../../../features/merchant/orders/data/apis/merchant_orders_api.dart';
import '../../../features/merchant/orders/data/repos/merchant_orders_repo.dart';
import '../../../features/merchant/orders/domain/repos/i_merchant_orders_repo.dart';
import '../../../features/merchant/orders/domain/use_cases/accept_order_use_case.dart';
import '../../../features/merchant/orders/domain/use_cases/advance_order_status_use_case.dart';
import '../../../features/merchant/orders/domain/use_cases/get_order_use_case.dart';
import '../../../features/merchant/orders/domain/use_cases/get_orders_use_case.dart';
import '../../../features/merchant/orders/domain/use_cases/reject_order_use_case.dart';
import '../../../features/merchant/orders/presentation/manager/merchant_orders_cubit.dart';
import '../../../features/merchant/products/data/apis/merchant_products_api.dart';
import '../../../features/merchant/products/data/repos/merchant_products_repo.dart';
import '../../../features/merchant/products/domain/repos/i_merchant_products_repo.dart';
import '../../../features/merchant/products/domain/use_cases/create_product_use_case.dart';
import '../../../features/merchant/products/domain/use_cases/delete_product_use_case.dart';
import '../../../features/merchant/products/domain/use_cases/delete_product_image_use_case.dart';
import '../../../features/merchant/products/domain/use_cases/get_products_use_case.dart';
import '../../../features/merchant/products/domain/use_cases/set_product_stock_use_case.dart';
import '../../../features/merchant/products/domain/use_cases/update_product_use_case.dart';
import '../../../features/merchant/products/presentation/manager/merchant_products_cubit.dart';
import '../sl.dart';

void registerMerchantDashboard() {
  sl.registerLazySingleton(() => MerchantDashboardApi(sl()));
  sl.registerLazySingleton<IMerchantDashboardRepo>(
    () => MerchantDashboardRepo(sl()),
  );
  sl.registerLazySingleton(() => GetDashboardUseCase(sl()));
  sl.registerFactory(() => MerchantDashboardCubit(sl()));
}

void registerMerchantCategories() {
  sl.registerLazySingleton(() => MerchantCategoriesApi(sl()));
  sl.registerLazySingleton<IMerchantCategoriesRepo>(
    () => MerchantCategoriesRepo(sl()),
  );
  sl.registerLazySingleton(() => GetAssignableCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => CreateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));
  sl.registerFactory(() => MerchantCategoriesCubit(sl(), sl(), sl(), sl()));
}

void registerMerchantProducts() {
  sl.registerLazySingleton(() => MerchantProductsApi(sl()));
  sl.registerLazySingleton<IMerchantProductsRepo>(
    () => MerchantProductsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => CreateProductUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));
  sl.registerLazySingleton(() => SetProductStockUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductImageUseCase(sl()));
  sl.registerFactory(
    () => MerchantProductsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
  );
}

void registerMerchantDiscounts() {
  sl.registerLazySingleton(() => MerchantDiscountsApi(sl()));
  sl.registerLazySingleton<IMerchantDiscountsRepo>(
    () => MerchantDiscountsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetDiscountsUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscountByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscountShopsUseCase(sl()));
  sl.registerLazySingleton(() => CreateDiscountUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDiscountUseCase(sl()));
  sl.registerLazySingleton(() => CloseDiscountUseCase(sl()));
  sl.registerLazySingleton(() => QuoteDiscountUseCase(sl()));
  sl.registerFactory(() => DiscountQuoteCubit(sl()));
  sl.registerFactory(
    () => MerchantDiscountsCubit(sl(), sl(), sl(), sl(), sl(), sl()),
  );
}

void registerMerchantCustomers() {
  sl.registerLazySingleton(() => MerchantCustomersApi(sl()));
  sl.registerLazySingleton<IMerchantCustomersRepo>(
    () => MerchantCustomersRepo(sl()),
  );
  sl.registerLazySingleton(() => GetMerchantCustomersUseCase(sl()));
  sl.registerFactory(() => MerchantCustomersCubit(sl()));
}

void registerMerchantOrders() {
  sl.registerLazySingleton(() => MerchantOrdersApi(sl()));
  sl.registerLazySingleton<IMerchantOrdersRepo>(() => MerchantOrdersRepo(sl()));
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderUseCase(sl()));
  sl.registerLazySingleton(() => AcceptOrderUseCase(sl()));
  sl.registerLazySingleton(() => RejectOrderUseCase(sl()));
  sl.registerLazySingleton(() => AdvanceOrderStatusUseCase(sl()));
  sl.registerFactory(() => MerchantOrdersCubit(sl(), sl(), sl(), sl(), sl()));
}

void registerMerchantDelivery() {
  sl.registerLazySingleton(() => MerchantDeliveryApi(sl()));
  sl.registerLazySingleton<IMerchantDeliveryRepo>(
    () => MerchantDeliveryRepo(sl()),
  );
  sl.registerLazySingleton(() => GetDeliveryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDeliveryUseCase(sl()));
  sl.registerFactory(() => MerchantDeliveryCubit(sl(), sl()));
}
