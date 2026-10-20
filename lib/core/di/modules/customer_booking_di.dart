import '../../../features/customer/booking/data/apis/customer_booking_api.dart';
import '../../../features/customer/booking/data/repos/customer_booking_repo.dart';
import '../../../features/customer/booking/domain/repos/i_customer_booking_repo.dart';
import '../../../features/customer/booking/domain/use_cases/cancel_booking_use_case.dart';
import '../../../features/customer/booking/domain/use_cases/create_booking_use_case.dart';
import '../../../features/customer/booking/domain/use_cases/get_booking_slots_use_case.dart';
import '../../../features/customer/booking/domain/use_cases/get_booking_use_case.dart'
    as customer_booking;
import '../../../features/customer/booking/domain/use_cases/get_bookings_use_case.dart'
    as customer_booking;
import '../../../features/customer/booking/domain/use_cases/rate_booking_use_case.dart';
import '../../../features/customer/booking/presentation/manager/booking_detail_cubit.dart';
import '../../../features/customer/booking/presentation/manager/booking_flow_cubit.dart';
import '../../../features/customer/booking/presentation/manager/my_bookings_cubit.dart';
import '../sl.dart';

void registerCustomerBooking() {
  sl.registerLazySingleton(() => CustomerBookingApi(sl()));
  sl.registerLazySingleton<ICustomerBookingRepo>(
    () => CustomerBookingRepo(sl()),
  );
  sl.registerLazySingleton(() => GetBookingSlotsUseCase(sl()));
  sl.registerLazySingleton(() => CreateBookingUseCase(sl()));
  sl.registerLazySingleton(() => customer_booking.GetBookingsUseCase(sl()));
  sl.registerLazySingleton(() => customer_booking.GetBookingUseCase(sl()));
  sl.registerLazySingleton(() => CancelBookingUseCase(sl()));
  sl.registerLazySingleton(() => RateBookingUseCase(sl()));
  sl.registerFactory(() => BookingFlowCubit(sl(), sl(), sl()));
  sl.registerFactory(() => MyBookingsCubit(sl()));
  sl.registerFactory(() => BookingDetailCubit(sl(), sl(), sl()));
}
