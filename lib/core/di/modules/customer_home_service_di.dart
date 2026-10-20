import '../../../features/customer/home_service/data/apis/customer_home_service_api.dart';
import '../../../features/customer/home_service/data/repos/customer_home_service_repo.dart';
import '../../../features/customer/home_service/domain/repos/i_customer_home_service_repo.dart';
import '../../../features/customer/home_service/domain/use_cases/get_home_service_shops_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/create_home_service_request_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/rate_home_service_request_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/retry_home_service_request_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/get_my_home_service_requests_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/get_home_service_request_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/confirm_home_service_price_use_case.dart';
import '../../../features/customer/home_service/domain/use_cases/cancel_home_service_request_use_case.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_shops_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_request_form_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_requests_cubit.dart';
import '../../../features/customer/home_service/presentation/manager/home_service_request_detail_cubit.dart';
import '../sl.dart';

void registerCustomerHomeService() {
  sl.registerLazySingleton(() => CustomerHomeServiceApi(sl()));
  sl.registerLazySingleton<ICustomerHomeServiceRepo>(
    () => CustomerHomeServiceRepo(sl()),
  );
  sl.registerLazySingleton(() => GetHomeServiceShopsUseCase(sl()));
  sl.registerLazySingleton(() => CreateHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => RetryHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => GetMyHomeServiceRequestsUseCase(sl()));
  sl.registerLazySingleton(() => GetHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmHomeServicePriceUseCase(sl()));
  sl.registerLazySingleton(() => CancelHomeServiceRequestUseCase(sl()));
  sl.registerLazySingleton(() => RateHomeServiceRequestUseCase(sl()));
  sl.registerFactory(() => HomeServiceShopsCubit(sl(), sl()));
  sl.registerFactory(() => HomeServiceRequestFormCubit(sl(), sl()));
  sl.registerFactory(() => HomeServiceRequestsCubit(sl()));
  sl.registerFactory(
    () => HomeServiceRequestDetailCubit(sl(), sl(), sl(), sl()),
  );
}
