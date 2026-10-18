import 'dart:async';

import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/entities/booking_slots.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/repos/i_customer_booking_repo.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/create_booking_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/get_booking_slots_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/domain/use_cases/get_bookings_use_case.dart';
import 'package:ayez_ahlaq/features/customer/booking/presentation/manager/booking_flow_cubit.dart';
import 'package:ayez_ahlaq/features/customer/booking/presentation/manager/booking_flow_state.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop.dart';
import 'package:ayez_ahlaq/features/customer/shops/domain/entities/shop_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

BookingSlots slotsFor(String date) => BookingSlots(
  date: date,
  serviceTypeId: 1,
  perBarber: const [],
  anyBarberSlots: ['10:00-$date'],
);

class FakeBookingRepo extends Fake implements ICustomerBookingRepo {
  final pending = <String, Completer<Either<Failure, BookingSlots>>>{};

  @override
  Future<Either<Failure, BookingSlots>> getSlots({
    required int shopId,
    required int serviceTypeId,
    required String date,
  }) {
    final completer = pending[date];
    if (completer != null) return completer.future;
    return Future.value(Right(slotsFor(date)));
  }
}

BookingFlowCubit startedCubit(FakeBookingRepo repo) {
  return BookingFlowCubit(
    GetBookingSlotsUseCase(repo),
    CreateBookingUseCase(repo),
    GetBookingsUseCase(repo),
  )
    ..startFlow(
      const ShopDetail(
        shop: Shop(id: 1, name: 'shop', favorite: false, rating: 0, ratingCount: 0),
        barbers: [],
        haircutStyles: [],
        paymentMethods: [],
        addons: [],
      ),
    )
    ..selectService(serviceTypeId: 1, serviceName: 'cut', price: 100);
}

void main() {
  test('slots of a date the user already left are ignored', () async {
    final repo = FakeBookingRepo();
    repo.pending['2026-10-20'] = Completer();
    final cubit = startedCubit(repo);

    final slow = cubit.loadSlots('2026-10-20');
    await cubit.loadSlots('2026-10-21');
    repo.pending['2026-10-20']!.complete(Right(slotsFor('2026-10-20')));
    await slow;

    expect(cubit.state.date, '2026-10-21');
    expect(cubit.state.slots?.date, '2026-10-21');
  });

  test('changing the date clears the previously picked slot', () async {
    final cubit = startedCubit(FakeBookingRepo());
    await cubit.loadSlots('2026-10-20');
    cubit.selectSlotTime('10:00');

    final next = cubit.loadSlots('2026-10-21');

    expect(cubit.state.slotTime, isNull);
    expect(cubit.state.slots, isNull);
    expect(cubit.state.status, BookingFlowStatus.loadingSlots);
    await next;
  });
}
