import '../../../features/customer/auth/data/apis/customer_auth_api.dart';
import '../../../features/customer/auth/data/repos/customer_auth_repo.dart';
import '../../../features/customer/auth/domain/repos/i_customer_auth_repo.dart';
import '../../../features/customer/auth/domain/use_cases/customer_login_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/customer_logout_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/customer_register_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/resend_customer_register_otp_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/verify_customer_register_otp_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/forgot_customer_password_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/verify_customer_password_otp_use_case.dart';
import '../../../features/customer/auth/domain/use_cases/reset_customer_password_use_case.dart';
import '../../../features/customer/auth/presentation/manager/customer_auth_cubit.dart';
import '../../../shared/auth/data/local/auth_local_data_source.dart';
import '../sl.dart';

void registerCustomerAuth() {
  sl.registerLazySingleton(() => CustomerAuthApi(sl()));
  sl.registerLazySingleton(() => AuthLocalDataSource(sl(), sl()));
  sl.registerLazySingleton<ICustomerAuthRepo>(
    () => CustomerAuthRepo(sl(), sl()),
  );
  sl.registerLazySingleton(() => CustomerLoginUseCase(sl()));
  sl.registerLazySingleton(() => CustomerRegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyCustomerRegisterOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendCustomerRegisterOtpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotCustomerPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyCustomerPasswordOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetCustomerPasswordUseCase(sl()));
  sl.registerLazySingleton(() => CustomerLogoutUseCase(sl(), sl()));
  sl.registerFactory(
    () => CustomerAuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
}
