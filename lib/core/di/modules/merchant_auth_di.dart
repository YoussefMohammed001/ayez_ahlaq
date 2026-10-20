import '../../../features/merchant/auth/data/apis/merchant_auth_api.dart';
import '../../../features/merchant/auth/data/repos/merchant_auth_repo.dart';
import '../../../features/merchant/auth/domain/repos/i_merchant_auth_repo.dart';
import '../../../features/merchant/auth/domain/use_cases/merchant_login_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/merchant_logout_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/merchant_register_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/resend_merchant_register_otp_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/verify_merchant_register_otp_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/forgot_merchant_password_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/verify_merchant_password_otp_use_case.dart';
import '../../../features/merchant/auth/domain/use_cases/reset_merchant_password_use_case.dart';
import '../../../features/merchant/auth/presentation/manager/merchant_auth_cubit.dart';
import '../sl.dart';

void registerMerchantAuth() {
  sl.registerLazySingleton(() => MerchantAuthApi(sl()));
  sl.registerLazySingleton<IMerchantAuthRepo>(
    () => MerchantAuthRepo(sl(), sl()),
  );
  sl.registerLazySingleton(() => MerchantLoginUseCase(sl()));
  sl.registerLazySingleton(() => MerchantRegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyMerchantRegisterOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendMerchantRegisterOtpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotMerchantPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyMerchantPasswordOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetMerchantPasswordUseCase(sl()));
  sl.registerLazySingleton(() => MerchantLogoutUseCase(sl(), sl()));
  sl.registerFactory(
    () => MerchantAuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
}
