import '../../../features/merchant/sales/data/apis/merchant_sales_api.dart';
import '../../../features/merchant/sales/data/repos/merchant_sales_repo.dart';
import '../../../features/merchant/sales/domain/repos/i_merchant_sales_repo.dart';
import '../../../features/merchant/sales/domain/use_cases/cancel_sale_use_case.dart';
import '../../../features/merchant/sales/domain/use_cases/create_sale_use_case.dart';
import '../../../features/merchant/sales/domain/use_cases/get_sale_payment_methods_use_case.dart';
import '../../../features/merchant/sales/domain/use_cases/get_sales_use_case.dart';
import '../../../features/merchant/sales/presentation/manager/new_sale_cubit.dart';
import '../../../features/merchant/sales/presentation/manager/sales_cubit.dart';
import '../sl.dart';

void registerMerchantSales() {
  sl.registerLazySingleton(() => MerchantSalesApi(sl()));
  sl.registerLazySingleton<IMerchantSalesRepo>(() => MerchantSalesRepo(sl()));
  sl.registerLazySingleton(() => CreateSaleUseCase(sl()));
  sl.registerLazySingleton(() => GetSalesUseCase(sl()));
  sl.registerLazySingleton(() => CancelSaleUseCase(sl()));
  sl.registerLazySingleton(() => GetSalePaymentMethodsUseCase(sl()));
  sl.registerFactory(() => SalesCubit(sl(), sl()));
  sl.registerFactory(() => NewSaleCubit(sl(), sl()));
}
