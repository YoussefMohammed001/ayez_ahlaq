import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/entities/customer_booking.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/entities/customer_booking_status.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/repos/i_customer_booking_repo.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/cancel_booking_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/get_booking_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/get_bookings_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/rate_booking_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/presentation/manager/booking_detail_cubit.dart';
import 'package:ayez_ahlaq/features/customer/booking/presentation/manager/my_bookings_cubit.dart';
import 'package:ayez_ahlaq/features/customer/booking/presentation/widgets/booking_list_sync.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

CustomerBooking booking(int id, CustomerBookingStatus status) =>
    CustomerBooking(
      id: id,
      code: 'B$id',
      status: status,
      shopId: 1,
      shopName: 'shop',
      barberId: 1,
      barberName: 'barber',
      serviceLabel: 'cut',
      totalPrice: 100,
      bookingDate: '2026-10-20',
      slotTime: '10:00',
      paymentMethod: 'CASH',
      ratedBarber: false,
      ratedShop: false,
    );

class FakeBookingRepo extends Fake implements ICustomerBookingRepo {
  @override
  Future<Either<Failure, List<CustomerBooking>>> getBookings() => Future.value(
    Right([
      booking(1, CustomerBookingStatus.pending),
      booking(2, CustomerBookingStatus.pending),
    ]),
  );

  @override
  Future<Either<Failure, CustomerBooking>> getBooking(int id) =>
      Future.value(Right(booking(id, CustomerBookingStatus.pending)));

  @override
  Future<Either<Failure, CustomerBooking>> cancelBooking(int id) =>
      Future.value(Right(booking(id, CustomerBookingStatus.cancelled)));
}

void main() {
  testWidgets('cancelling from the details updates the bookings list', (
    tester,
  ) async {
    final repo = FakeBookingRepo();
    final list = MyBookingsCubit(GetBookingsUseCase(repo));
    final detail = BookingDetailCubit(
      GetBookingUseCase(repo),
      CancelBookingUseCase(repo),
      RateBookingUseCase(repo),
    );
    await list.loadBookings();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: detail),
          BlocProvider.value(value: list),
        ],
        child: const BookingListSync(child: SizedBox()),
      ),
    );

    await detail.loadBooking(1);
    await detail.cancelBooking(1);
    await tester.pump();

    expect(list.state.bookings.first.status, CustomerBookingStatus.cancelled);
    expect(list.state.bookings.last.status, CustomerBookingStatus.pending);
  });
}
