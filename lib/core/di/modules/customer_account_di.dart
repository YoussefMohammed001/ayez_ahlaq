import '../../../features/customer/profile/domain/use_cases/change_customer_password_use_case.dart';
import '../../../features/customer/profile/domain/use_cases/delete_customer_account_use_case.dart';
import '../../../features/customer/payment_methods/data/apis/customer_payment_methods_api.dart';
import '../../../features/customer/payment_methods/data/repos/customer_payment_methods_repo.dart';
import '../../../features/customer/payment_methods/domain/repos/i_customer_payment_methods_repo.dart';
import '../../../features/customer/payment_methods/domain/use_cases/get_enabled_payment_methods_use_case.dart';
import '../../../features/customer/payment_methods/presentation/manager/payment_methods_cubit.dart';
import '../../../features/customer/profile/data/apis/customer_profile_api.dart';
import '../../../features/customer/profile/data/repos/customer_profile_repo.dart';
import '../../../features/customer/profile/domain/repos/i_customer_profile_repo.dart';
import '../../../features/customer/profile/domain/use_cases/get_customer_profile_use_case.dart';
import '../../../features/customer/profile/presentation/manager/customer_profile_cubit.dart';
import '../sl.dart';

void registerCustomerProfile() {
  sl.registerLazySingleton(() => CustomerProfileApi(sl()));
  sl.registerLazySingleton<ICustomerProfileRepo>(
    () => CustomerProfileRepo(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetCustomerProfileUseCase(sl()));
  sl.registerLazySingleton(() => ChangeCustomerPasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCustomerAccountUseCase(sl()));
  sl.registerFactory(() => CustomerProfileCubit(sl(), sl(), sl()));
}

void registerCustomerPaymentMethods() {
  sl.registerLazySingleton(() => CustomerPaymentMethodsApi(sl()));
  sl.registerLazySingleton<ICustomerPaymentMethodsRepo>(
    () => CustomerPaymentMethodsRepo(sl()),
  );
  sl.registerLazySingleton(() => GetEnabledPaymentMethodsUseCase(sl()));
  sl.registerFactory(() => PaymentMethodsCubit(sl()));
}
