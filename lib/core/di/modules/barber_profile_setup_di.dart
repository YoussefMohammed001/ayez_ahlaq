import '../../../features/barber/profile_setup/domain/use_cases/get_profile_setup_remote_steps_use_case.dart';
import '../../../features/barber/profile_setup/presentation/manager/profile_setup_cubit.dart';
import '../../../features/barber/tour/presentation/manager/barber_tour_cubit.dart';
import '../sl.dart';

void registerBarberProfileSetup() {
  sl.registerLazySingleton(() => GetProfileSetupRemoteStepsUseCase(sl(), sl()));
  sl.registerFactory(() => ProfileSetupCubit(sl(), sl()));
  sl.registerFactory(() => BarberTourCubit());
}
