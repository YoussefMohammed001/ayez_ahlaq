import '../../../features/barber/auth/data/apis/barber_auth_api.dart';
import '../../../features/barber/auth/data/repos/barber_auth_repo.dart';
import '../../../features/barber/auth/domain/repos/i_barber_auth_repo.dart';
import '../../../features/barber/auth/domain/use_cases/barber_login_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/barber_register_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/resend_barber_register_otp_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/verify_barber_register_otp_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/forgot_barber_password_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/verify_barber_password_otp_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/reset_barber_password_use_case.dart';
import '../../../features/barber/auth/domain/use_cases/barber_logout_use_case.dart';
import '../../../features/barber/auth/presentation/manager/barber_auth_cubit.dart';
import '../sl.dart';

void registerBarberAuth() {
  sl.registerLazySingleton(() => BarberAuthApi(sl()));
  sl.registerLazySingleton<IBarberAuthRepo>(() => BarberAuthRepo(sl(), sl()));
  sl.registerLazySingleton(() => BarberLoginUseCase(sl()));
  sl.registerLazySingleton(() => BarberRegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyBarberRegisterOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResendBarberRegisterOtpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotBarberPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyBarberPasswordOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetBarberPasswordUseCase(sl()));
  sl.registerLazySingleton(() => BarberLogoutUseCase(sl(), sl()));
  sl.registerFactory(
    () => BarberAuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
}
