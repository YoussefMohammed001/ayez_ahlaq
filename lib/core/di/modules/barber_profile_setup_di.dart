import '../../../features/barber/profile_setup/data/profile_setup_prefs_store.dart';
import '../../../features/barber/profile_setup/domain/repos/i_profile_setup_store.dart';
import '../../../features/barber/profile_setup/domain/use_cases/get_profile_setup_snapshot_use_case.dart';
import '../../../features/barber/profile_setup/presentation/manager/profile_setup_cubit.dart';
import '../../../features/barber/tour/presentation/manager/barber_tour_cubit.dart';
import '../sl.dart';

void registerBarberProfileSetup() {
  sl.registerLazySingleton<IProfileSetupStore>(
    () => ProfileSetupPrefsStore(sl()),
  );
  sl.registerLazySingleton(
    () => GetProfileSetupSnapshotUseCase(sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(() => ProfileSetupCubit(sl(), sl(), sl()));
  sl.registerFactory(() => BarberTourCubit());
}
