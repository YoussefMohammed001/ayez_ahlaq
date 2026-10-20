import '../../../features/barber/bookings/data/apis/barber_booking_api.dart';
import '../../../features/barber/bookings/data/repos/barber_booking_repo.dart';
import '../../../features/barber/bookings/domain/repos/i_barber_booking_repo.dart';
import '../../../features/barber/bookings/domain/use_cases/advance_booking_status_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/confirm_booking_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/create_walk_in_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/update_booking_billing_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/get_booking_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/get_bookings_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/get_pending_bookings_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/get_queue_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/get_unresolved_bookings_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/get_walk_in_options_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/reject_booking_use_case.dart';
import '../../../features/barber/bookings/domain/use_cases/settle_bookings_use_case.dart';
import '../../../features/barber/bookings/presentation/manager/bookings_cubit.dart';
import '../../../features/barber/bookings/presentation/manager/unresolved_bookings_cubit.dart';
import '../../../features/barber/bookings/presentation/manager/walk_in_options_cubit.dart';
import '../sl.dart';

void registerBarberBookings() {
  sl.registerLazySingleton(() => BarberBookingApi(sl()));
  sl.registerLazySingleton<IBarberBookingRepo>(() => BarberBookingRepo(sl()));
  sl.registerLazySingleton(() => GetBookingsUseCase(sl()));
  sl.registerLazySingleton(() => GetPendingBookingsUseCase(sl()));
  sl.registerLazySingleton(() => GetQueueUseCase(sl()));
  sl.registerLazySingleton(() => GetBookingUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmBookingUseCase(sl()));
  sl.registerLazySingleton(() => RejectBookingUseCase(sl()));
  sl.registerLazySingleton(() => AdvanceBookingStatusUseCase(sl()));
  sl.registerLazySingleton(() => CreateWalkInUseCase(sl()));
  sl.registerLazySingleton(() => UpdateBookingBillingUseCase(sl()));
  sl.registerLazySingleton(() => GetWalkInOptionsUseCase(sl()));
  sl.registerLazySingleton(() => GetUnresolvedBookingsUseCase(sl()));
  sl.registerLazySingleton(() => SettleBookingsUseCase(sl()));
  sl.registerFactory(
    () => BookingsCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(() => WalkInOptionsCubit(sl()));
  sl.registerFactory(() => UnresolvedBookingsCubit(sl(), sl()));
}
