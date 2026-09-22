import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/unresolved_bookings_page.dart';
import '../repos/i_barber_booking_repo.dart';

class GetUnresolvedBookingsUseCase {
  final IBarberBookingRepo _repo;

  GetUnresolvedBookingsUseCase(this._repo);

  Future<Either<Failure, UnresolvedBookingsPage>> call({
    required int page,
    required int size,
  }) => _repo.getUnresolvedBookings(page: page, size: size);
}
