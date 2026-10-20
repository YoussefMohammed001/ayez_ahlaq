import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/entities/booking.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/entities/booking_status.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/repos/i_barber_booking_repo.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/advance_booking_status_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/confirm_booking_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/create_walk_in_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/get_booking_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/get_bookings_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/get_pending_bookings_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/get_queue_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/reject_booking_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/domain/use_cases/update_booking_billing_use_case.dart';
import 'package:ayez_ahlaq/features/barber/bookings/presentation/manager/bookings_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

Booking booking(int id, BookingStatus status) => Booking(
  id: id,
  code: 'B$id',
  status: status,
  barberId: 1,
  barberName: 'barber',
  customerId: 1,
  customerName: 'customer',
  customerPhone: '01000000000',
  serviceTypeId: 1,
  serviceLabel: 'cut',
  basePrice: 100,
  styleDelta: 0,
  addonsTotal: 0,
  totalPrice: 100,
  durationMinutes: 30,
  bookingDate: '2026-10-20',
  slotTime: '10:00',
  paymentMethod: 'CASH',
  autoSelect: false,
  walkIn: false,
  nextStatuses: const [],
  addons: const [],
);

class FakeBarberBookingRepo extends Fake implements IBarberBookingRepo {
  int queueLoads = 0;

  @override
  Future<Either<Failure, List<Booking>>> getPendingBookings() => Future.value(
    Right([
      booking(1, BookingStatus.pending),
      booking(2, BookingStatus.pending),
    ]),
  );

  @override
  Future<Either<Failure, List<Booking>>> getQueue(String date) {
    queueLoads++;
    return Future.value(Right([booking(1, BookingStatus.confirmed)]));
  }

  @override
  Future<Either<Failure, Booking>> confirmBooking(int id) =>
      Future.value(Right(booking(id, BookingStatus.confirmed)));

  @override
  Future<Either<Failure, Booking>> rejectBooking(int id, String reason) =>
      Future.value(Right(booking(id, BookingStatus.rejected)));
}

BookingsCubit buildCubit(FakeBarberBookingRepo repo) => BookingsCubit(
  GetPendingBookingsUseCase(repo),
  GetQueueUseCase(repo),
  GetBookingsUseCase(repo),
  GetBookingUseCase(repo),
  ConfirmBookingUseCase(repo),
  RejectBookingUseCase(repo),
  AdvanceBookingStatusUseCase(repo),
  CreateWalkInUseCase(repo),
  UpdateBookingBillingUseCase(repo),
);

void main() {
  setUpAll(() => initializeDateFormatting('en'));

  test('a confirmed booking leaves Pending and the queue is refreshed', () async {
    final repo = FakeBarberBookingRepo();
    final cubit = buildCubit(repo);
    await cubit.loadPending();

    await cubit.confirmBooking(1);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.pending.map((b) => b.id), [2]);
    expect(repo.queueLoads, 1);
  });

  test('a rejected booking leaves Pending without touching the queue', () async {
    final repo = FakeBarberBookingRepo();
    final cubit = buildCubit(repo);
    await cubit.loadPending();

    await cubit.rejectBooking(2, 'busy');

    expect(cubit.state.pending.map((b) => b.id), [1]);
  });
}
